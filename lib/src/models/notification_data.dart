class NotificationData {
  int? id;
  String? deviceId;
  String? text;
  int? read;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;

  NotificationData(
      {this.id,
        this.deviceId,
        this.text,
        this.read,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    text = json['text'];
    read = json['read'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['device_id'] = deviceId;
    data['text'] = text;
    data['read'] = read;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstname;
  String? lastname;

  User({this.id, this.firstname, this.lastname});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
