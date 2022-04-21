import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_wheels/classes/user_data.dart';

class BackendProvider extends ChangeNotifier {
  late UserData user;

  Future<UserData> loginUser(
      {required String user, required String pass}) async {
    var response = await http.post(
      Uri.parse('https://logicalgate.backendless.app/api/users/login'),
      body: jsonEncode({"login": user, "password": pass}),
      headers: {"Content-Type": "application/json"},
    );
    final userData = UserData.fromJson(jsonDecode(response.body));
    return userData;
  }

//Reiniciar contraseña----------------------------------------------------------
  Future<bool> resetUserPassword(BuildContext context, String email) async {
    late final http.Response response;
    await APIManager.getAPICall(
      context,
      Uri.parse(
        Uri.encodeFull(
            'https://logicalgate.backendless.app/api/users/restorepassword/$email'),
      ),
    ).then((value) {
      if (value == null) return;
      response = value;
    });
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('El correo especificado no está registrado'),
          action: SnackBarAction(label: 'cerrar', onPressed: () {}),
        ),
      );
      return false;
    }
    return true;
  }
}

//Clase de soporte para manejar todos los errores de httpRequest----------------
class APIManager {
  //Método de acceso global para hacer getAPI-----------------------------------
  static Future<dynamic> getAPICall(BuildContext context, Uri url,
      {Map<String, String>? headers}) async {
    late final http.Response response;
    try {
      response = await http.get(url, headers: headers);
      return response;
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Parece que no estás conecatado a internet, intentalo más tarde'),
          action: SnackBarAction(label: 'cerrar', onPressed: () {}),
        ),
      );
    } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Parece que hubo un error, intentalo más tarde'),
          action: SnackBarAction(label: 'cerrar', onPressed: () {}),
        ),
      );
    } on Error {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Parece que hubo un error, intentalo más tarde'),
          action: SnackBarAction(label: 'cerrar', onPressed: () {}),
        ),
      );
    }
  }
}
