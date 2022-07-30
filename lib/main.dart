import 'package:flutter/material.dart';
import 'fizzbuzzRuntime.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget 
{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  // Establish basic game params
  List<String> livesStates = ['assets/Life.png', 'assets/Life.png', 'assets/Life.png'];
  int myNum = 1;
  String rightOrWrong = 'Correct!';
  bool isVisible = false;
  bool isRight = false;
  Color mainButtColor = Color.fromARGB(255, 5, 100, 179);
  Color disabledColor = Color.fromARGB(234, 71, 76, 80);
  Color currentColor = Color.fromARGB(255, 5, 100, 179);

  // Instantiate a FizzBuzz Player
  fizz_buzz_player myPlayer = new fizz_buzz_player("My FizzBuzz Player", 3, 0);

  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('FizzBuzz Math Challenge'
        ),
        backgroundColor: Color.fromARGB(255, 24, 22, 22),
        centerTitle: true,
      ),
        body: 
            Column(
              children: <Widget>[

              // Designates Life Bar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(livesStates[0]
                    ),
                  ),
                ),
              ),
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(livesStates[1]
                    ),
                  ),
                ),
              ),
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(livesStates[2]
                    ),
                  ),
                ),
              ),
              ]
              ),

              // Designates Number Value
              Divider(
                thickness: 5,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(5.0),
              ),
              Text("Number",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35.0
                ), 
              ),
              Text('$myNum',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35.0
                ), 
              ),
              Visibility(child:
                Text('$rightOrWrong',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35.0
                  ),
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: isVisible,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
              ),

              // Designates Buttons
              // Fizz Button
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: RaisedButton(
                    onPressed: () => disableIfLost(1),
                    child: Text("Fizz",
                        style: const TextStyle( 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35.0,
                        letterSpacing: 3.0
                      ),                    
                    ),
                    color: currentColor
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
              ),

              // Buzz Button
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: RaisedButton(
                    onPressed: () => disableIfLost(2),
                    child: Text("Buzz",
                        style: const TextStyle( 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35.0,
                        letterSpacing: 3.0
                      ),                    
                    ),
                    color: currentColor
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
              ),

              // FizzBuzz Button
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: RaisedButton(
                    onPressed: () => disableIfLost(3),
                    child: Text("FizzBuzz",
                        style: const TextStyle( 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35.0,
                        letterSpacing: 3.0
                      ),                    
                    ),
                    color: currentColor
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
              ),

              // None Button
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: RaisedButton(
                    onPressed: () => disableIfLost(0),
                    child: Text("None",
                        style: const TextStyle( 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35.0,
                        letterSpacing: 3.0
                      ),                    
                    ),
                    color: currentColor
                ),
              ),

              Container(
                padding: EdgeInsets.all(25.0),
              ),

              // Restart Button
              SizedBox(
                width:150.0,
                height: 25.0,
                child: RaisedButton(
                    onPressed: gameReset,
                    child: Text("Restart",
                        style: const TextStyle( 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 3.0
                      ),                    
                    ),
                    color: Colors.grey[450]
                ),
              ),

            ],
      ),
    );
  }

  void disableIfLost(playerGuess)
  {

    if (myPlayer.hasLost)
    {
      return null;
    }
    
    return determineCorrectness(playerGuess);
  }

  // Determines if the User is Correct
  void determineCorrectness(playerGuess)
  {
    isRight = myPlayer.determinePlayerCorrectness(myNum, playerGuess);

    if(isRight)
    {
      rightOrWrong = 'Correct!';
      showAffirmation();
    }
    else
    {
      rightOrWrong = 'Incorrect!';
      setState(() {
        livesStates[myPlayer.lives] = 'assets/Life_Lost.png';
      });
      showAffirmation();
    }

    setState(() {
      if(myPlayer.hasLost)
      {
        currentColor = disabledColor;
        rightOrWrong = 'Game Over!';
      }
      else
      {
        myNum++;
      }
    });
  }

  // Make Affirmation Visible if It's Not
  void showAffirmation()
  {
    if(!isVisible)
    {
      setState(() {
        isVisible = true;
      });
    }
  }

  // This Function Restarts the Game
  void gameReset()
  {
    setState(() {
      livesStates = ['assets/Life.png', 'assets/Life.png', 'assets/Life.png'];
      myNum = 1;
      isVisible = false;
      currentColor = mainButtColor;

      myPlayer.beginAgain();
    });
  }

}