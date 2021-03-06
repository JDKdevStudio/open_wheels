import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Future<List<dynamic>> dataFuture;
  @override
  void initState() {
    dataFuture = BackendProvider.getPendingUsersAndCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backendProvider = Provider.of<BackendProvider>(context);
    return Column(
      children: [
        //*Header---------------------------------------------------------------
        Container(
          child: Center(
            child: Column(
              children: const [
                Text(
                  'Solicitudes de Usuario y Vehículos',
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
        FutureBuilder<List<dynamic>>(
          future: dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final pendingData = snapshot.data!;
              return pendingData.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hourglass_disabled_outlined,
                              size: size.width * 0.3, color: Colors.grey),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'No hay más usuarios por aceptar',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemCount: pendingData.length,
                        itemBuilder: (_, index) {
                          final item = pendingData[index];
                          return Dismissible(
                            key: Key(item.objectId!),
                            background: const RemoveDismiss(),
                            secondaryBackground: const AcceptDismiss(),
                            onDismissed: (direction) {
                              setState(() {
                                pendingData.remove(item);
                                if (direction == DismissDirection.startToEnd) {
                                  item is UserData
                                      ? backendProvider.deleteUser(
                                          context, item.objectId!)
                                      : backendProvider.deleteCar(
                                          context, item.objectId!);
                                } else {
                                  item is UserData
                                      ? backendProvider.aproveUser(
                                          context, item.objectId!)
                                      : backendProvider.aproveCar(
                                          context, item.objectId!);
                                }

                                if (pendingData.isEmpty) {
                                  dataFuture =
                                      BackendProvider.getPendingUsersAndCars();
                                }
                              });
                            },
                            child: CardInfo(item: item),
                          );
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
