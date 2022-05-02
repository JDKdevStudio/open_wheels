import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Future<List<UserData>> dataFuture;
  @override
  void initState() {
    dataFuture = BackendProvider.getPendingUsers();
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
                  'Solicitudes Pendientes',
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
        FutureBuilder<List<UserData>>(
          future: dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final pendingUsers = snapshot.data!;
              return pendingUsers.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text('No hay más usuarios por aceptar'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: pendingUsers.length,
                        itemBuilder: (context, index) {
                          final item = pendingUsers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffFAFDFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ClipRRect(
                                child: Dismissible(
                                  key: Key(item.email!),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(item.avatar!),
                                          radius: 35,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(item.name!),
                                          Text(item.email!),
                                        ],
                                      ),
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.info_outline,
                                          size: 35,
                                        ),
                                        onTap: () => Navigator.pushNamed(
                                            context, 'profile',
                                            arguments: item),
                                      ),
                                    ],
                                  ),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red[900],
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green[900],
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                    } else {
                                      setState(() {
                                        pendingUsers.remove(item);
                                        backendProvider.aproveUser(
                                            context, item.objectId!);
                                        if (pendingUsers.isEmpty) {
                                          dataFuture =
                                              BackendProvider.getPendingUsers();
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          },
        )
      ],
    );
  }
}
