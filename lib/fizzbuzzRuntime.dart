class fizz_buzz_player
{
  // User variable instantiation
  String name = "";
  int lives = 3;
  int persistentLives = 3;
  int difficulty = 1;
  bool hasLost = false;

  // This int will be set in the following manner
  // 0 - None
  // 1 - Fizz
  // 2 - Buzz
  // 3 - FizzBuzz
  int fizzOrBuzz = 0;

  // fizz buzz player constructor
  fizz_buzz_player(this.name, this.lives, this.difficulty)
  {
    persistentLives = lives;
  }

  // Reduces a life if the player gets an answer wrong
  void reduceLife()
  {
    // Reduce lives by 1
    lives = lives - 1;

    // determine if the user has lost
    userHasLost();
  }

  // Determines if the player is in a "loosing state"
  void userHasLost()
  {
    if (lives == 0)
    {
      hasLost = true;
    }
    else
    {
      hasLost = false;
    }
  }

  // Determine if the player is correct or not
  bool determinePlayerCorrectness(int number, int playerGuess)
  {
    determineFizzBuzz(number);

    if(playerGuess != fizzOrBuzz)
    {
      reduceLife();

      return false;
    }

    return true;
  }

  // Determines of the given value is Fizz, Buzz, or FizzBuzz
  void determineFizzBuzz(int numberToCalc)
  {
    if (numberToCalc % 3 == 0 && numberToCalc % 5 == 0)
    {
      fizzOrBuzz = 3;
    }
    else if (numberToCalc % 3 == 0)
    {
      fizzOrBuzz = 1;
    }
    else if (numberToCalc % 5 == 0)
    {
      fizzOrBuzz =  2;
    }
    else
    {
      fizzOrBuzz = 0;
    }
  }

  // Turn the string into a number that is then used to determine if the user was right
  int inputConditioning(String answer)
  {
    answer = answer.toLowerCase();

    switch (answer)
    {
      case 'fizz': return 1;
      case 'buzz': return 2;
      case 'fizzbuzz': return 3;
      default: return 0;
    }
  }

  // Restarts the game
  void beginAgain()
  {
    lives = persistentLives;
    userHasLost();
  }
}