import 'package:meta/meta.dart';
import "dart:async";

class User {
  final String name;
  final String surname;

  User({
    @required this.name,
    @required this.surname
  });
}

class Repository {
  Future<User> getUser() async {
    await Future.delayed(new Duration(seconds: 3));
    return new User(name: 'John', surname: 'Smith');
  }
}