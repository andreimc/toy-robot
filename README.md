# toy-robot

A simulator of a toy robot, moving around a table

## Introduction

This application simulates a toy robot, moving about a table of 5x5 squares. The robot can be placed, move, turn and report it's location. It will never move off the table, and must be placed before it will respond to additional commands.

## Installation 

Ensure you have [Git](http://git-scm.com/downloads) and [Ruby 2+](http://www.ruby-lang.org/en/downloads/) installed. Then run:

    cd toy-robot
    gem install bundler
    bundle install

## Execution

To run the simulator, execute:

    ./bin/toy_robot.rb [instructions.txt]

The instructions can be provided either via an optional file, or fed directly into STDIN if no file is specified.

## Testing

The run the unit tests, ensuring each part of the application is behaving as expected, run:

    bundle exec rake 

You can check the code coverage afterwards by opening the generated report
  
    open coverage/index.html
