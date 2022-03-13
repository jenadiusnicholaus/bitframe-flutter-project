import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/authpages/login.dart';
import 'package:ente/pages/base.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token = await getToken();
  String username = await getUsername();
  // print('Token from Shated' + token);
  // print('Username from Shated =>' + username);

  runApp(MyApp(
    token: token,
    username: username,
  ));
}

class MyApp extends StatefulWidget {
  final String token;
  final String username;
  MyApp({Key key, this.token, this.username}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ente',
      theme: ThemeData(
          primaryColor: Colors.teal.shade900,
          primarySwatch: Colors.teal,
          accentColor: Colors.white),
      home: widget.token != null
          ? BasePage(
              username: widget.username,
              token: widget.token,
            )
          : LoginPage(),
    );
  }
}
