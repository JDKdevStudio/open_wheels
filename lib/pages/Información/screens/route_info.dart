// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:open_wheels/widgets/scroll_behavior.dart';


class RouteInfoScreen extends StatelessWidget {
  const RouteInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Map<String, String> _puntosDestino = {
      'CC Cacique': '11:00 AM',
      'Universidad Santo Tomas': '12:00 PM',
      'UPB': '12:35 PM',
      'Lagos II': '1:00 PM',
      'CC Cañaveral': '1:30 PM'
    };

    return Scaffold(
        backgroundColor: Color(0xffFAFDFF),
        body: Column(
          children: [
            UpperBar(size: size),
            _RoutePoints(
              puntosDestino: _puntosDestino.length,
              puntosDestinoNombres: _puntosDestino,
            )
          ],
        ));
  }
}

class _RoutePoints extends StatelessWidget {
  final int puntosDestino;

  Map<String, String> puntosDestinoNombres = {};

  _RoutePoints(
      {Key? key,
      required this.puntosDestino,
      required this.puntosDestinoNombres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          // separatorBuilder: (_, __) => Divider(),
          physics: BouncingScrollPhysics(),
          itemCount: puntosDestino,
          dragStartBehavior: DragStartBehavior.start,
          padding: EdgeInsetsDirectional.only(start: 35, top: 0),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 7),
                          width: 15,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Color(0xff5E6572),
                          ),
                        ),
                        Container(
                          width: size.width * 0.08,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                              child: Container(
                            width: size.width * 0.04,
                            height: size.width * 0.04,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff5E6572),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      puntosDestinoNombres.keys.elementAt(index),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Color(0xff1C2321),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      puntosDestinoNombres.values.elementAt(index),
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Color(0xff1C2321),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class UpperBar extends StatelessWidget {
  const UpperBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(children: [
        _Box(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.076),
              Text('Provenza - UPB',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: size.height * 0.026),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMin(
                        nombreInicial: "Hora: ",
                        nombreContenido: "3 PM",
                      ),
                      SizedBox(height: size.height * 0.011),
                      TextMin(
                          nombreInicial: "Placa: ", nombreContenido: "HHC-352")
                    ],
                  ),
                  SizedBox(width: size.width * 0.14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMin(
                        nombreInicial: "Conductor: ",
                        nombreContenido: "Jose",
                      ),
                      SizedBox(height: size.height * 0.011),
                      TextMin(
                          nombreInicial: "Fecha: ", nombreContenido: "30/04/22")
                    ],
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Image(
                image: NetworkImage(
                    "https://www.pngmart.com/files/1/Volkswagen-PNG-Free-Download.png"),
                height: 150,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: 30,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 14, color: Color(0xff1C2321)),
                  ),
                  style: TextButton.styleFrom(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                    fixedSize: const Size.fromWidth(250),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: size.height * 0.37,
          left: size.width * 0.78,
          child: Column(
            children: const [
              Text("Cupos: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xff1C2321))),
              Text("2/5",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white))
            ],
          ),
        ),
      ]),
    );
  }
}

class TextMin extends StatelessWidget {
  final String nombreInicial;
  final String nombreContenido;

  const TextMin(
      {Key? key, required this.nombreInicial, required this.nombreContenido})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: nombreInicial,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis)),
          TextSpan(
              text: nombreContenido,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final Color color;
  const _Bubble({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.50,
      decoration: _colorBackground(),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(65),
          bottomRight: Radius.circular(65),
        ),
        child: Stack(
          children: [
            Positioned(
              child: const _Bubble(
                color: Color(0xff7D98A1),
              ),
              top: size.height * 0.27,
              left: size.width * 0.65,
              // top: size.height * 0.24,
              // left: size.width * 0.55,
            ),
            Positioned(
              child: const _Bubble(
                color: Color(0xff5E6572),
              ),
              top: -size.height * 0.15,
              left: -size.width * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}

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
