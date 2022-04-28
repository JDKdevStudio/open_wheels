class UserData {
  String? birthday;
  String? role;
  String? address;
  String? certificate;
  String? avatar;
  String? ownerId;
  String? phone;
  String? surname;
  String? name;
  String? id;
  double? rating;
  String? userToken;
  String? objectId;
  String? email;
  String? password;

  UserData(
      {this.birthday,
      this.role,
      this.address,
      this.certificate,
      this.avatar,
      this.ownerId,
      this.phone,
      this.surname,
      this.name,
      this.id,
      this.rating,
      this.userToken,
      this.objectId,
      this.email,
      this.password});

  UserData.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    role = json['role'];
    address = json['address'];
    certificate = json['certificate'];
    avatar = json['avatar'];
    ownerId = json['ownerId'];
    phone = json['phone'];
    surname = json['surname'];
    name = json['name'];
    id = json['id'];
    rating = json['rating'];
    userToken = json['user-token'];
    objectId = json['objectId'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday;
    data['role'] = role;
    data['address'] = address;
    data['certificate'] = certificate;
    data['avatar'] = avatar;
    data['ownerId'] = ownerId;
    data['phone'] = phone;
    data['surname'] = surname;
    data['name'] = name;
    data['id'] = id;
    data['rating'] = rating;
    data['user-token'] = userToken;
    data['objectId'] = objectId;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
