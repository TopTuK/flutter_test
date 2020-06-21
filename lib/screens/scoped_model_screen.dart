import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:test_bloc/data/repository.dart';

class UserModel extends Model {
  final Repository _repositary;

  UserModel(this._repositary);

  bool _isLoading = false;
  User _user;

  User get user => _user;
  bool get isLoading => _isLoading;

  void loadUserData() {
    _isLoading = true;

    notifyListeners();

    _repositary
      .getUser()
      .then((user) {
        _user = user;
        _isLoading = false;

        notifyListeners();
      });
  }

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);
}

class ScopedModelScreen extends StatefulWidget {
  final Repository _repository = new Repository();

  ScopedModelScreen();

  @override
  State<StatefulWidget> createState() => _ScopedModelScreen();
}

class _ScopedModelScreen extends State<ScopedModelScreen> {
  UserModel _userModel;

  @override
  void initState() {
    _userModel = new UserModel(widget._repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel(
      model: _userModel, 
      child: new Scaffold(
        appBar: new AppBar(
          title: const Text('Scoped Model Screen'),
        ),
        body: new SafeArea(
          child: new ScopedModelDescendant<UserModel>(
            builder: (ctx, child, model) {
              if(model.isLoading) {
                return _buildLoadingState();
              }
              else if (model.user != null) {
                return _buildcontentState(model);
              }
              else {
                return _buildInitState(model);
              }
            }
          )
        ),
      )
    );
  }

  Widget _buildInitState(UserModel userModel) {
    return Center(
      child: RaisedButton(
        child: const Text('Load user data'),
        onPressed: () {
          userModel.loadUserData();
        },
      ),
    );
  }

  Widget _buildcontentState(UserModel userModel) {
    return Center(
      child: Text('Hello ${userModel.user.name} ${userModel.user.surname}'),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}