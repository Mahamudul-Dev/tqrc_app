class AnnouncementData {
  int? id;
  String? date;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  AnnouncementData(
      {this.id,
        this.date,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt});

  AnnouncementData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
