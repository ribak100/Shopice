import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  FlatButton(
      {Key? key,
      this.color = Colors.transparent,
      required this.onPressed,
      required this.child,
      this.height = 25,
      this.weight = 85})
      : super(key: key);
  Color color;
  final VoidCallback onPressed;
  final Widget child;
  double height, weight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: 80,
          decoration: BoxDecoration(
            color: color,
          ),
          child: child,
        ));
  }
}
