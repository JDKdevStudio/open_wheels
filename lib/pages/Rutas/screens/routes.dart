import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({Key? key}) : super(key: key);

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
                  'Mis Rutas',
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
                            'No tienes rutas registradas',
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
                            onPressed: () async {
                              formProvider.resetPicker();
                              await backendProvider.getUserCars();
                              Navigator.pushNamed(context, 'register_route');
                            },
                            child: const Text('Registrar Rutas'),
                          )
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
