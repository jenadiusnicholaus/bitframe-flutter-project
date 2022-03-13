import 'package:ente/ApiServices/authApi.dart';
import 'package:ente/constants/baseAppbar.dart';
import 'package:ente/models/framemodel.dart';
import 'package:ente/pages/allframe.dart';
import 'package:ente/pages/cart.dart';
import 'package:ente/authpages/login.dart';
import 'package:ente/constants/request_rogress.dart';
import 'package:ente/authpages/profile.dart';
import 'package:ente/pages/favorite.dart';
import 'package:ente/pages/home.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final String username;
  final String token;
  final List<FrameListModel> frameList;

  const BasePage({Key key, this.username, this.token, this.frameList})
      : super(key: key);
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedPageIndex = 0;
  bool isApiCallProgress = false;
  bool isloadingProfile = false;
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'My cart',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.favorite_outline_rounded),
    //   label: 'Favorites',
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      label: 'search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.filter_frames_outlined),
      label: 'Frames',
    ),
  ];
  void _onItemTapped(int index) {
    setState(
      () {
        _pageController.animateToPage(index,
            duration: Duration(
              microseconds: 500,
            ),
            curve: Curves.ease);
      },
    );
    // _selectedPageIndex = index;
  }

  _logOut() async {
    setState(() {
      isApiCallProgress = true;
    });

    await signOut().then((value) {
      setState(() {
        isApiCallProgress = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  Widget build(BuildContext context) {
    return LoginProgressSpiner(
      child: _enteUI(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _enteUI(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[50],
      appBar: BaseAppBar(
        username: widget.username,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    // backgroundImage: AssetImage(
                    //   'assets/images/jenadius.png',
                    child: Text('${widget.username[0].toUpperCase()}'),
                  ),
                  Text(
                    '',
                    // widget.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isloadingProfile = !isloadingProfile;
                    });
                    String authToken = await getToken();
                    await userProfile()
                        .then((value) {
                          setState(() {
                            isloadingProfile = false;
                          });
                          if (value != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                        })
                        .onError((error, stackTrace) {})
                        .whenComplete(() {});
                  },
                  child: isloadingProfile
                      ? Text(' is loading Profile ....')
                      : Text('Profile')),
            ),
            isloadingProfile ? LinearProgressIndicator() : Text(''),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.tv_off),
              title: GestureDetector(
                  onTap: () async {
                    await _logOut();
                  },
                  child: Text('Logout')),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _pageController,
                onPageChanged: (newIndex) {
                  setState(() {
                    _selectedPageIndex = newIndex;
                  });
                },
                children: [
                  Home(username: widget.username),
                  ShoppingCart(),
                  Favorites(),
                  AllFrames(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        onTap: _onItemTapped,
        items: _bottomNavigationBarItem,
      ),
    );
  }
}
