import 'package:flutter/material.dart';
import 'package:open_wheels/interface/input_decorations.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/search/search_route_point.dart';
import 'package:open_wheels/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterRouteScreen extends StatelessWidget {
  const RegisterRouteScreen({Key? key}) : super(key: key);

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
            Expanded(child: _RegisterRouteForm()),
          ],
        ),
      ),
    );
  }
}

class _RegisterRouteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerRouteForm = Provider.of<FormProvider>(context, listen: false);
    return Form(
        key: registerRouteForm.formkey,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                Text(
                  'Registrar ruta',
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
    final registerRouteForm = Provider.of<FormProvider>(context);
    final registerRoute = Provider.of<BackendProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //*nombre de la ruta--------------------------------------------------
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Provenza - UPB',
                labelText: 'Nombre',
                prefixIcon: Icons.text_fields_outlined),
            validator: (value) {
              return (value != null && value.length >= 5)
                  ? null
                  : 'Debes escribir un nombre de ruta válido';
            },
            onChanged: (value) => registerRouteForm.routeName = value.trim(),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Punto origen-------------------------------------------------------
          TextFormField(
            controller: registerRouteForm.pointOriginName,
            onTap: () async {
              List<dynamic> origin = await showSearch(
                  context: context, delegate: SearchPlacesAddress());
              if (origin.isNotEmpty) {
                registerRouteForm.pointOriginName.text = origin[0];
                registerRouteForm.pointOrigin = origin[1];
              }
            },
            readOnly: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecorations.inputDecoration2(
              hintText: 'Universidad Pontificia Bolivariana',
              labelText: 'Punto de Origen',
              prefixImage: registerRouteForm.pointOriginImage,
              suffixIcon: Icons.link_outlined,
            ),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes seleccionar un punto de origen válido';
            },
          ),
          const SizedBox(
            height: 30,
          ),

          //*Punto final--------------------------------------------------------
          TextFormField(
            controller: registerRouteForm.pointFinalName,
            onTap: () async {
              List<dynamic> origin = await showSearch(
                  context: context, delegate: SearchPlacesAddress());
              if (origin.isNotEmpty) {
                registerRouteForm.pointFinalName.text = origin[0];
                registerRouteForm.pointFinal = origin[1];
              }
            },
            readOnly: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecorations.inputDecoration2(
              hintText: 'Provenza',
              labelText: 'Punto de Llegada',
              prefixImage: registerRouteForm.pointOriginImage,
              suffixIcon: Icons.link_outlined,
            ),
            validator: (value) {
              return ((value ?? '').trim().isNotEmpty)
                  ? null
                  : 'Debes seleccionar un punto de llegada válido';
            },
          ),
          const SizedBox(
            height: 30,
          ),

//*Fecha de ruta----------------------------------------------------------------
          TextFormField(
            controller: registerRouteForm.routeDatePicker,
            readOnly: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'Día/Mes/Año',
                labelText: 'Fecha de inicio',
                prefixIcon: Icons.calendar_month_outlined),
            validator: (value) {
              return (registerRouteForm.routeDate != null)
                  ? null
                  : 'Debes elegir una fecha de inicio válida';
            },
            onTap: () => showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime(DateTime.now().year + 1))
                .then(
              (value) {
                if (value != null) {
                  registerRouteForm.routeDate = value;
                  registerRouteForm.routeDatePicker.text =
                      '${value.day}/${value.month}/${value.year}';
                }
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          //*hora de ruta-------------------------------------------------------
          TextFormField(
            controller: registerRouteForm.routeTimePicker,
            readOnly: true,
            decoration: InputDecorations.inputDecoration1(
                hintText: 'HH:MM:SS',
                labelText: 'Hora de inicio',
                prefixIcon: Icons.timer_outlined),
            validator: (value) {
              return (registerRouteForm.routeDate != null)
                  ? null
                  : 'Debes elegir una hora de inicio válida';
            },
            onTap: () =>
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) {
              if (value != null) {
                registerRouteForm.routeTime = value;
                registerRouteForm.routeTimePicker.text =
                    '${value.hour}:${value.minute}';
              }
            }),
          ),
          const SizedBox(
            height: 30,
          ),

          //*Carro de ruta------------------------------------------------------
          DropdownButtonFormField(
            hint: const Text('Vehículo de ruta'),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.directions_car_outlined,
                color: Colors.grey,
              ),
            ),
            items: [
              ...registerRoute.userCars
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e.placa!,
                      child: Text(e.placa!),
                    ),
                  )
                  .toList()
            ],
            onChanged: (value) {
              registerRouteForm.routeVehicle =
                  registerRoute.userCars.firstWhere((e) => e.placa == value);
            },
            validator: (value) {
              return (registerRouteForm.routeVehicle != null)
                  ? null
                  : 'Debes elegir un vehículo para registrar la ruta';
            },
          ),
          const SizedBox(
            height: 30,
          ),

          //*Botón Registrar ruta-----------------------------------------------
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
                registerRouteForm.isLoading ? 'Espere' : 'Registrar',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            onPressed: registerRouteForm.isLoading
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    if (!registerRouteForm.isValidForm()) return;
                    registerRouteForm.isLoading = true;
                    registerRouteForm
                        .routesDataValues(context, registerRoute.userData)
                        .then((e) {
                      registerRoute.routeRegister(e).then(
                        (value) {
                          registerRouteForm.isLoading = false;
                          if (value == true) {
                            Navigator.pushReplacementNamed(
                              context,
                              'warnings',
                              arguments: {
                                'icon': Icons.check_circle_outlined,
                                'title': 'Registro exitoso',
                                'data':
                                    'Ruta registrada exitosamente, ahora pueden ingresar usuarios al recorrido.'
                              },
                            );
                          }
                        },
                      );
                    });
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
