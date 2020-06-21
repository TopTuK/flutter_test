import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_bloc/main.dart';

class DataCounter {
  BehaviorSubject _counter = new BehaviorSubject.seeded(42);

  get stream$ => _counter.stream;
  int get counter => _counter.value;

  void increment() {
    _counter.add(counter + 1);
  }

  void decrement() {
    _counter.add(counter - 1);
  }
}

class RxDartScreen extends StatelessWidget {
  final DataCounter _dataCounter = sl.get<DataCounter>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('RxDart Screen'),
      ),
      body: new StreamBuilder(
        stream: _dataCounter.stream$,
        builder: (BuildContext ctx, AsyncSnapshot snap) {
          return new Row(
            children: <Widget>[
              new RaisedButton(
                child: const Text('-'),
                onPressed: () => _dataCounter.decrement(),
              ),
              new Center(
                child: new Text('${snap.data}'),
              ),
              new RaisedButton(
                child: const Text('+'),
                onPressed: () => _dataCounter.increment(),
              ),
            ],
          );
        }
      ),
      floatingActionButton: null,
    );
  }
}