class ActivitiesData {
  int? id;
  String? name;
  String? date;
  String? timeStart;
  String? timeStop;
  int? activityDataCount;
  List<ActivityData>? activityData;

  ActivitiesData({
    this.id,
    this.name,
    this.date,
    this.timeStart,
    this.timeStop,
    this.activityDataCount,
    this.activityData,
  });

  ActivitiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    timeStart = json['time_start'] ?? '';
    timeStop = json['time_stop'] ?? '';
    activityDataCount = json['activity_data_count'];
    if (json['activity_data'] != null) {
      activityData = <ActivityData>[];
      json['activity_data'].forEach((v) {
        activityData!.add(ActivityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['date'] = date;
    data['time_start'] = timeStart;
    data['time_stop'] = timeStop;
    data['activity_data_count'] = activityDataCount;
    if (activityData != null) {
      data['activity_data'] = activityData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityData {
  int? id;
  int? userId;
  int? planningId;
  String? timeStart;
  String? timeStop;
  dynamic remark;
  String? status;
  int? confirmed;
  int? coordinator;
  int? compensationAmount;
  int? transportThere;
  int? transportBack;
  String? qrsCity;
  String? createdAt;
  String? updatedAt;

  ActivityData({
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
  });

  ActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planningId = json['planning_id'];
    timeStart = json['time_start'] ?? '';
    timeStop = json['time_stop'] ?? '';
    remark = json['remark'] ?? '';
    status = json['status'];
    confirmed = json['confirmed'];
    coordinator = json['coordinator'];
    compensationAmount = json['compensation_amount'];
    transportThere = json['transport_there'];
    transportBack = json['transport_back'];
    qrsCity = json['qrs_city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
