import 'dart:math';

import 'package:flutter/material.dart';

/// This function checks if the number is a square.
bool isSquare(int number) {
  if(sqrt(number) == sqrt(number).floor()){
    return true;
  } else {
    return false;
  }
}

/// This function checks if the number is a cube.
bool isCube(int number) {
  var i = 0;
  while(i*i*i< number) {
    i++;
  }
  if(i*i*i==number) {
    return true;
  } else {
    return false;
  }
}


void main() {
  runApp(const CubesAndSquaresChecker());
}
///This is the main widget of our app
class CubesAndSquaresChecker extends StatelessWidget {
  ///This is the constructor for our main widget
  const CubesAndSquaresChecker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checker for squares and cubes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
///This is the home page our app and the only page
class MainPage extends StatefulWidget {
  ///This is the constructor for the main page
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<dynamic> openDialog(int number, String messageForDialog) =>
      showDialog(context: context, builder: (context) =>
          AlertDialog(title: Text('$number'), content: Text(messageForDialog)),);

  TextEditingController numberTextFieldController = TextEditingController();
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Number Shapes')),
      ),
      body:Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            const Text('Please enter a number to see if it is a square or a cube.',
              style: TextStyle(fontSize: 20),),
            TextField(
              controller: numberTextFieldController,
              decoration: InputDecoration(errorText: errorText),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          final number = int.tryParse(numberTextFieldController.text);
          if (number == null || number < 0){
            errorText = 'This is not a valid number.';
          } else {
            errorText = null;
            var messageForDialog = 'Number $number is neither square nor cube.';
            if (isSquare(number) && isCube(number)) {
              messageForDialog = 'Number $number is both square and cube.';
            } else if (isSquare(number)) {
              messageForDialog = 'Number $number is a square.';
            } else if (isCube(number)) {
              messageForDialog = 'Number $number is a cube.';
            }
            openDialog(number, messageForDialog);
          }
        });
      }, child: const Icon(Icons.check),),
    );
  }
}
