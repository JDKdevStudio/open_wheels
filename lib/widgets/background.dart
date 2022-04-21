import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget logo;
  final Widget buttons;

  const Background({Key? key, required this.logo, required this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Guarda las dimensiones del dispositivo
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          //Ubicación de la caja del logo
          const _Box(),
          Positioned(
            top: size.height * 0.35,
            left: size.width * 0.45,
            child: const _HeaderImage(),
          ),

          //Ubicación del logo
          SizedBox(
            width: double.infinity,
            height: size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo,
              ],
            ),
          ),

          //Ubicación de los botones
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buttons,
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Imagen del carro ubicada debajo del logo principal
class _HeaderImage extends StatelessWidget {
  const _HeaderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      fit: BoxFit.contain,
      image: AssetImage('assets/car1.png'),
      width: 400,
      height: 350,
    );
  }
}

//Caja para contener el logo principal
class _Box extends StatelessWidget {
  const _Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: _colorBackground(),
      child: Stack(
        children: [
          Positioned(
            child: const _Bubble(
              color: Color(0xff7D98A1),
            ),
            top: -size.height * 0.2,
            left: -size.width * 0.3,
          ),
          Positioned(
            child: const _Bubble(
              color: Color(0xff5E6572),
            ),
            top: size.height * 0.29,
            left: size.width * 0.65,
          ),
        ],
      ),
    );
  }

//Generalización del estilo del BoxDecoration
  BoxDecoration _colorBackground() => const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(65),
          bottomRight: Radius.circular(65),
        ),
        color: Color(0xff1C2321),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 15),
          ),
        ],
      );
}

//Circulos decorativos en el header
class _Bubble extends StatelessWidget {
  final Color color;
  const _Bubble({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
