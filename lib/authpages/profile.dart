import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/ApiServices/frameService.dart';
import 'package:ente/constants/app_constants.dart';
import 'package:ente/constants/request_rogress.dart';
import 'package:ente/models/profile_model.dart';
import 'package:ente/models/reset_password.dart';
import 'package:ente/pages/base.dart';
import 'package:ente/pages/userframes.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String username;

  Profile({
    Key key,
    this.username,
  }) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextStyle textStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  GlobalKey<FormState> formgrobalkey = new GlobalKey<FormState>();
  bool isbtn1Active = true;
  bool isbtn2active = false;
  bool hideoldPassword = true;
  bool hidenewPassword = true;
  bool isLoadingFrames = false;
  ChangePassword changePassword;

  void initState() {
    super.initState();
    changePassword = ChangePassword();
  }

  void chnagePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Container(
            height: 150,
            child: Form(
              key: formgrobalkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      changePassword.oldPassword = value;
                    },
                    obscureText: hideoldPassword,
                    validator: (value) {
                      if (value.length < 3) {
                        return 'Must atleast 3 character';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        helperText: "Old password",
                        prefixIcon: Icon(Icons.lock_outlined),
                        hintText: 'Enter the olde apssword',
                        suffixIcon: IconButton(
                          icon: Icon(hideoldPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hideoldPassword = !hideoldPassword;
                            });
                          },
                        )),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      changePassword.newPassword = value;
                    },
                    obscureText: hidenewPassword,
                    validator: (value) {
                      if (value.length < 3) {
                        return 'Must atleast 3 character';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        helperText: "New password",
                        prefixIcon: Icon(Icons.lock_outlined),
                        hintText: 'Enter the a new password',
                        suffixIcon: IconButton(
                          icon: Icon(hidenewPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hidenewPassword = !hidenewPassword;
                            });
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                if (valideAndSaveform()) {
                  String token = await getToken();
                  await passwordRest(token, changePassword)
                      .then((value) => null)
                      .whenComplete(() => Navigator.of(context).pop());
                }
              },
              child: Center(
                  child: Text(
                'Send',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            )
          ],
        );
      },
    );
  }

  _getProfileDat() async {
    userProfile();
  }

  @override
  Widget build(BuildContext context) {
    return LoginProgressSpiner(
      child: _buildUI(context),
      inAsyncCall: isLoadingFrames,
      opacity: 0.3,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: 900,
            width: double.infinity,
            child: Column(
              children: [
                FutureBuilder(
                    future: userProfile(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var profile = snapshot.data;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          height: 340,
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                // radius: 100,
                                minRadius: 80,
                                maxRadius: 90,
                                backgroundColor: Theme.of(context).primaryColor,
                                backgroundImage: NetworkImage(
                                    Constants.onlineTesturl +
                                        '${profile.userData.imageUrl}'),
                              ),
                              Divider(
                                height: 3,
                              ),
                              Text(
                                "${profile.userData.firstName} ${profile.userData.secondName} ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Divider(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    profile.userData.phoneNumber.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.white,
                                      onPressed: () {})
                                ],
                              )
                            ],
                          ),
                        );
                      }
                      return Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator());
                    }),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: (isbtn1Active && !isbtn2active)
                              ? Border(
                                  bottom: BorderSide(
                                      width: 3.0,
                                      color: Theme.of(context).primaryColor),
                                )
                              : Border(
                                  bottom: BorderSide(
                                      width: 3.0, color: Colors.white),
                                ),
                        ),
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isbtn1Active = true;
                                isbtn2active = false;
                              });
                            },
                            child: Text(
                              'Setting',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: (isbtn2active && !isbtn1Active)
                                ? Border(
                                    bottom: BorderSide(
                                        width: 3.0,
                                        color: Theme.of(context).primaryColor),
                                  )
                                : Border(
                                    bottom: BorderSide(
                                        width: 3.0, color: Colors.white),
                                  )),
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isbtn1Active = false;
                                isbtn2active = true;
                              });
                            },
                            child: Text(
                              'Activaties',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                ),
                (isbtn1Active && !isbtn2active)
                    ? Expanded(
                        child: Container(
                          // color: Colors.teal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              ListBody(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit Profile'),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      chnagePasswordDialog();
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.edit_outlined),
                                      title: Text('Change password'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          // color: Colors.teal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              ListBody(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      // try {
                                      setState(() {
                                        isLoadingFrames = true;
                                      });
                                      String token = await getToken();
                                      await getFrameByUser().then((value) {
                                        setState(() {
                                          isLoadingFrames = false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserFrameList(
                                                        username:
                                                            widget.username,
                                                      )));
                                        });
                                      });
                                      // } catch (e) {
                                      //   print(e);
                                      // }
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.shop_outlined,
                                          color: Colors.teal),
                                      title: Text('My Frames'),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('activies here1'),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('activies here1'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  bool valideAndSaveform() {
    final form = formgrobalkey.currentState;
    if (form.validate()) {
      print('form is ok');
      form.save();
      return true;
    } else {
      print('form is not ok');
      return false;
    }
  }
}
