import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_wheels/classes/classes.dart';

class BackendProvider extends ChangeNotifier {
//!Iniciar sesión---------------------------------------------------------------
  late UserData userData;
  Future<void> loginUser({required String user, required String pass}) async {
    var response = await http.post(
      Uri.parse('https://logicalgate.backendless.app/api/users/login'),
      body: jsonEncode({"login": user, "password": pass}),
      headers: {"Content-Type": "application/json"},
    );
    userData = UserData.fromJson(jsonDecode(response.body));
  }

//!Reiniciar contraseña---------------------------------------------------------
  Future<bool> resetUserPassword(BuildContext context, String email) async {
    var response = await http.get(Uri.parse(Uri.encodeFull(
        'https://logicalgate.backendless.app/api/users/restorepassword/$email')));
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

//!Registrar usuario------------------------------------------------------------
  Future<bool> userRegister(BuildContext context, UserData userRegister) async {
    var response = await http.post(
      Uri.parse('https://logicalgate.backendless.app/api/users/register'),
      body: jsonEncode(userRegister.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('El correo especificado ya está registrado'),
          action: SnackBarAction(label: 'cerrar', onPressed: () {}),
        ),
      );
      return false;
    }
    final userId = UserData.fromJson(jsonDecode(response.body)).objectId;
    response = await http.put(
      Uri.parse(
          'https://api.backendless.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/B30E6955-FFEA-401C-9C33-3CEA5BCE5034/users/$userId/status'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"userStatus": "DISABLED"},
      ),
    );
    return true;
  }

//!Obtener rutas----------------------------------------------------------------
  final List<Routes> _userRoutes = [];
  List<Routes> get userRoutes => _userRoutes;

  Future<List<Routes>> getUserRoutes() async {
    _userRoutes.clear();
    var response = await http.get(Uri.parse(
        'https://logicalgate.backendless.app/api/data/routes?where=user%20LIKE%20%27%25${userData.email}%25%27'));
    List<dynamic> results = jsonDecode(response.body);
    for (var e in results) {
      _userRoutes.add(Routes.fromJson(e));
    }
    return _userRoutes;
  }

//!Registrar rutas--------------------------------------------------------------
  Future<bool> routeRegister(Routes routes) async {
    var response = await http.post(
        Uri.parse('https://logicalgate.backendless.app/api/data/routes'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(routes.toJson()));
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

//!Obtener vehículos------------------------------------------------------------
  final List<Car> _userCars = [];
  List<Car> get userCars => _userCars;

  Future<List<Car>> getUserCars() async {
    _userCars.clear();
    var response = await http.get(
      Uri.parse(
          'https://logicalgate.backendless.app/api/data/cars?where=carStatus%20%3D%27ENABLED%27%20and%20user%3D%27${userData.email}%27'),
    );
    List<dynamic> results = jsonDecode(response.body);
    for (var e in results) {
      _userCars.add(Car.fromJson(e));
    }
    return _userCars;
  }

  //!Registrar vehículo---------------------------------------------------------
  Future<bool> carRegister(BuildContext context, Car car) async {
    var response = await http.post(
        Uri.parse('https://logicalgate.backendless.app/api/data/cars'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(car.toJson()));
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  //!Panel administrador--------------------------------------------------------

  static Future<List<dynamic>> getPendingUsersAndCars() async {
    List<dynamic> dataFuture = [];
    await Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        //get Pending Users
        var response = await http.get(
          Uri.parse(
              'https://logicalgate.backendless.app/api/data/Users?where=userStatus%3D%27DISABLED%27'),
        );
        List<dynamic> results = jsonDecode(response.body);
        for (var e in results) {
          dataFuture.add(UserData.fromJson(e));
        }

        //get Pending Cars
        response = await http.get(
          Uri.parse(
              'https://logicalgate.backendless.app/api/data/cars?where=carStatus%3D%27DISABLED%27'),
        );
        results = jsonDecode(response.body);
        for (var e in results) {
          dataFuture.add(Car.fromJson(e));
        }
      },
    );

    return dataFuture;
  }

  Future<void> aproveUser(BuildContext context, String userId) async {
    var response = await http.put(
      Uri.parse(
          'https://api.backendless.com/5CA932F0-D1D2-EE15-FF54-D3B5A8EE8C00/B30E6955-FFEA-401C-9C33-3CEA5BCE5034/users/$userId/status'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"userStatus": "ENABLED"},
      ),
    );
    if (response.statusCode != 200) {}
  }

  Future<void> deleteUser(BuildContext context, String objectId) async {
    var response = await http.delete(
      Uri.parse('https://logicalgate.backendless.app/api/data/Users'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"objectId": objectId}),
    );
    if (response.statusCode != 200) {}
  }

  Future<void> aproveCar(BuildContext context, String objectId) async {
    var response = await http.put(
      Uri.parse('https://logicalgate.backendless.app/api/data/cars/$objectId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"carStatus": "ENABLED"},
      ),
    );
    if (response.statusCode != 200) {}
  }

  Future<void> deleteCar(BuildContext context, String objectId) async {
    var response = await http.delete(Uri.parse(
        'https://logicalgate.backendless.app/api/data/cars/$objectId'));
    if (response.statusCode != 200) {}
  }
}
