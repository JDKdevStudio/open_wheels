import 'package:flutter/material.dart';

class RemoveDismiss extends StatelessWidget {
  const RemoveDismiss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          Icons.remove_circle_outline,
          color: Colors.red[900],
          size: 35,
        ),
      ),
    );
  }
}
