import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_wheels/widgets/widgets.dart';

class AllowGeocodeScreen extends StatelessWidget {
  const AllowGeocodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff1C2321),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C2321),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MainLogo(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                  GestureDetector(
                    onTap: () async {
                      LocationPermission permission =
                          await Geolocator.checkPermission();
                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                        if (permission == LocationPermission.always ||
                            permission == LocationPermission.whileInUse) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'lobby', (route) => false);
                        }
                      }
                      if (permission == LocationPermission.deniedForever) {
                        bool value = await Geolocator.openLocationSettings();
                        permission = await Geolocator.checkPermission();
                        if (value && permission == LocationPermission.always ||
                            permission == LocationPermission.whileInUse) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'lobby', (route) => false);
                        }
                      }
                    },
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff7D98A1),
                      size: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'Ubicación del dispositivo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'Necesitamos acceder a tu ubicación para poder brindarte una mejor experiencia',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
