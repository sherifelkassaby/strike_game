# Strike Game

## Description

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2be19a86-cba8-485a-8f0a-0d519a843474/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2be19a86-cba8-485a-8f0a-0d519a843474/Untitled.png)

Role play terminal game to spend your time in a better way.

When the player enters the game he will be in `level 1` each level has three rooms each room has challenge in it. The player needs to pass all the three rooms to access the next level. The player can navigate freely from his level to previous levels. if the room has monster the passing of the room will be random.

## How To Start

### Prerequisites

- Ruby installed on the system
- Bundler installed on the system

```bash
bundle install
ruby main.rb
```

## About the Project

`main.rb` is the entrance file for the application which is calling the game init service and game start service. The project is tested with RSpec.

These are the relation between models in the application.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fe0f439e-79bd-4477-bbb2-9a0d7a700ef5/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fe0f439e-79bd-4477-bbb2-9a0d7a700ef5/Untitled.png)

## Future Enhancements

- Increase the test coverage

    Due to time constraint of the task didn't achieve 100% test coverage

- Implement database

    So as the user may login and continue previous game

- Add strength to the player and monsters

    Each level should have more stronger monsters, depending on the player strength the monster can be killed or beat the player

- Implement award system

    Awards can be obtained after finishing a challenge

- Implement CI to run the test cases after each push