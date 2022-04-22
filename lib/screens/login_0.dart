import 'package:flutter/material.dart';
import 'package:open_wheels/interface/input_decorations.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1C2321),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header principal--------------------------------------------------
            _Header(size: size, boxDecoration: boxDecoration),

            //Texto iniciar sesión----------------------------------------------
            const SizedBox(height: 40),
            const Text(
              'Iniciar Sesión',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
            ),

            //formulario para iniciar sesión------------------------------------
            const SizedBox(height: 30),
            ChangeNotifierProvider(
              create: (_) => FormProvider(),
              child: const _LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.size,
    required this.boxDecoration,
  }) : super(key: key);

  final Size size;
  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.25,
      decoration: boxDecoration,
      child: const MainLogo(),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<FormProvider>(context);
    final userdata = Provider.of<BackendProvider>(context, listen: false);

    return Form(
      key: loginForm.formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            //Correo Electrónico------------------------------------------------
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.inputDecoration1(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_outlined),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no es válido';
              },
              onChanged: (value) => loginForm.email = value,
            ),
            const SizedBox(
              height: 30,
            ),

            //Contraseña--------------------------------------------------------
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecorations.inputDecoration1(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_clock_outlined),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
              onChanged: (value) => loginForm.password = value,
            ),
            const SizedBox(
              height: 30,
            ),

            //Olvidaste tu contraseña-------------------------------------------
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'password'),
              child: Container(
                alignment: Alignment.centerRight,
                child: const Text('Olvidaste la contraseña?'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            //Botón iniciar sesión----------------------------------------------
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color(0xff1C2321),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      userdata
                          .loginUser(
                              user: loginForm.email, pass: loginForm.password)
                          .then(
                        (value) {
                          loginForm.isLoading = false;
                          if (value.email != null) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'home', (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Usuario o contraseña incorrectos'),
                                action: SnackBarAction(
                                    label: 'cerrar', onPressed: () {}),
                              ),
                            );
                          }
                        },
                      );
                    },
            ),
            const SizedBox(
              height: 30,
            ),

            //Registrarse-------------------------------------------------------
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'register'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('No tienes cuenta?'),
                  Text(
                    ' Registrate',
                    style: TextStyle(
                      color: Color(0xff7D98A1),
                      fontWeight: FontWeight.bold,
                    ),
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
