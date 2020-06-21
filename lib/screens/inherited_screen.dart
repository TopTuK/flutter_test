import 'package:flutter/material.dart';

class InheritedCounterWidget extends InheritedWidget {
  final Map _data = { 'counter': 0 };

  final Widget child;

  InheritedCounterWidget({this.child}) : super(child: child);

  void increment() {
    _data['counter']++;
  }

  int get counter => _data['counter'];

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static InheritedCounterWidget of(BuildContext ctx) => ctx.dependOnInheritedWidgetOfExactType<InheritedCounterWidget>();
}

class InheritedCounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StatefulBuilder(
      builder: (BuildContext ctx, StateSetter setState) {
        int counter = InheritedCounterWidget.of(ctx).counter;
        Function increment = InheritedCounterWidget.of(ctx).increment;

        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Inherited widget'),
          ),
          body: new Center(child: new Text('$counter')),
          floatingActionButton: new FloatingActionButton(
            onPressed: () => setState(() => increment()),
          ),
        );
      }
    );
  }
}