import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  //properties
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmpassword = '';
  String name = '';
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? value) {
    _dateTime = value;
    notifyListeners();
  }

  bool _isLoading = false;

  //gets & sets
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
