class Car {
  String? color;
  String? photo;
  String? modelo;
  String? clase;
  String? user;
  String? card;
  String? placa;
  int? capacidad;

  Car(
      {this.color,
      this.photo,
      this.modelo,
      this.clase,
      this.user,
      this.card,
      this.placa,
      this.capacidad});

  Car.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    photo = json['photo'];
    modelo = json['modelo'];
    clase = json['clase'];
    user = json['user'];
    card = json['card'];
    placa = json['placa'];
    capacidad = json['capacidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['photo'] = photo;
    data['modelo'] = modelo;
    data['clase'] = clase;
    data['user'] = user;
    data['card'] = card;
    data['placa'] = placa;
    data['capacidad'] = capacidad;
    return data;
  }
}
