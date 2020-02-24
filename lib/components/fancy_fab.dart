import 'package:flutter/material.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FancyFab({this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<Color> _iconColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _iconColor = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: Curves.easeOut,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget save() {
    return Container(
      child: FloatingActionButton(
        heroTag: "SaveTag",
        backgroundColor: Colors.white,
        onPressed: null,
        tooltip: 'Save',
        child: Icon(Icons.attach_money),
      ),
    );
  }

  Widget income() {
    return Container(
      child: FloatingActionButton(
        heroTag: "IncomeTag",
        backgroundColor: Colors.green,
        onPressed: () =>
            Navigator.pushReplacementNamed(context, '/categories_in'),
        tooltip: 'Income',
        child: Icon(Icons.keyboard_arrow_left),
      ),
    );
  }

  Widget expense() {
    return Container(
      child: FloatingActionButton(
        heroTag: "ExpenseTag",
        backgroundColor: Colors.red,
        onPressed: () =>
            Navigator.pushReplacementNamed(context, '/categories_out'),
        tooltip: 'Income',
        child: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        heroTag: "AddTag",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Add',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: _iconColor.value,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: save(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: income(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: expense(),
        ),
        add(),
      ],
    );
  }
}
