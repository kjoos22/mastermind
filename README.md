# Mastermind

A CLI game that is a recreation of the classic board game "Mastermind". The objective of the game is to guess the secret code (3, 4 or 5 digits long, numbers 0-7) within the round limit. The game can be played on 3 different difficulty settings. After each guess the player will receive feedback on the number of correct digits and the number of correctly located digits. The game has an associated database for storing players and their statistics, and will display the top 5 players of all time.

## Extensions
This version contains the following features beyond the base project prompt:
1. Selectable difficulties of easy, medium and hard which are 3 digit codes in 8 rounds, 4 digit codes in 10 rounds, and 5 digit codes in 12 rounds, respectively.
2. Associated Rails based backend for storing players and their stats between play sessions.
3. Ability to sign up/in/out.
4. Ability to review currently signed in player's stats, rank (detailed bellow), and top 5 players of all time.
5. Ability to view game rules.

## Scoring and Player Ranks
Upon winning, players earn points based on the number of guessess remaining and a difficulty multiplier. The formula is:

number of guesses remaining * difficulty multiplier

With difficulty multipliers being 1, 2 and 3 for easy, medium, and hard, respectively.

Ex. Winning with 4 guesses remaining on medium will give 8 points.

Players can see their current rank by viewing their stats in the Player Menu.
Ranks are based on their lifetime point earnings.
0-9 points: Feeblemind
10-49 points: Averagemind
50-99 points: Strongmind
100+ points: Mastermind

## Installation
To install the program, run the following:

```bash
git clone git@github.com:kjoos22/mastermind.git
```
Navigate to the root directory and run:

```bash
bundle install
```

Navigate to the game_api directory and again run:
```bash
bundle install
```

## Configuring database
To configure the database, run the following from the game_api directory:

```bash
rails db:migrate
```

## Launching the program
Once installed, navigate to the game_api directory and launch the backend via:

```bash
rails s
```

Navigate back to the root directory and start the game via:

Windows:
```bash
ruby bin/run.rb
```

This will then start the game in your console.

## Code Structure
//lib/mastermind.rb - contains code for:
1. Game menus.
2. Getting user input.
3. Base gameplay loop of stating current round, getting player's guess, and passing guess to game engine.

//lib/game.rb - contains game engine code for:
1. Creating a game with current gamestate.
2. Checking player's guess.
3. Generating, storing, and providing feedback on player's guess.

//lib/random.rb - contains code for:
1. Retrieving and storing code from Random Generator API (https://www.random.org/clients/http/api) of appropriate length for game difficulty.

//lib/player.rb - contains code for:
1. Creating players.
2. Signing up new players.
3. Signing in returning players.
4. Signing out current player.
5. Displaying top 5 players of all time.
6. Displaying or updating current player's stats.
7. Determining current player's rank.

//lib/game_api.rb - contains code for:
1. Sending and retrieving data from Rails based database for players and their stats.

//game_api - contains code for:
1. Rails based database for players and their stats that are persistent between play sessions.

## Potential Future Features
1. Review currently signed in player's match history.
2. Challenge mode(s) - scaling difficulties, timed games and/or rounds.
3. Non-commandline interface.
4. Alternate modes - colors in lieu of numbers.

## License
https://github.com/kjoos22/mastermind/blob/main/LICENSE.txt