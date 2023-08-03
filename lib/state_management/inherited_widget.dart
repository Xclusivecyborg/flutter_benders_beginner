import 'package:flutter/material.dart';

//WIDGET 1
//WE HAVE WIDGET 1 to 1000;
class InheritedWidgetExample extends StatefulWidget {
  const InheritedWidgetExample({super.key});

  @override
  State<InheritedWidgetExample> createState() => _InheritedWidgetExampleState();
}

class _InheritedWidgetExampleState extends State<InheritedWidgetExample> {
  int age = 12;

  void incremementAge() {
    setState(() {
      age++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return InheritedWidgetState(
      age: age,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inherited Widget Example'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Counter(),
              Counter2(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: incremementAge,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Counter2 extends StatelessWidget {
  const Counter2({super.key});

  @override
  Widget build(BuildContext context) {

    final inheritedState = InheritedWidgetState.of(context);
    return Text(
      '${inheritedState.age}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedState = InheritedWidgetState.of(context);
    return Center(
      child: Text(
        '${inheritedState.age}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}


//This class extends the inherited widget class
//This class is used to pass the data to the child widget

class InheritedWidgetState extends InheritedWidget {
  final int age;
  const InheritedWidgetState({
    Key? key,
    required Widget child,
    required this.age,
  }) : super(key: key, child: child);

//This method is used to check if the data has changed
//If the data has changed then the widget will be rebuilt
  @override
  bool updateShouldNotify(covariant InheritedWidgetState oldWidget) {
    return oldWidget.age != age;
  }

// This method gives us a way to access the inherited widget from the child widget
//And it provides a singleton instance of the inherited widget
  static InheritedWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedWidgetState>()!;
  }
}
