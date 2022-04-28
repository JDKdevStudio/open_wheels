class Car {
  String? carStatus;
  String? color;
  String? photo;
  String? modelo;
  String? carId;
  String? clase;
  String? user;
  String? objectId;
  String? card;
  String? placa;
  int? capacidad;

  Car(
      {this.carStatus,
      this.color,
      this.photo,
      this.modelo,
      this.carId,
      this.clase,
      this.user,
      this.objectId,
      this.card,
      this.placa,
      this.capacidad});

  Car.fromJson(Map<String, dynamic> json) {
    carStatus = json['carStatus'];
    color = json['color'];
    photo = json['photo'];
    modelo = json['modelo'];
    carId = json['carId'];
    clase = json['clase'];
    user = json['user'];
    objectId = json['objectId'];
    card = json['card'];
    placa = json['placa'];
    capacidad = json['capacidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carStatus'] = carStatus;
    data['color'] = color;
    data['photo'] = photo;
    data['modelo'] = modelo;
    data['carId'] = carId;
    data['clase'] = clase;
    data['user'] = user;
    data['objectId'] = objectId;
    data['card'] = card;
    data['placa'] = placa;
    data['capacidad'] = capacidad;
    return data;
  }
}
