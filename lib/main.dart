import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:test_bloc/screens/stateful_screen.dart';
import 'package:test_bloc/screens/bloc_screen.dart';
import 'package:test_bloc/screens/inherited_screen.dart';
import 'package:test_bloc/screens/statefulbuilder_screen.dart';
import 'package:test_bloc/screens/rxdart_screen.dart';
import 'package:test_bloc/screens/scoped_model_screen.dart';

GetIt sl = GetIt.instance;

void main() {
  sl.registerSingleton<DataCounter>(DataCounter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainAppPage(title: 'Simple Flutter App',),
    );
  }
}

class MainAppPage extends StatelessWidget {
  final String title;

  MainAppPage({this.title});

  void _openStatefulScreen(BuildContext context) {
    Navigator.push(
      context, 
      new MaterialPageRoute(
        builder: (ctx) => new CounterWidget(counter: 42,)
      )
    );
  }

  void _openStatefulBuilderScreen(BuildContext context) {
    Navigator.push(
      context, 
      new MaterialPageRoute(
        builder: (ctx) => new StatefuleBuilderScreen()
      )
    );
  }

  void _openBlocScreen(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (ctx) => new BlocScreen()
      )
    );
  }

  void _openInheritedScreen(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (ctx) => InheritedCounterWidget(child: new InheritedCounterScreen(),)
      ),
    );
  }

  void _openRxScreen(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (ctx) => new RxDartScreen()
      )
    );
  }

  void _openScopedModelScreen(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (ctx) => new ScopedModelScreen()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: new Column(
        children: <Widget>[
          new Spacer(flex: 1,),
          new RaisedButton(
            child: const Text('Statefull Screen'),
            onPressed: () => _openStatefulScreen(context),
          ),
          new RaisedButton(
            child: const Text('StatefullBuilder Screen'),
            onPressed: () => _openStatefulBuilderScreen(context),
          ),
          new RaisedButton(
            child: const Text('BLOC Screen'),
            onPressed: () => _openBlocScreen(context),
          ),
          new RaisedButton(
            child: const Text('Inherited Screen'),
            onPressed: () => _openInheritedScreen(context),
          ),
          new RaisedButton(
            child: const Text('RX Screen'),
            onPressed: () => _openRxScreen(context),
          ),
          new RaisedButton(
            child: const Text('Scoped Model'),
            onPressed: () => _openScopedModelScreen(context),
          ),
          new Spacer(flex: 1,),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}
