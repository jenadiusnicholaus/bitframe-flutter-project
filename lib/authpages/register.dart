import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/constants/custom_exception.dart';
import 'package:ente/authpages/login.dart';
import 'package:ente/constants/request_rogress.dart';
import 'package:ente/models/register_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterRequest registerRequest;
  bool isObscureText = true;
  bool isApiCallProgress = false;
  final scafoldkey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    registerRequest = new RegisterRequest();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool valideAndSaveForm() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('my form is ok');
      return true;
    }
    print('my form is not ok');

    return false;
  }

  _stopeSpinner() {
    setState(() {
      isApiCallProgress = false;
    });
  }

  void _registerUser() async {
    if (valideAndSaveForm()) {
      try {
        setState(() {
          isApiCallProgress = true;
        });
        await register(registerRequest).then((value) {
          _stopeSpinner();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
      } on CustomException catch (error) {
        print(error);
        var errorMessage = 'Username or email exists';

        _stopeSpinner();
        showErrorDialog(errorMessage);
      } catch (externalrError) {
        _stopeSpinner();
        showErrorDialog(externalrError);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return LoginProgressSpiner(
      child: _registerUI(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _registerUI(BuildContext context) {
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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
                child: Text(
                  'Sign In ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      helperText: "Username",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    onSaved: (value) {
                                      registerRequest.username = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'username can\'t be empty';
                                      }
                                      return null;
                                    }),
                                TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      helperText: "email",
                                      prefixIcon: Icon(Icons.email_outlined),
                                    ),
                                    onSaved: (value) {
                                      registerRequest.email = value;
                                    },
                                    validator: (value) {
                                      if (!value.contains('@')) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    }),
                                TextFormField(
                                    keyboardType: TextInputType.text,
                                    obscureText: isObscureText,
                                    decoration: InputDecoration(
                                      helperText:
                                          "password(View adn keep you password before submittinfg the form)",
                                      prefixIcon: Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        color: isObscureText
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.3)
                                            : Theme.of(context).primaryColor,
                                        icon: isObscureText
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            isObscureText = !isObscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    onSaved: (value) {
                                      registerRequest.password = value;
                                    },
                                    validator: (value) {
                                      if (value.length <= 3) {
                                        return 'password must be greater than 3 chars';
                                      }
                                      return null;
                                    }),
                                Container(
                                  height: 150,
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  width: double.infinity,
                                  // color: Colors.blue,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // validate and save the form
                                          _registerUser();
                                        },
                                        child: Container(
                                          height: 34,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text('Sign Up',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Theme.of(context)
                                                          .accentColor))),
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        'Or',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        height: 10,
                                        color: Theme.of(context).primaryColor,
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
                                                color: Theme.of(context)
                                                    .accentColor,
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
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Text('Google',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
