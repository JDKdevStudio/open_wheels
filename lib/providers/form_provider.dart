import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  //properties------------------------------------------------------------------

  //Global key formController
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //Correo electrónico
  String email = '';

  //Contraseña
  String password = '';
  String confirmpassword = '';

  //Nombres
  String name = '';

  //Apellidos
  String surname = '';

  //Fecha de nacimiento
  final datePicker = TextEditingController();
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? value) {
    _dateTime = value;
    notifyListeners();
  }

//Identificación
  String identificacion = '';

//Dirección
  String address = '';

//Teléfono
  String phone = '';

//Foto de perfil
  final photoName = TextEditingController();
  late String photo;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  String? get fileName => _fileName;
  final cloudinary = CloudinaryPublic('dawkdwxla', 'g3lubojk', cache: false);

  pickPhoto() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null) {
      pickedfile = result!.files.first;
      _fileName = result!.files.first.name;
      photoName.text = _fileName!;
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(pickedfile!.path!,
                resourceType: CloudinaryResourceType.Image));

        photo = response.secureUrl;
        notifyListeners();
      } on CloudinaryException {
        print('xd');
      } on SocketException {
      } on Error {}
    }
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//methods
  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
