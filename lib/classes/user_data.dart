class UserData {
  String? userStatus;
  String? userToken;
  String? objectId;
  String? email;

  UserData({this.userStatus, this.userToken, this.objectId, this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    userStatus = json['userStatus'];
    userToken = json['user-token'];
    objectId = json['objectId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userStatus'] = userStatus;
    data['user-token'] = userToken;
    data['objectId'] = objectId;
    data['email'] = email;
    return data;
  }
}
