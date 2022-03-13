import 'package:ente/ApiServices/frameService.dart';
import 'package:ente/constants/baseAppbar.dart';
import 'package:ente/models/framemodel.dart';
import 'package:ente/pages/cart.dart';
import 'package:ente/pages/createFrameDialog.dart';
import 'package:ente/pages/frameDashboard.dart';
import 'package:flutter/material.dart';

class UserFrameList extends StatefulWidget {
  final String username;

  UserFrameList({
    this.username,
    Key key,
  }) : super(key: key);
  @override
  _UserFrameListState createState() => _UserFrameListState();
}

class _UserFrameListState extends State<UserFrameList> {
  final navigatorKey = GlobalKey<NavigatorState>();
  List<UserFrame> userframe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        username: widget.username,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: 800,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                      Container(
                          width: 100,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.add,
                                size: 40,
                              ),
                              Icon(Icons.list),
                              Icon(Icons.more_vert),
                            ],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 600,
                            // color: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: double.infinity,
                            child: FutureBuilder<List<UserFrame>>(
                                future: getFrameByUser(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<UserFrame>> snapshot) {
                                  if (snapshot.hasData) {
                                    userframe = snapshot.data.toList();
                                    return GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 2.0,
                                      children: List.generate(userframe.length,
                                          (index) {
                                        return Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          // color: Colors.amber,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 200,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: (userframe[index]
                                                                    .images) !=
                                                                null
                                                            ? NetworkImage(
                                                                userframe[index]
                                                                    .images)
                                                            : AssetImage(
                                                                'assets/images/framelog2.jpeg'),
                                                        fit: BoxFit.cover),
                                                    color: Colors.teal.shade900
                                                        .withOpacity(.2),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FrameDashboard(
                                                                frameData:
                                                                    userframe[
                                                                        index],
                                                              )));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  height: 40,
                                                  width: double.infinity,
                                                  child: Chip(
                                                    backgroundColor:
                                                        Colors.teal.shade900,
                                                    label: Text(
                                                      '${userframe[index].name}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    avatar: CircleAvatar(
                                                      child: Text(
                                                          '${userframe[index].name[0]}'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    );
                                  } else {
                                    return Center(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CreateFrameDialog();
              });
        },
        label: const Text(
          'Add a frame',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
