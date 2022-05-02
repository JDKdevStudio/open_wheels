import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_wheels/interface/input_decorations.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterCarScreen extends StatelessWidget {
  const RegisterCarScreen({Key? key}) : super(key: key);

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
      backgroundColor: Colors.white,
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
            Expanded(child: _RegisterCarForm()),
          ],
        ),
      ),
    );
  }
}

class _RegisterCarForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerCarForm = Provider.of<FormProvider>(context, listen: false);
    return Form(
        key: registerCarForm.formkey,
        child: ScrollConfiguration(
          behavior: MyBehavior2(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                Text(
                  'Registrar vehículo',
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
    final registerCar = Provider.of<BackendProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //*Placa del vehículo-------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'AFK-123',
                labelText: 'Paca',
                prefixIcon: Icons.notes_outlined),
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'Debes escribir un número de placa válido';
            },
            onChanged: (value) => registerForm.placa = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Modelo del vehículo------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Toyota Corola',
                labelText: 'Modelo',
                prefixIcon: Icons.directions_car_outlined),
            validator: (value) {
              return (value != null && value.length >= 8)
                  ? null
                  : 'Debes escribir un modelo de vehículo válido';
            },
            onChanged: (value) => registerForm.modelo = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Clase del vehículo------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Cuatrimoto',
                labelText: 'Clase de Vehículo',
                prefixIcon: Icons.garage_outlined),
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'Debes escribir una clase de vehículo válido';
            },
            onChanged: (value) => registerForm.clase = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Capacidad del vehículo---------------------------------------------
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecorations.inputDecoration1(
                hintText: '4',
                labelText: 'Capacidad',
                prefixIcon: Icons.groups_outlined),
            validator: (value) {
              return (value != null && value.length == 1)
                  ? null
                  : 'Debes escribir una capacidad válida';
            },
            onChanged: (value) => registerForm.capacidad = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Color del vehículo------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Verde',
                labelText: 'Color',
                prefixIcon: Icons.palette_outlined),
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'Debes escribir una color de vehículo válido';
            },
            onChanged: (value) => registerForm.color = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Foto de vehículo---------------------------------------------------
          TextFormField(
            controller: registerForm.photoCarName,
            onTap: () {
              registerForm.pickController = 2;
              registerForm.pickPhoto();
            },
            readOnly: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecorations.inputDecoration2(
              hintText: 'my-car-photo.png',
              labelText: 'Foto de Vehículo',
              prefixImage: registerForm.photoCar,
              suffixIcon: Icons.link_outlined,
            ),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes subir una foto válida';
            },
          ),
          const SizedBox(
            height: 30,
          ),

          //*Tarjeta Propiedad--------------------------------------------------
          TextFormField(
            controller: registerForm.certificateName,
            onTap: () {
              registerForm.pickController = 1;
              registerForm.pickPhoto();
            },
            readOnly: true,
            decoration: InputDecorations.inputDecoration2(
              hintText: 'my-property-card.png',
              labelText: 'Tarjeta de Propiedad',
              prefixImage: registerForm.certificate,
              suffixIcon: Icons.link_outlined,
            ),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes subir un certificado válido';
            },
          ),
          const SizedBox(
            height: 30,
          ),

          //*Botón Registrar vehículo-------------------------------------------
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

                    registerCar
                        .carRegister(
                            context,
                            registerForm
                                .carDataValues(registerCar.userData.email!))
                        .then(
                      (value) {
                        registerForm.isLoading = false;
                        if (value == true) {
                          Navigator.pushReplacementNamed(
                            context,
                            'warnings',
                            arguments: {
                              'icon': Icons.check_circle_outlined,
                              'title': 'Registro exitoso',
                              'data':
                                  'Vehículo registrado exitosamente, te notificaremos cuando hayamos aprobado tus documentos.'
                            },
                          );
                        }
                      },
                    );
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

class MyBehavior2 extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
