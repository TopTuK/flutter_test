import 'package:flutter/material.dart';

class StatefuleBuilderScreen extends StatelessWidget {
  int _counter = 42;

  void _increment(StateSetter setState) {
    if(_counter < 100) {
      setState(() {
        _counter++;
      });
    }
  }

  void _decrement(StateSetter setState) {
    if(_counter >= 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (ctx, StateSetter setState) {
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('StatefulBuilder'),
          ),
          body: new Row(
            children: <Widget>[
              new RaisedButton(
                child: const Text('-'),
                onPressed: () => _decrement(setState),
              ),
              new Center(
                child: new Text('$_counter'),
              ),
              new RaisedButton(
                child: const Text('+'),
                onPressed: () => _increment(setState),
              ),
            ],
          ),
          floatingActionButton: null,
        ); 
      }
    );
  }
}