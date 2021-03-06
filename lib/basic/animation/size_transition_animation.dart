import 'package:flutter/material.dart';

class SizeTransitionAnimation extends StatefulWidget {
  @override
  _SizeTransitionAnimationState createState() =>
      _SizeTransitionAnimationState();
}

class _SizeTransitionAnimationState extends State<SizeTransitionAnimation>
    with SingleTickerProviderStateMixin {
  bool _isShowing = true;

  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Size Transition Demo'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 120.0,
              height: 120.0,
              color: Colors.green,
            ),
          ),
          Container(
            width: 30.0,
            height: 30.0,
          ),
          Center(
            child: SizeTransition(
                sizeFactor: CurvedAnimation(
                    //new
                    parent: _animationController,
                    curve: Curves.easeOut,
                    reverseCurve: Curves.decelerate),
                child: Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange,
                  ),
                )),
          ),
          Container(
            height: 20.0,
          ),
          Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.near_me),
          onPressed: () => setState(() {
                _isShowing = !_isShowing;
                if (_isShowing) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              })),
    );
  }
}
