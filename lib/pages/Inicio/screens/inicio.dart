// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:open_wheels/providers/backend_provider.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../classes/classes.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backendProvider = Provider.of<BackendProvider>(context);
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return Column(
      children: [
        UpperBar1(size: size),
        FutureBuilder<List<Routes>>(
          future: backendProvider.getUserRoutes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final routesData = snapshot.data!;
              backendProvider.getUserCars();
              return routesData.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_outlined,
                              size: size.width * 0.3, color: Colors.grey),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'No estás inscrito en rutas',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemCount: routesData.length,
                        itemBuilder: (_, index) {
                          final item = routesData[index];
                          return CardInfo(item: item);
                        },
                      ),
                    );
            }
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff1C2321),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class UpperBar1 extends StatelessWidget {
  const UpperBar1({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<BackendProvider>(context);
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
              Text('Bienvenido,',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis),
              Text(userProvider.userData.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 27,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: size.height * 0.026),
              Container(
                child: Image(
                  image: NetworkImage(
                      "https://www.carsized.com/resources/mercedes-benz/cla/d/2013/sl_239116142_mercedes-benz-cla-2013-side-view_4x.png"),
                  height: 200,
                  width: 800,
                  fit: BoxFit.fill,
                ),
                transform: Matrix4.translationValues(
                    MediaQuery.of(context).size.width * .4, -10.0, 0.0),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class TextMin1 extends StatelessWidget {
  final String nombreInicial;
  final String nombreContenido;

  const TextMin1(
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
      height: size.height * 0.40,
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
              top: size.height * 0.24,
              left: size.width * -0.30,
              // top: size.height * 0.24,
              // left: size.width * 0.55,
            ),
            Positioned(
              child: const _Bubble(
                color: Color(0xff5E6572),
              ),
              top: -size.height * -0.01,
              left: -size.width * -0.79,
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
