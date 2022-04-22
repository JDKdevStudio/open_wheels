import 'package:flutter/material.dart';
import 'package:open_wheels/interface/input_decorations.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
              'Recuperar Clave',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
            ),

            //formulario para recuperar contraseña------------------------------
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
    final resetForm = Provider.of<FormProvider>(context);
    final resetPassword = Provider.of<BackendProvider>(context, listen: false);

    return Form(
      key: resetForm.formkey,
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
              onChanged: (value) => resetForm.email = value,
            ),
            const SizedBox(
              height: 30,
            ),

            //Botón recuperar contraseña----------------------------------------
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color(0xff1C2321),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: Text(
                  resetForm.isLoading ? 'Espere' : 'Reestablecer Contraseña',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: resetForm.isLoading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      if (!resetForm.isValidForm()) return;
                      resetForm.isLoading = true;
                      resetPassword
                          .resetUserPassword(context, resetForm.email)
                          .then(
                        (value) {
                          resetForm.isLoading = false;
                          if (value == true) {
                            Navigator.pushReplacementNamed(
                              context,
                              'warnings',
                              arguments: {
                                'icon': Icons.check_circle_outlined,
                                'title': 'Reestablecer Contraseña',
                                'data':
                                    'Te hemos enviado al correo un enlace para que puedas recuperar tu contraseña de forma segura.'
                              },
                            );
                          }
                        },
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
