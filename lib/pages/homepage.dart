import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController;
  Duration pageTurnDuration = Duration(milliseconds: 500);
  Curve pageTurnCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    // The PageController allows us to instruct the PageView to change pages.
    _pageController = PageController();
  }

  void _goForward() {
    _pageController.nextPage(duration: pageTurnDuration, curve: pageTurnCurve);
  }

  void _goBack() {
    _pageController.previousPage(
        duration: pageTurnDuration, curve: pageTurnCurve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Using the DragEndDetails allows us to only fire once per swipe.
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity < 0) {
            // Page forwards
            print('Move page forwards');
            _goForward();
          } else if (dragEndDetails.primaryVelocity > 0) {
            // Page backwards
            print('Move page backwards');
            _goBack();
          }
        },
        child: PageView.builder(
          itemCount: 10,
          controller: _pageController,
          // NeverScrollableScrollPhysics disables PageView built-in gestures.
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.amber,
              child: Center(
                child: Text('item ${index++}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
