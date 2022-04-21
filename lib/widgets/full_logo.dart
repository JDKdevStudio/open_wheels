import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Hero(
          tag: 'logotag',
          child: Image(
            image: const AssetImage('assets/logo.png'),
            width: size.width * 0.2,
            height: size.height * 0.1,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Open Wheels',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
