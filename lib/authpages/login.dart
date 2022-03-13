import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/ApiServices/frameService.dart';
import 'package:ente/constants/custom_exception.dart';
import 'package:ente/constants/request_rogress.dart';
import 'package:ente/authpages/register.dart';
import 'package:ente/models/login_models.dart';
import 'package:ente/pages/base.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // this used to store email and password afer  pressing  login button
  LoginRequest loginRequest;
  final scafoldkey = GlobalKey<ScaffoldState>();
// for showing and hiding password functionality
  bool hidePassword = true;
// for fonm contol
  GlobalKey<FormState> formgrobalkey = new GlobalKey<FormState>();
  // for adding login progress spiner after the  button clicked
  bool isApiCallProgress = false;

  void initState() {
    super.initState();
    loginRequest = new LoginRequest();
  }

  _loggedIn() {
    setState(() {
      isApiCallProgress = false;
    });
  }

  bool isSucess(bool fromRes) {
    if (fromRes != null) {
      return true;
    }
    return false;
  }

  void showErrorDialog(
    String message,
  ) {
    setState(() {
      isApiCallProgress = false;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error occurred '),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Center(
                child: Text(
              'Ok',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          )
        ],
      ),
    );
  }

// after form is valid save to LoginRequest model
  bool validateAndSave() {
    final form = formgrobalkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      print('Form is not valid');
      return false;
    }
  }

  _userSignIn() async {
    if (validateAndSave()) {
      try {
        setState(() {
          isApiCallProgress = true;
        });
        print(loginRequest.toJson());

        await login(loginRequest).then((value) async {
          _loggedIn();
          print('you could navigate');
          var frames = await frameList();
          print(
              '_________________product from login page_________________________');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BasePage(
                        username: value.user.username,
                        frameList: frames,
                      )));
        });
      } on CustomException catch (error) {
        String errorMessage = 'Authentication failed';
        if (error.toString().contains('Username or Password is incorrect')) {
          errorMessage = 'Username or password is incorrect';
        }
        _loggedIn();
        showErrorDialog(errorMessage);
      } catch (error_message) {
        // stops the spinner
        _loggedIn();
        showErrorDialog(error_message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginProgressSpiner(
      child: _loginUI(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _loginUI(BuildContext context) {
    return Scaffold(
      key: scafoldkey,
      // backgroundColor: Colors.green[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 90, vertical: 90),
                color: Colors.white,
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Image.asset('assets/images/enterlog2.png'),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Welcome to Ente',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Form(
                        key: formgrobalkey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                loginRequest.email = value;
                              },
                              validator: (value) {
                                if (!value.contains('@')) {
                                  return 'Enter a valid email';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                helperText: "Email ",
                                hintText: "email address",
                                prefixIcon: Icon(Icons.person_outline_rounded),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                loginRequest.password = value;
                              },
                              obscureText: hidePassword,
                              validator: (value) {
                                if (value.length < 3) {
                                  return 'Must atleast 3 character';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  helperText: "password",
                                  prefixIcon: Icon(Icons.lock_outlined),
                                  hintText: 'password',
                                  suffixIcon: IconButton(
                                    icon: Icon(hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                  )),
                            ),
                            FlatButton(
                              shape: StadiumBorder(),
                              textColor: Theme.of(context).accentColor,
                              padding: EdgeInsets.symmetric(horizontal: 100),
                              color: Theme.of(context).primaryColor,
                              onPressed: () => _userSignIn(),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 150,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              // color: Colors.blue,
                              child: Column(
                                children: [
                                  Text(
                                    'Or',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    height: 10,
                                    // color: Theme.of(context).primaryColor,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 34,
                                        width: 150,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text('Facebook',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue))),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 34,
                                          width: 200,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              color: Colors.red[400],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'Google',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
