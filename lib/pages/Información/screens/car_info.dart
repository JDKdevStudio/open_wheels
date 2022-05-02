import 'package:flutter/material.dart';
import 'package:open_wheels/classes/car.dart';

class CarInfoScreen extends StatelessWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Car;
    final size = MediaQuery.of(context).size;
    final Map<String, String> data = {
      'Placa': args.placa!,
      'Modelo': args.modelo!,
      'Clase de Vehículo': args.clase!,
      "Capacidad": args.capacidad.toString(),
      'Color': args.color!,
      "Foto de Vehículo": 'my-car-photo.png',
      "Tarjeta de Propiedad": 'my-property-card.png'
    };
    const dataIcons = [
      Icon(Icons.notes_outlined),
      Icon(Icons.directions_car_outlined),
      Icon(Icons.groups_outlined),
      Icon(Icons.phone_outlined),
      Icon(Icons.palette_outlined),
      ImageIcon(
        NetworkImage(
            'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/photoCar.png'),
      ),
      ImageIcon(
        NetworkImage(
            'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/certificate.png'),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xff1C2321),
      appBar: AppBar(
        title: const Text('Información de Vehículo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            left: -size.width * 0.5,
            top: size.height * 0.05,
            child: const _Bubble(
              color: Color(0xff7D98A1),
            ),
          ),
          Positioned(
            left: size.width * 0.55,
            top: size.height * 0.60,
            child: const _Bubble(
              color: Color(0xff5E6572),
            ),
          ),
          Center(
            child: Container(
              height: size.height * 0.7,
              width: size.width * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  _UserHeader(args: args),
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (_, __) {
                        return const Divider();
                      },
                      itemBuilder: (_, int index) {
                        return ListTile(
                          leading: dataIcons[index],
                          title: Text(data.values.toList()[index]),
                          subtitle: Text(data.keys.toList()[index]),
                          trailing: index == 5 || index == 6
                              ? const Icon(
                                  Icons.link_outlined,
                                  color: Colors.black,
                                )
                              : null,
                          onTap: () {
                            index == 5
                                ? showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Foto del Vehículo'),
                                      content: Image.network(args.photo!),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10),
                                      ),
                                      backgroundColor: Colors.white,
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cerrar'),
                                        )
                                      ],
                                    ),
                                  )
                                : index == 6
                                    ? showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                              'Tarjeta de Propiedad'),
                                          content: Image.network(args.card!),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                          ),
                                          backgroundColor: Colors.white,
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Cerrar'),
                                            )
                                          ],
                                        ),
                                      )
                                    : null;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({
    Key? key,
    required this.args,
  }) : super(key: key);

  final Car args;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xffFAFDFF),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(args.photo!),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    args.placa!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    args.user!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.info_outline, color: Colors.black),
          ],
        ),
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
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
