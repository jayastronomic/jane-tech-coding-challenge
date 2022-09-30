# frozen_string_literal: true

# warn_indent: true

class Challenge
  @@teams = {}
  @@game_results = []
  @@matches = []

  def self.run
    puts 'Type file input name:'
    fname = gets.chomp
    @@game_results = File.read(fname)
    Challenge.get_teams
    Challenge.to_json
    Challenge.log_matchday_results
  end

  private

  def self.get_teams
    # Whenever you read a file, it's input comes in as a string. The string inculdes newline '\n\' characters.
    # Since we know that one game is one line each, we want to take the input and split each game into their own element in
    # an array by the new line character.
    # Store the game reults in the class variable @@game_results which will be used later to transform into JSON 
    @@game_results = @@game_results.split("\n")
    # => ["San Jose Earthquakes 3, Santa Cruz Slugs 3", "Capitola Seahorses 1, Aptos FC 0", "Felton Lumberjacks 2, Monterey United 0", ...etc] 

    # We then want to seperate each team with their scores into a new array that has been flattened.
    teams_with_score = @@game_results.map { |game| game.split(', ') }.flatten
    # => ["San Jose Earthquakes 3", "Santa Cruz Slugs 3", "Capitola Seahorses 1", "Aptos FC 0", ..etc]

    # Next, we want to extract the scores from each team, leaving only the team names.
    # We also want to make sure their is no duplicates of each team to get the number of teams in the league
    # We then store the teams in the class variable @@teams
    @@teams = teams_with_score.map { |team_with_score| team_with_score.gsub!(/ \d+/, '')}.uniq
    # => ["San Jose Earthquakes", "Santa Cruz Slugs", "Capitola Seahorses", "Aptos FC", "Felton Lumberjacks", "Monterey United"]

    #Next we transform @@teams from an array to a hash that keeps the initial state of each teams accumalated points after each matchday.
    @@teams = @@teams.to_h { |team| [team, 0] }
    # => { "San Jose Earthquakes" => 0, "Santa Cruz Slugs" => 0, "Capitola Seahorses" => 0, "Aptos FC" => 0, "Felton Lumberjacks" => 0, "Monterey United" => 0 } 
  end

  def self.get_top_3
    #This class method transforms that hash (team => scores) to a sortable array of tuples that is descending in value based on scores
    @@teams = @@teams.sort_by { |key, value| value }.reverse
    #  => [["San Jose Earthquakes", 6], ["Aptos FC", 5], ["Santa Cruz Slugs", 4]] 

    # Sort again to make sure that if there is two or more teams with same score, make sure it's in alphabetical order ascending
    # Chose bubble sort
    swap = true
    score = 1
    name = 0
    while swap 
      swap = false
      (@@teams.length - 1).times do |team|
        if @@teams[team][score] == @@teams[team + 1][score]
          if @@teams[team][name] > @@teams[team + 1][name]
              @@teams[team], @@teams[team + 1] = @@teams[team + 1], @@teams[team]
              swap = true
          end
        end
      end
    end
    #Next we want to return the top 3 scores for the matchday
    @@teams[0..2]
  end

  def self.revert
    #This method reverts the @@teams array back into a hash that logs the teams with their scores
    @@teams = @@teams.to_h
    #  => { "San Jose Earthquakes"=> 6, "Aptos FC" => 5, "Santa Cruz Slugs" => 4 } 
  end

  def self.to_json
    # To find the delimiter of matchdays in the @@game_results data, we have to group the array elements into equal sub-arrays by diving the number of teams by 2.
    #We do that because each team only plays once per match day. Ex. 10 teams === 5 matchdays
    matches = @@game_results.each_slice(@@teams.length / 2).to_a

    # Here is where we create our nested JSON structure and store in the class variable @@matches
    matches.each.with_index(1) do |match, idx|
      @@matches << { "Matchday #{idx}" => 
        match.map { |game| game.split(', ') }.map do |game|
            { "#{game[0].gsub(/\s\d/, '')}" => "#{game[0].gsub(/[a-zA-z\s]/ , '')}".to_i,
              "#{game[1].gsub(/\s\d/, '')}" => "#{game[1].gsub(/[a-zA-z\s]/ , '')}".to_i,
            }
        end
      }
    end
  end

  def self.log_matchday_results
    #Write to a file to log the matchday results
    File.open('julians_output.txt', 'w') do |f|
      @@matches.each do |match|
        matchday = match.keys.join 
        f.write "#{matchday}\n"
        games = match[matchday] 
        games.each do |game|
          team_1 = game.keys[0] 
          team_2 = game.keys[1]
          if game[team_1] > game[team_2]
            @@teams[team_1] += 3
          elsif game[team_1] < game[team_2]
            @@teams[team_2] += 3
          else 
            @@teams[team_1] += 1
            @@teams[team_2] += 1
          end
        end
        # Get top 3 teams for matchday
        top_3 = Challenge.get_top_3
        (top_3.length).times do |i|
          f.write "#{top_3[i][0]}, #{top_3[i][1]} #{top_3[i][1] != 1 ? "pts" : "pt"}\n"
        end
        f.write "\n" 
        #revert @@teams back into a hash
        Challenge.revert
      end
    end
  end
end

Challenge.run