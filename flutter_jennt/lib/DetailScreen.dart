import 'package:flutter/material.dart';

class User {
  final String website, name, email;

  User(this.website, this.name, this.email);
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final User users;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(users.name),
        ),
        body: Column(children: [
          Text(users.name),
          Text(users.website),
          Text(users.email),
          //Text(users.address),
        ]));
  }
}
