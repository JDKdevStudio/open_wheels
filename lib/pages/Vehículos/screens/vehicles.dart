import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backendProvider = Provider.of<BackendProvider>(context);
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return Column(
      children: [
        //*Header---------------------------------------------------------------
        Container(
          child: Center(
            child: Column(
              children: const [
                Text(
                  'Mis Vehículos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          width: double.infinity,
          height: size.height * 0.15,
          decoration: const BoxDecoration(
            color: Color(0xff1C2321),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),

        //*ListBuilder----------------------------------------------------------
        FutureBuilder<List<Car>>(
          future: backendProvider.getuserCars(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final pendingData = snapshot.data!;
              return pendingData.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.car_rental_outlined,
                              size: size.width * 0.3, color: Colors.grey),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'No tienes vehículos registrados',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff1C2321),
                            ),
                            onPressed: () {
                              formProvider.resetPicker();
                              Navigator.pushNamed(context, 'register_car');
                            },
                            child: const Text('Registrar Vehículo'),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemCount: pendingData.length,
                        itemBuilder: (_, index) {
                          final item = pendingData[index];
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
