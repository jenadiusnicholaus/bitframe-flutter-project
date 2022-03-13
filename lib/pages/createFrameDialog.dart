import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/ApiServices/frameService.dart';
import 'package:ente/constants/app_constants.dart';
import 'package:ente/models/framemodel.dart';
import 'package:flutter/material.dart';
import 'package:image_form_field/image_form_field.dart';

class CreateFrameDialog extends StatefulWidget {
  @override
  _CreateFrameDialogState createState() => _CreateFrameDialogState();
}

class _CreateFrameDialogState extends State<CreateFrameDialog> {
  CreateFrame createFrame;
  int price = 2000;
  bool isSubmiting = false;

  GlobalKey<FormState> formgrobalkey = new GlobalKey<FormState>();
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

  void initState() {
    super.initState();
    createFrame = new CreateFrame();
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Container(
          height: 450,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formgrobalkey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Add  a Frame",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    createFrame.name = value;
                  },
                  // obscureText: hideoldPassword,
                  validator: (value) {
                    if (value.length < 3) {
                      return 'Frame name must be atlest 4 charter';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    helperText: "Enter Frame name",
                    prefixIcon: Icon(Icons.shop_outlined),
                    hintText: 'Frame name',
                    // suffixIcon: IconButton(
                    //   icon: Icon(hideoldPassword
                    //       ? Icons.visibility_off
                    //       : Icons.visibility),
                    //   onPressed: () {
                    //     setState(() {
                    //       hideoldPassword = !hideoldPassword;
                    //     });
                    //   },
                    // ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    createFrame.capacity = value;
                  },
                  // obscureText: hideoldPassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Frame capcity cant be less than 4 product target';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    helperText: "Enter Frame capacity",
                    prefixIcon: Icon(Icons.format_list_numbered),
                    hintText: 'Number of products is going to hold',
                    // suffixIcon: IconButton(
                    //   icon: Icon(hideoldPassword
                    //       ? Icons.visibility_off
                    //       : Icons.visibility),
                    //   onPressed: () {
                    //     setState(() {
                    //       hideoldPassword = !hideoldPassword;
                    //     });
                    //   },
                    // ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonFormField<String>(
                    elevation: 0,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.list_alt_outlined),
                        helperText: "Select Frame Type",
                        hintText: 'Frame type'),

                    // value: dropdownValue,
                    style: TextStyle(color: Colors.black87),

                    items: <String>[
                      'wholeSeller',
                      'retailer',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onSaved: (value) {
                      createFrame.frameType = value;
                    },
                    onChanged: (String newValue) {
                      setState(() {
                        // dropdownValue = newValue;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return ' select typeof your business';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonFormField<String>(
                    elevation: 0,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.timer),
                        helperText: "Select business duration",
                        hintText: 'Duration'),

                    // value: dropdownValue,
                    style: TextStyle(color: Colors.black87),

                    items: <String>[
                      'monthly',
                      'yearly',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onSaved: (value) {
                      createFrame.duration = value;
                      if (value == 'monthly') {
                        createFrame.price = '2000';
                      } else if (value == 'yearly') {
                        int yearly = 2000 * 12;
                        createFrame.price = yearly.toString();
                      }
                    },
                    onChanged: (String newValue) {
                      setState(() {
                        // dropdownValue = newValue;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Duration';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: createFrame.price != null
                      ? Text(
                          "Total price Tsh:${createFrame.price}:trial for 3 weeks ",
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Text(
                          " ",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (validateAndSave()) {
                          String token = await getToken();
                          setState(() {
                            isSubmiting = true;
                          });

                          await addFrame(token, createFrame).then((value) {
                            setState(() {
                              isSubmiting = false;
                            });
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: isSubmiting
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator())
                              : Text(
                                  'create',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'cancel',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
