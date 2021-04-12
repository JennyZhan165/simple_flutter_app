import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DetailScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jasonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jasonData) {
      User user = User(u["website"], u["name"], u["email"]);
      users.add(user);
    }
    //print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Listing'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text('Loading...Please wait'),
                    ),
                  );
                } else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(snapshot.data[i].name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(users: snapshot.data[i]),
                              ),
                            );
                          },
                        );
                      });
              }),
        ),
      ),
    );
  }
}
