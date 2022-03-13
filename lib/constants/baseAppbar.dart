import 'package:ente/models/profile_model.dart';
import 'package:ente/authpages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;

  const BaseAppBar({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor,
          offset: Offset(0, 2.0),
          blurRadius: 0.0,
        )
      ]),
      child: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // ${widget.user.username}
        title: Center(
            child: username != null ? Text('bitFrame') : Text('bitFrame')),

        actions: [
          PopupMenuButton(
            icon: CircleAvatar(
              backgroundColor: Colors.teal,
              // backgroundImage: {},
              child: Text('${username[0].toUpperCase()}'),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(
                                    username: username,
                                  )));
                    },
                    child: ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Profile'),
                    ),
                  ),
                ),
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.filter_frames),
                  title: Center(child: Text('My frame')),
                ),
              ),
              PopupMenuDivider(
                height: 3,
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('logout'),
                ),
              ),
            ],
          ),
        ],
        elevation: 0.0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
