import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int counter;

  CounterWidget({this.counter});

  @override
  _CounterWidget createState() {
    return new _CounterWidget(this.counter);
  }
}

class _CounterWidget extends State<CounterWidget> {
  int _counter;

  _CounterWidget(this._counter);

  @override
  void initState() {
    super.initState();
  }

  void _increment() {
    if(_counter < 100) {
      setState(() {
        _counter++;
      });
    }
  }

  void _decrement() {
    if(_counter >= 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
          child: const Text('-'),
          onPressed: () => _decrement(),
        ),
        new Center(
          child: new Text('$_counter'),
        ),
        new RaisedButton(
          child: const Text('+'),
          onPressed: () => _increment(),
        ),
      ],
    );
  }
}