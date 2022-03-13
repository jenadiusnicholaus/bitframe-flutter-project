import 'package:ente/pages/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyPhonePage extends StatefulWidget {
  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

GlobalKey formglobalkey;

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text(
                'verify ',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
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
                  child: Form(
                    key: formglobalkey,
                    child: Column(
                      children: [
                        Image.asset('assets/images/enterlog2.png'),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'verify phene number',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: Row(
                                  children: [
                                    Text(
                                      '4 digit Code sent to:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '+25578811189',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Form(
                                key: formglobalkey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 50,
                                        width: 60,
                                        // color: Colors.red,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: '0',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14))),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                        height: 50,
                                        width: 60,
                                        // color: Colors.red,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: '0',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14))),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                        height: 50,
                                        width: 60,
                                        // color: Colors.red,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: '0',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14))),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),

                                    // +++++++++++++++++++++++++++++++++++++++++++++++++++++
                                    Container(
                                        height: 50,
                                        width: 60,
                                        // color: Colors.red,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: '0',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14))),
                                        )),
                                  ],
                                ),
                              ),

                              // +++++++++++++++++++++++++++++++++++++++++++++++++++++
                              Divider(
                                height: 10,
                              ),
                              Container(
                                height: 80,
                                // color: Colors.red,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Resend in',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blueGrey),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '00 45s',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BasePage()));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Icon(
                                          Icons.check,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ]),
        ));
  }
}
