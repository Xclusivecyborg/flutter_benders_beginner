import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  color: Colors.black26,
                  height: 300,
                  width: 300,
                  child: Text("This is container 1"),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    color: Colors.blueGrey,
                    height: 200,
                    width: 200,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    color: Colors.blueGrey,
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  color: Colors.black26,
                  height: 300,
                  width: 300,
                  child: Text("This is container 1"),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  color: Colors.black26,
                  height: 300,
                  width: 300,
                  child: Text("This is container 1"),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(40),
                  color: Colors.black26,
                  height: 300,
                  width: 300,
                  child: Text("This is container 1"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//Task 1: Ensure the text is aligned to the center of the container.
//Task 2: Fix the overflow error on the Row widget in line 54. 

