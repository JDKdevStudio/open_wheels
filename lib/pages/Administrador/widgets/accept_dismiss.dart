import 'package:flutter/material.dart';

class AcceptDismiss extends StatelessWidget {
  const AcceptDismiss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.green[900],
          size: 35,
        ),
      ),
    );
  }
}
