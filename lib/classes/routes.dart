import 'package:open_wheels/classes/classes.dart';

class Routes {
  String? name;
  Map<String, dynamic>? paradas;
  int? cupos;
  Map<String, dynamic>? path;
  String? datetime;
  String? routeId;
  Car? car;
  String? routeStatus;
  UserData? user;
  String? objectId;

  Routes(
      {this.name,
      this.paradas,
      this.cupos,
      this.path,
      this.datetime,
      this.routeId,
      this.car,
      this.routeStatus,
      this.user,
      this.objectId});

  Routes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    paradas = json['paradas'];
    cupos = json['cupos'];
    path = json['path'];
    datetime = json['datetime'];
    routeId = json['routeId'];
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    routeStatus = json['routeStatus'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
    objectId = json['objectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['paradas'] = paradas;
    data['cupos'] = cupos;
    data['path'] = path;
    data['datetime'] = datetime;
    data['routeId'] = routeId;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['routeStatus'] = routeStatus;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['objectId'] = objectId;
    return data;
  }
}
