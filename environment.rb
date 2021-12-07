require_relative "./lib/mastermind.rb"
require_relative "./lib/random.rb"
require_relative "./lib/game.rb"
require_relative "./lib/game_api.rb"
require_relative "./lib/player.rb"

require "net/http"
require "pry"
require "colorize"
require "json"

#Address of game_api Rails server
$server = "http://127.0.0.1:3000"

#Rules of game for "Learn to play" main menu option
$learn =["You want to play Mastermind? I will teach you my game...\n",
        "You can play my game on 3 difficulties, easy, medium, or hard.",
        "The objective of the game is to guess my secret code.",
        "My code is 3 digits on easy, 4 on medium, and 5 on hard.",
        "You have 8 guesses on easy, 10 on medium, and 12 on hard.",
        "After each guess I will give you feedback consisting of the number...",
        "...of correct digits, and the number of correctly located digits.",
        "Guess 'G', and I will show you your previous guesses with feedback."
        "If you guess the code correctly, you win!",
        "If you win, you will earn points based on the number of remaining...",
        "...guesses, with a multiplier for the difficulty.",
        "Be sure to use the player menu to sign up and sign in when you play.",
        "This way your stats are saved between play sessions.",
        "If you earn enough points, you too may become a MASTERMIND!"
        ]