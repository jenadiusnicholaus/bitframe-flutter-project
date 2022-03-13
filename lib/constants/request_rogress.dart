import 'package:flutter/material.dart';

class LoginProgressSpiner extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  LoginProgressSpiner({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.teal,
    this.valueColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetlist = [];
    widgetlist.add(child);
    if (inAsyncCall) {
      final model = new Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
          new Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green.withRed(2),
            ),
          )
        ],
      );
      widgetlist.add(model);
    }

    return Stack(children: widgetlist);
  }
}
