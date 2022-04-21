import 'package:flutter/material.dart';
import 'package:open_wheels/interface/input_decorations.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            //Header principal----------------------------------------------------
            _Header(size: size, boxDecoration: boxDecoration),

            //Texto registrarse---------------------------------------------------
            const SizedBox(height: 40),

            //Register Steps
            ChangeNotifierProvider(
                create: (_) => FormProvider(),
                child: Expanded(child: _RegisterForm())),
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<FormProvider>(context, listen: false);
    return Form(
        key: registerForm.formkey,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                Text(
                  'Registrarse',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                ),
                _FormFields(),
              ],
            ),
          ),
        ));
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

class _FormFields extends StatelessWidget {
  const _FormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<FormProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Correo Electrónico--------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
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
            onChanged: (value) => registerForm.email = value,
          ),
          const SizedBox(
            height: 30,
          ),

          //Contraseña----------------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_clock_outlined),
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
            onChanged: (value) => registerForm.password = value,
          ),
          const SizedBox(
            height: 30,
          ),

          //Confirmar contraseña------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Confirmar Contraseña',
                prefixIcon: Icons.lock_clock_outlined),
            validator: (value) {
              var val = value ?? '';
              return (registerForm.password == registerForm.confirmpassword &&
                      val.isNotEmpty)
                  ? null
                  : 'Las contraseñas no coinciden';
            },
            onChanged: (value) => registerForm.confirmpassword = value,
          ),
          const SizedBox(
            height: 30,
          ),

          //Nombres-------------------------------------------------------------
          TextFormField(
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'John Doe',
                labelText: 'Nombres',
                prefixIcon: Icons.text_fields_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir un nombre válido';
            },
            onChanged: (value) => registerForm.name = value,
          ),
          const SizedBox(
            height: 30,
          ),

          //Apellidos---------------------------------------------------------
          TextFormField(
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Walter Mora',
                labelText: 'Apellidos',
                prefixIcon: Icons.text_fields_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir un apellido válido';
            },
            onChanged: (value) => registerForm.name = value,
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_clock_outlined),
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
            onChanged: (value) => registerForm.password = value,
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
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                registerForm.isLoading ? 'Espere' : 'Registrar',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            onPressed: registerForm.isLoading
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;
                    //   userdata
                    //       .loginUser(
                    //           user: registerForm.email, pass: registerForm.password)
                    //       .then(
                    //     (value) {
                    //       registerForm.isLoading = false;
                    //       if (value.email != null) {
                    //         Navigator.pushNamedAndRemoveUntil(
                    //             context, 'home', (route) => false);
                    //       } else {
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(
                    //             content: const Text(
                    //                 'Usuario o contraseña incorrectos'),
                    //             action: SnackBarAction(
                    //                 label: 'cerrar', onPressed: () {}),
                    //           ),
                    //         );
                    //       }
                    //     },
                    //   );
                    // },
                    showDatePicker(
                            context: context,
                            initialDate: DateTime(2021, 4, 21),
                            firstDate: DateTime(1900, 4, 21),
                            lastDate: DateTime(2022))
                        .then((value) => registerForm.dateTime = value);
                  },
          ),
          const SizedBox(
            height: 30,
          ),
          Text(registerForm.dateTime.toString()),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff30BAD6),
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              'Bienvenido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xff0098FA),
              shape: const StadiumBorder()),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
