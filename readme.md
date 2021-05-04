# Strike Game

## Description

![https://i.ibb.co/8KkTWjV/terminal.png](https://i.ibb.co/8KkTWjV/terminal.png)

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

![https://i.ibb.co/ZH99JX0/game-structure.png](https://i.ibb.co/ZH99JX0/game-structure.png)

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