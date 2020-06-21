import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_bloc/data/repository.dart';

class UserState {
  UserState();

  factory UserState.userData(User user) => new UserStateData(user);
  factory UserState.loading() => new UserStateLoading();
  factory UserState.init() => new UserStateInit();
}

class UserStateInit extends UserState {}
class UserStateLoading extends UserState {}
class UserStateData extends UserState {
  final User user;
  UserStateData(this.user);
}

class UserBloc {
  final Repository _repository;
  final StreamController<UserState> _userStreamController = new StreamController<UserState>();

  Stream<UserState> get userStateStream => _userStreamController.stream;

  UserBloc(this._repository);

  void loadUserData() {
    _userStreamController.sink.add(new UserState.loading());
    _repository
      .getUser()
      .then((user) => _userStreamController.sink.add(new UserState.userData(user)));
  }

  void dispose() {
    _userStreamController.close();
  }
}

class BlocScreen extends StatefulWidget {
  BlocScreen();

  @override
  _BlocScreen createState() {
    return new _BlocScreen();
  }
}

class _BlocScreen extends State<BlocScreen> {
  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = new UserBloc(new Repository());
    super.initState();
  }

  Widget _buildInitScreen() {
    return new Center(
      child: new RaisedButton(
        child: const Text('Load user data'),
        onPressed: () {
          _userBloc.loadUserData();
        },
      )
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDataScreen(User user) {
    return new Text('Hello ${user.name} ${user.surname};');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('BLOC Architecture'),
      ),
      body: new SafeArea(
        child: new StreamBuilder<UserState>(
          stream: _userBloc.userStateStream,
          initialData: new UserState.init(),
          builder: (context, snapshot) {
            if(snapshot.data is UserStateInit) {
              return _buildInitScreen();
            }
            else if(snapshot.data is UserStateLoading) {
              return _buildLoadingScreen();
            }
            else if(snapshot.data is UserStateData) {
              UserStateData data = snapshot.data as UserStateData;
              return _buildDataScreen(data.user);
            }

            return null;
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }
}