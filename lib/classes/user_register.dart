class UserRegister {
  int? birthday;
  String? role;
  String? address;
  String? userStatus;
  String? certificate;
  String? avatar;
  int? phone;
  String? surname;
  String? name;
  int? id;
  String? email;

  UserRegister(
      {this.birthday,
      this.role,
      this.address,
      this.userStatus,
      this.certificate,
      this.avatar,
      this.phone,
      this.surname,
      this.name,
      this.id,
      this.email});

  UserRegister.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    role = json['role'];
    address = json['address'];
    userStatus = json['userStatus'];
    certificate = json['certificate'];
    avatar = json['avatar'];
    phone = json['phone'];
    surname = json['surname'];
    name = json['name'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday;
    data['role'] = role;
    data['address'] = address;
    data['userStatus'] = userStatus;
    data['certificate'] = certificate;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['surname'] = surname;
    data['name'] = name;
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}
