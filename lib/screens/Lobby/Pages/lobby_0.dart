import 'package:flutter/material.dart';
import 'package:open_wheels/providers/form_provider.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            //el background acomoda el header y los botones en sus métodos
            child: Background(
              logo: const MainLogo(),
              buttons: Column(
                children: [
                  //Boton para iniciar sesión
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, 'login'),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 17),
                    ),
                    style: TextButton.styleFrom(
                      maximumSize: Size(size.width * 0.66, size.height * 0.054),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff1C2321),
                      fixedSize: const Size.fromWidth(250),
                    ),
                  ),

                  //Espaciador
                  const SizedBox(
                    height: 15,
                  ),

                  //Botón para registrarse
                  ElevatedButton(
                    onPressed: () {
                      final resetRegister =
                          Provider.of<FormProvider>(context, listen: false);
                      resetRegister.resetPicker();
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 17),
                    ),
                    style: TextButton.styleFrom(
                      maximumSize: Size(size.width * 0.66, size.height * 0.054),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff7D98A1),
                      fixedSize: const Size.fromWidth(250),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
