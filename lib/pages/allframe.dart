import 'package:ente/ApiServices/frameService.dart';
import 'package:ente/models/framemodel.dart';
import 'package:flutter/material.dart';

class AllFrames extends StatefulWidget {
  @override
  _AllFramesState createState() => _AllFramesState();
}

class _AllFramesState extends State<AllFrames> {
  List<FrameListModel> framelist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: BaseAppBar(),
        body: Column(
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
            height: MediaQuery.of(context).size.height,
            // color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            child: FutureBuilder<List<FrameListModel>>(
                future: frameList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<FrameListModel>> snapshot) {
                  if (snapshot.hasData) {
                    framelist = snapshot.data.toList();
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 2.0,
                      children: List.generate(framelist.length, (index) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          // color: Colors.amber,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: (framelist[index].images) != null
                                            ? NetworkImage(
                                                framelist[index].images)
                                            : AssetImage(
                                                'assets/images/framelog2.jpeg'),
                                        fit: BoxFit.cover),
                                    color: Colors.teal.shade900.withOpacity(.2),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             FrameDashboard(
                                  //               frameData:
                                  //                   framelist[index],
                                  //             )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  height: 40,
                                  width: double.infinity,
                                  child: Chip(
                                    backgroundColor: Colors.teal.shade900,
                                    label: Text(
                                      '${framelist[index].name}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    avatar: CircleAvatar(
                                      child:
                                          Text('${framelist[index].name[0]}'),
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
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
      ],
    ));
  }
}
