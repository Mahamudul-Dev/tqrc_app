class MyRegisterData {
  int? id;
  int? userId;
  int? planningId;
  String? timeStart;
  String? timeStop;
  String? remark;
  String? status;
  int? confirmed;
  int? coordinator;
  int? compensationAmount;
  int? transportThere;
  int? transportBack;
  String? qrsCity;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? date;
  String? name;
  String? description;
  String? openInstructor;
  String? openStudent;
  int? numberNeeded;
  String? category;
  String? language;
  String? courseCategory;
  String? material;
  String? room;
  String? numberStudent;
  String? level;
  String? year;
  String? transport;
  dynamic details;
  String? contactperson;
  String? adres;
  String? paymentCategory;
  String? compensation;
  int? reminder;
  int? prepared;
  String? link;
  int? school;
  dynamic zone;
  String? roles;
  dynamic tookPlace;
  dynamic url;
  dynamic privateKey;
  dynamic paymentType;
  dynamic coursePrice;

  MyRegisterData({
    this.id,
    this.userId,
    this.planningId,
    this.timeStart,
    this.timeStop,
    this.remark,
    this.status,
    this.confirmed,
    this.coordinator,
    this.compensationAmount,
    this.transportThere,
    this.transportBack,
    this.qrsCity,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.date,
    this.name,
    this.description,
    this.openInstructor,
    this.openStudent,
    this.numberNeeded,
    this.category,
    this.language,
    this.courseCategory,
    this.material,
    this.room,
    this.numberStudent,
    this.level,
    this.year,
    this.transport,
    this.details,
    this.contactperson,
    this.adres,
    this.paymentCategory,
    this.compensation,
    this.reminder,
    this.prepared,
    this.link,
    this.school,
    this.zone,
    this.roles,
    this.tookPlace,
    this.url,
    this.privateKey,
    this.paymentType,
    this.coursePrice,
  });

  MyRegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planningId = json['planning_id'];
    timeStart = json['time_start'];
    timeStop = json['time_stop'];
    remark = json['remark'];
    status = json['status'];
    confirmed = json['confirmed'];
    coordinator = json['coordinator'];
    compensationAmount = json['compensation_amount'];
    transportThere = json['transport_there'];
    transportBack = json['transport_back'];
    qrsCity = json['qrs_city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    date = json['date'];
    name = json['name'];
    description = json['description'];
    openInstructor = json['open_instructor'];
    openStudent = json['open_student'];
    numberNeeded = json['number_needed'];
    category = json['category'];
    language = json['language'];
    courseCategory = json['course_category'];
    material = json['material'];
    room = json['room'];
    numberStudent = json['number_student'];
    level = json['level'];
    year = json['year'];
    transport = json['transport'];
    details = json['details'];
    contactperson = json['contactperson'];
    adres = json['adres'];
    paymentCategory = json['payment_category'];
    compensation = json['compensation'];
    reminder = json['reminder'];
    prepared = json['prepared'];
    link = json['link'];
    school = json['school'];
    zone = json['zone'];
    roles = json['roles'];
    tookPlace = json['took_place'];
    url = json['url'];
    privateKey = json['private_key'];
    paymentType = json['payment_type'];
    coursePrice = json['course_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['planning_id'] = planningId;
    data['time_start'] = timeStart;
    data['time_stop'] = timeStop;
    data['remark'] = remark;
    data['status'] = status;
    data['confirmed'] = confirmed;
    data['coordinator'] = coordinator;
    data['compensation_amount'] = compensationAmount;
    data['transport_there'] = transportThere;
    data['transport_back'] = transportBack;
    data['qrs_city'] = qrsCity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    data['date'] = date;
    data['name'] = name;
    data['description'] = description;
    data['open_instructor'] = openInstructor;
    data['open_student'] = openStudent;
    data['number_needed'] = numberNeeded;
    data['category'] = category;
    data['language'] = language;
    data['course_category'] = courseCategory;
    data['material'] = material;
    data['room'] = room;
    data['number_student'] = numberStudent;
    data['level'] = level;
    data['year'] = year;
    data['transport'] = transport;
    data['details'] = details;
    data['contactperson'] = contactperson;
    data['adres'] = adres;
    data['payment_category'] = paymentCategory;
    data['compensation'] = compensation;
    data['reminder'] = reminder;
    data['prepared'] = prepared;
    data['link'] = link;
    data['school'] = school;
    data['zone'] = zone;
    data['roles'] = roles;
    data['took_place'] = tookPlace;
    data['url'] = url;
    data['private_key'] = privateKey;
    data['payment_type'] = paymentType;
    data['course_price'] = coursePrice;
    return data;
  }
}
