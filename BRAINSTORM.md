# Planning Process

Starting this coding challenge, my thought was we want to make the application testable. Instead of building the application in a functional programming style, it would be better to build it using an object-oriented approach using a custom class. Classes are very easy to test, especially if we use the testing suite, RSpec.

Since this project was focused more on a input/output approach, I broke it down to 3 steps:

First, read the file that is to be parsed and store its data in a class variable for later use. I thought the best variable name for storing the input file’s data was @@games since we know that the data is about soccer games. We would first have to find out how many teams there are. Then we could find out how many games there are in each match day.

Second, we want to then format the the input file’s data into a structure that would be easy to iterate through. I thought that transforming the data into a JSON-like object would be perfect to use because JSON is very organized, and easy to traverse to grab the value’s you may need. We would store the JSON-like object in a class variable called @@matches to access throughout the class itself.

Finally, we then want to use the JSON-like object to log the matchday results for the highest scoring teams for each matchday. We would iterate through the class variable @@matches, do some business logic, and write to a file for each match day. That would be the final step to the process of this application.
