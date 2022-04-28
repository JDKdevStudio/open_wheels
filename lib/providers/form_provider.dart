import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';
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
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? value) {
    _dateTime = value;
    notifyListeners();
  }

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
    photoCar =
        'https://backendlessappcontent.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/11F83B1D-DE01-4318-852F-1B9E4AECE9E1/files/open_wheels/res/photoCar.png';
    photoCarName.text = '';
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
