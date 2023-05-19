class userModel {
  String? message;
  Data? data;
  bool? status;

  userModel({this.message, this.data, this.status});

  userModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? sId;
  Location? location;
  String? phone;
  String? userType;
  bool? isDeleted;
  String? status;
  bool? notificationOn;
  String? email;
  String? name;
  Designation? designation;
  String? password;
  String? token;

  Data(
      {this.sId,
      this.location,
      this.phone,
      this.userType,
      this.isDeleted,
      this.status,
      this.notificationOn,
      this.email,
      this.name,
      this.designation,
      this.password,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    phone = json['phone'];
    userType = json['userType'];
    isDeleted = json['isDeleted'];
    status = json['status'];
    notificationOn = json['notificationOn'];
    email = json['email'];
    name = json['name'];
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['phone'] = this.phone;
    data['userType'] = this.userType;
    data['isDeleted'] = this.isDeleted;
    data['status'] = this.status;
    data['notificationOn'] = this.notificationOn;
    data['email'] = this.email;
    data['name'] = this.name;
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Designation {
  String? sId;
  String? title;

  Designation({this.sId, this.title});

  Designation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}
