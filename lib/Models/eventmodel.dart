class EventModel {
  String? message;
  List<Data>? data;
  bool? status;

  EventModel({this.message, this.data, this.status});

  EventModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  List<File>? file;
  User? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? description;
  String? date;

  Data(
      {this.sId,
      this.title,
      this.file,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.description,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    if (json['file'] != null) {
      file = <File>[];
      json['file'].forEach((v) {
        file!.add(File.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (file != null) {
      data['file'] = file!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}

class File {
  String? sId;
  String? file;

  File({this.sId, this.file});

  File.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['file'] = file;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  File? image;

  User({this.sId, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'] != null ? File.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}
