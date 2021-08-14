//hola
import 'dart:async';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  final _random = new Random();
  int score = 0;
  bool red = false;

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }

    setState(() {
      _theState = randomItem;
      _actualWordType = option;
    });
  }

  void _onPressed(int option) {
    if (option == _actualWordType) {
      print("bien");
      score += 1;
      red = false;
    } else {
      score = 0;
      red = true;
    }
    setRandomWord();
  }

  void _onReset() {
    score = 0;
    setRandomWord();
    red = false;
  }

  @override
  Widget build(BuildContext context) {
    setRandomWord();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Random Words!"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "SCORE: $score",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Text(
            "$_theState",
            style: TextStyle(
              color: red ? Colors.red : Colors.purple,
              fontSize: 24,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _onPressed(0),
                child: Text("Noun"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple, onPrimary: Colors.yellowAccent),
              ),
              ElevatedButton(
                  onPressed: () => _onPressed(1),
                  child: Text("Adjective"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple, onPrimary: Colors.yellowAccent))
            ],
          ),
          //ElevatedButton(onPressed: () => _onReset(), child: Text("Reset")),
          IconButton(
              onPressed: () => _onReset(),
              icon: Icon(Icons.autorenew, color: Colors.pinkAccent))
        ],
      ),
    );
  }
}
