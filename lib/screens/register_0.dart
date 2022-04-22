import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            //*Header principal-------------------------------------------------
            _Header(size: size, boxDecoration: boxDecoration),

            //*Texto registrarse------------------------------------------------
            const SizedBox(height: 40),

            //*Register Steps---------------------------------------------------
            Expanded(child: _RegisterForm()),
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
    registerForm.photo =
        'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/user.png';
    registerForm.photoName.text = '';
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
          //*Correo Electrónico-------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
            onChanged: (value) => registerForm.email = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Contraseña---------------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
            onChanged: (value) => registerForm.password = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Confirmar contraseña-----------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.inputDecoration1(
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
            onChanged: (value) => registerForm.confirmpassword = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Nombres------------------------------------------------------------
          TextFormField(
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'John Doe',
                labelText: 'Nombres',
                prefixIcon: Icons.text_fields_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir un nombre válido';
            },
            onChanged: (value) => registerForm.name = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Apellidos----------------------------------------------------------
          TextFormField(
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Walter Mora',
                labelText: 'Apellidos',
                prefixIcon: Icons.text_fields_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir un apellido válido';
            },
            onChanged: (value) => registerForm.surname = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Fecha de nacimiento------------------------------------------------
          TextFormField(
            controller: registerForm.datePicker,
            readOnly: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Día/Mes/Año',
                labelText: 'Fecha de nacimiento',
                prefixIcon: Icons.calendar_month_outlined),
            validator: (value) {
              return (registerForm.dateTime != null)
                  ? null
                  : 'Debes elegir una fecha de nacimiento válida';
            },
            onTap: () => showDatePicker(
                    context: context,
                    initialDate: DateTime(2021, 4, 21),
                    firstDate: DateTime(1900, 4, 21),
                    lastDate: DateTime(2022))
                .then(
              (value) {
                if (value != null) {
                  registerForm.dateTime = value;
                  registerForm.datePicker.text =
                      '${registerForm.dateTime?.day}/${registerForm.dateTime?.month}/${registerForm.dateTime?.year}';
                }
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Cedula ciudadanía--------------------------------------------------
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: '1078160138',
                labelText: 'Identifiación',
                prefixIcon: Icons.credit_card_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir una identificación válida';
            },
            onChanged: (value) => registerForm.identificacion = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Dirección----------------------------------------------------------
          TextFormField(
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Wall Street',
                labelText: 'Dirección',
                prefixIcon: Icons.route_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir una Dirección válida';
            },
            onChanged: (value) => registerForm.address = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Teléfono-----------------------------------------------------------
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: '000 000 0000',
                labelText: 'Teléfono',
                prefixIcon: Icons.phone_outlined),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty &&
                      (value?.length ?? 0) > 7)
                  ? null
                  : 'Debes escribir un teléfono válido';
            },
            onChanged: (value) => registerForm.phone = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Foto de Perfil-----------------------------------------------------
          TextFormField(
            controller: registerForm.photoName,
            onTap: registerForm.pickPhoto,
            readOnly: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: true,
            decoration: InputDecorations.inputDecoration2(
              hintText: 'my-user-photo.png',
              labelText: 'Foto de Perfil',
              prefixImage: registerForm.photo,
              suffixIcon: Icons.link_outlined,
            ),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes escribir una identificación válida';
            },
          ),
          const SizedBox(
            height: 30,
          ),

          CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: 110,
            backgroundImage: NetworkImage(registerForm.photo),
          ),

          //*Botón iniciar sesión-----------------------------------------------
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
                  },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
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
