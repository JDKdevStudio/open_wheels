import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
import 'package:open_wheels/classes/place_search.dart';
import 'package:open_wheels/services/places_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FormProvider extends ChangeNotifier {
  //*Global key formController--------------------------------------------------
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //*Correo electrónico---------------------------------------------------------
  String email = '';

  //*Contraseña-----------------------------------------------------------------
  String password = '';
  String confirmpassword = '';

  //*Nombres--------------------------------------------------------------------
  String name = '';

  //*Apellidos------------------------------------------------------------------
  String surname = '';

  //*Fecha de nacimiento--------------------------------------------------------
  final datePicker = TextEditingController();
  DateTime? dateTime;

//*Identificación---------------------------------------------------------------
  String identificacion = '';

//*Dirección--------------------------------------------------------------------
  String address = '';

//*Teléfono---------------------------------------------------------------------
  String phone = '';

//*Foto de perfil---------------------------------------------------------------
  final photoName = TextEditingController();
  String photo = '';
  late int pickController;

//*Certificado judicial---------------------------------------------------------
  final certificateName = TextEditingController();
  String certificate = '';

//*file picker && upload cloudinary---------------------------------------------
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  String? get fileName => _fileName;
  final cloudinary = CloudinaryPublic('dawkdwxla', 'g3lubojk', cache: false);

  pickPhoto() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      pickedfile = result!.files.first;
      _fileName = result!.files.first.name;

      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(pickedfile!.path!,
                resourceType: CloudinaryResourceType.Image));
        switch (pickController) {
          case 0:
            photoName.text = _fileName!;
            photo = response.secureUrl;
            break;
          case 1:
            certificateName.text = _fileName!;
            certificate = response.secureUrl;
            break;
          case 2:
            photoCarName.text = _fileName!;
            photoCar = response.secureUrl;
            break;
        }
        notifyListeners();
      } on CloudinaryException {
        throw 'error';
      }
    }
  }

//*Resetear PickerValues--------------------------------------------------------
  void resetPicker() {
    photo =
        'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/user.png';
    photoName.text = '';
    certificate =
        'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/certificate.png';
    certificateName.text = '';
    datePicker.text = '';
    dateTime = null;
    photoCar =
        'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/photoCar.png';
    photoCarName.text = '';
    pointOriginName.text = '';
    pointFinalName.text = '';
    routeDatePicker.text = '';
    routeTimePicker.text = '';
    routeDate = null;
    routeTime = null;
    routeVehicle = null;
  }

//*Generar userRegiser class----------------------------------------------------
  UserData userDataValues() {
    return UserData(
      email: email,
      password: password,
      name: name,
      surname: surname,
      birthday: dateTime.toString(),
      id: identificacion,
      address: address,
      phone: phone,
      avatar: photo,
      certificate: certificate,
    );
  }

//?Placa vehículo---------------------------------------------------------------
  String placa = '';

//?Modelo vehículo--------------------------------------------------------------
  String modelo = '';

//?Clase vehículo---------------------------------------------------------------
  String clase = '';

//?Capacidad vehículo-----------------------------------------------------------
  String capacidad = '';

//?Color vehículo---------------------------------------------------------------
  String color = '';

//?Foto vehículo----------------------------------------------------------------
  final photoCarName = TextEditingController();
  String photoCar = '';

//?Generar Car class------------------------------------------------------------
  Car carDataValues(String user) {
    var carId = const Uuid();
    return Car(
      carStatus: 'DISABLED',
      color: color,
      photo: photoCar,
      modelo: modelo,
      carId: carId.v1(),
      clase: clase,
      user: user,
      card: certificate,
      placa: placa,
      capacidad: int.parse(capacidad),
    );
  }

//!Nombre ruta------------------------------------------------------------------
  String routeName = '';

//!Punto origen-----------------------------------------------------------------
  String pointOriginImage =
      'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/location.png';
  final pointOriginName = TextEditingController();
  String pointOrigin = '';

//!Punto final------------------------------------------------------------------
  final pointFinalName = TextEditingController();
  String pointFinal = '';

//!Fecha de ruta----------------------------------------------------------------
  final routeDatePicker = TextEditingController();
  DateTime? routeDate;

//!Hora de ruta-----------------------------------------------------------------
  final routeTimePicker = TextEditingController();
  TimeOfDay? routeTime;

//!Vehículo de ruta-------------------------------------------------------------
  Car? routeVehicle;

//!Generar Route class----------------------------------------------------------
  Future<Routes> routesDataValues(
      BuildContext context, UserData userData) async {
    var routeId = const Uuid();
    final registerRoute = Provider.of<PlacesService>(context, listen: false);
    late final Map<String, dynamic> path;
    final routeDateTime = DateTime(
      routeDate!.day,
      routeDate!.month,
      routeDate!.year,
      routeTime!.hour,
      routeTime!.minute,
    );
    await registerRoute
        .getDirections(pointOrigin, pointFinal)
        .then((value) => path = value);
    return Routes(
      car: routeVehicle,
      cupos: routeVehicle!.capacidad,
      datetime: routeDateTime.toString(),
      name: routeName,
      path: path,
      user: userData,
      routeId: routeId.v1(),
    );
  }

//*Validar formulario-----------------------------------------------------------
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
