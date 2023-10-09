class UserData {
  String? token;
  String? email;
  User? user;

  UserData({this.token, this.email, this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['email'] = email;
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
  dynamic street;
  dynamic housenumber;
  dynamic postal;
  dynamic city;
  dynamic country;
  dynamic birthdate;
  dynamic gender;
  dynamic phone;
  dynamic study;
  dynamic studyYear;
  dynamic accountNumber;
  dynamic bic;
  dynamic instructorDate;
  String? status;
  String? qrsCity;
  dynamic driversLicense;
  int? instructor;
  dynamic instructorType;
  dynamic coordinator;
  dynamic van;
  dynamic student;
  dynamic studentType;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  dynamic updatedAt;

  User(
      {this.id,
        this.firstname,
        this.lastname,
        this.street,
        this.housenumber,
        this.postal,
        this.city,
        this.country,
        this.birthdate,
        this.gender,
        this.phone,
        this.study,
        this.studyYear,
        this.accountNumber,
        this.bic,
        this.instructorDate,
        this.status,
        this.qrsCity,
        this.driversLicense,
        this.instructor,
        this.instructorType,
        this.coordinator,
        this.van,
        this.student,
        this.studentType,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'];
    housenumber = json['housenumber'];
    postal = json['postal'];
    city = json['city'];
    country = json['country'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    phone = json['phone'];
    study = json['study'];
    studyYear = json['study_year'];
    accountNumber = json['account_number'];
    bic = json['bic'];
    instructorDate = json['instructor_date'];
    status = json['status'];
    qrsCity = json['qrs_city'];
    driversLicense = json['drivers_license'];
    instructor = json['instructor'];
    instructorType = json['instructor_type'];
    coordinator = json['coordinator'];
    van = json['van'];
    student = json['student'];
    studentType = json['student_type'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['street'] = street;
    data['housenumber'] = housenumber;
    data['postal'] = postal;
    data['city'] = city;
    data['country'] = country;
    data['birthdate'] = birthdate;
    data['gender'] = gender;
    data['phone'] = phone;
    data['study'] = study;
    data['study_year'] = studyYear;
    data['account_number'] = accountNumber;
    data['bic'] = bic;
    data['instructor_date'] = instructorDate;
    data['status'] = status;
    data['qrs_city'] = qrsCity;
    data['drivers_license'] = driversLicense;
    data['instructor'] = instructor;
    data['instructor_type'] = instructorType;
    data['coordinator'] = coordinator;
    data['van'] = van;
    data['student'] = student;
    data['student_type'] = studentType;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
