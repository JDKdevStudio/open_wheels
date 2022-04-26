import 'package:open_wheels/classes/car.dart';

class UserData {
  int? birthday;
  int? lastLogin;
  String? role;
  String? address;
  String? userStatus;
  int? created;
  String? accountType;
  String? certificate;
  String? avatar;
  String? ownerId;
  String? socialAccount;
  Null? oAuthIdentities;
  List<Routes>? routes;
  List<Car>? cars;
  int? phone;
  String? surname;
  String? name;
  String? sClass;
  String? blUserLocale;
  int? id;
  int? updated;
  String? objectId;
  String? email;

  UserData(
      {this.birthday,
      this.lastLogin,
      this.role,
      this.address,
      this.userStatus,
      this.created,
      this.accountType,
      this.certificate,
      this.avatar,
      this.ownerId,
      this.socialAccount,
      this.oAuthIdentities,
      this.routes,
      this.cars,
      this.phone,
      this.surname,
      this.name,
      this.sClass,
      this.blUserLocale,
      this.id,
      this.updated,
      this.objectId,
      this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    lastLogin = json['lastLogin'];
    role = json['role'];
    address = json['address'];
    userStatus = json['userStatus'];
    created = json['created'];
    accountType = json['accountType'];
    certificate = json['certificate'];
    avatar = json['avatar'];
    ownerId = json['ownerId'];
    socialAccount = json['socialAccount'];
    oAuthIdentities = json['oAuthIdentities'];
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
    if (json['cars'] != null) {
      cars = <Car>[];
      json['cars'].forEach((v) {
        cars!.add(Car.fromJson(v));
      });
    }
    phone = json['phone'];
    surname = json['surname'];
    name = json['name'];
    sClass = json['___class'];
    blUserLocale = json['blUserLocale'];
    id = json['id'];
    updated = json['updated'];
    objectId = json['objectId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday;
    data['lastLogin'] = lastLogin;
    data['role'] = role;
    data['address'] = address;
    data['userStatus'] = userStatus;
    data['created'] = created;
    data['accountType'] = accountType;
    data['certificate'] = certificate;
    data['avatar'] = avatar;
    data['ownerId'] = ownerId;
    data['socialAccount'] = socialAccount;
    data['oAuthIdentities'] = oAuthIdentities;
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    data['phone'] = phone;
    data['surname'] = surname;
    data['name'] = name;
    data['___class'] = sClass;
    data['blUserLocale'] = blUserLocale;
    data['id'] = id;
    data['updated'] = updated;
    data['objectId'] = objectId;
    data['email'] = email;
    return data;
  }
}

class Routes {
  String? card;
  String? user;
  String? clase;
  String? color;
  String? photo;
  String? placa;
  String? modelo;
  int? capacidad;

  Routes(
      {this.card,
      this.user,
      this.clase,
      this.color,
      this.photo,
      this.placa,
      this.modelo,
      this.capacidad});

  Routes.fromJson(Map<String, dynamic> json) {
    card = json['card'];
    user = json['user'];
    clase = json['clase'];
    color = json['color'];
    photo = json['photo'];
    placa = json['placa'];
    modelo = json['modelo'];
    capacidad = json['capacidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card'] = card;
    data['user'] = user;
    data['clase'] = clase;
    data['color'] = color;
    data['photo'] = photo;
    data['placa'] = placa;
    data['modelo'] = modelo;
    data['capacidad'] = capacidad;
    return data;
  }
}
