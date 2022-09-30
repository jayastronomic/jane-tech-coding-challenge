# Planning Process

Starting this coding challenge, my thought was I want to make the application testable. Instead of building the application in a functional programming style, it would be better to build it using an object-oriented approach using a custom class. Classes are very easy to test, especially if I use the testing suite, RSpec.

Since this project was focused more on a input/output approach, I broke it down to 3 steps:

First, read the file that is to be parsed and store its data in a class variable for later use. I thought the best variable name for storing the input file’s data was `@@games` since I know that the data is about soccer games. To find out how many total matches, I would first have to find out how many teams there are. Then I could find out how many games there are in each match day.

Second, I want to then format the the input file’s data into a structure that would be easy to iterate through. I thought that transforming the data into a JSON-like object would be perfect to use because JSON is very organized, and easy to traverse so that I can grab the values I may need. I would store the JSON-like object in a class variable called `@@matches` to access throughout the class itself for later use.

Finally, I then want to use the JSON-like object to log the matchday results for the highest scoring teams for each matchday. I would iterate through each match using the class variable `@@matches`, do some business logic, and write to a file for each match day. That would be the final step to the process of this application.

Back to [README](README.md)
