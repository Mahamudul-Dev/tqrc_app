class ActivitiesDetailsData {
  int? id;
  String? type;
  String? date;
  String? timeStart;
  String? timeStop;
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
  dynamic level;
  dynamic year;
  String? transport;
  String? details;
  String? contactperson;
  String? adres;
  String? paymentCategory;
  String? compensation;
  int? compensationAmount;
  int? reminder;
  int? prepared;
  String? qrsCity;
  String? link;
  dynamic school;
  dynamic zone;
  int? transportThere;
  int? transportBack;
  String? roles;
  dynamic tookPlace;
  String? url;
  dynamic privateKey;
  dynamic paymentType;
  int? coursePrice;
  String? createdAt;
  String? updatedAt;

  ActivitiesDetailsData(
      {this.id,
        this.type,
        this.date,
        this.timeStart,
        this.timeStop,
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
        this.compensationAmount,
        this.reminder,
        this.prepared,
        this.qrsCity,
        this.link,
        this.school,
        this.zone,
        this.transportThere,
        this.transportBack,
        this.roles,
        this.tookPlace,
        this.url,
        this.privateKey,
        this.paymentType,
        this.coursePrice,
        this.createdAt,
        this.updatedAt});

  ActivitiesDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    date = json['date'];
    timeStart = json['time_start'];
    timeStop = json['time_stop'];
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
    compensationAmount = json['compensation_amount'];
    reminder = json['reminder'];
    prepared = json['prepared'];
    qrsCity = json['qrs_city'];
    link = json['link'];
    school = json['school'];
    zone = json['zone'];
    transportThere = json['transport_there'];
    transportBack = json['transport_back'];
    roles = json['roles'];
    tookPlace = json['took_place'];
    url = json['url'];
    privateKey = json['private_key'];
    paymentType = json['payment_type'];
    coursePrice = json['course_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['date'] = date;
    data['time_start'] = timeStart;
    data['time_stop'] = timeStop;
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
    data['compensation_amount'] = compensationAmount;
    data['reminder'] = reminder;
    data['prepared'] = prepared;
    data['qrs_city'] = qrsCity;
    data['link'] = link;
    data['school'] = school;
    data['zone'] = zone;
    data['transport_there'] = transportThere;
    data['transport_back'] = transportBack;
    data['roles'] = roles;
    data['took_place'] = tookPlace;
    data['url'] = url;
    data['private_key'] = privateKey;
    data['payment_type'] = paymentType;
    data['course_price'] = coursePrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
