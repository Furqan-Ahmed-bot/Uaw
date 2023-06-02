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
  String? location;
  String? phone;
  String? userType;
  bool? isDeleted;
  String? status;
  bool? notificationOn;
  List<Null>? myEvents;
  String? email;
  String? name;
  Designation? designation;
  Image? image;
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
      this.myEvents,
      this.email,
      this.name,
      this.designation,
      this.image,
      this.password,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] ;
    phone = json['phone'];
    userType = json['userType'];
    isDeleted = json['isDeleted'];
    status = json['status'];
    notificationOn = json['notificationOn'];
    if (json['myEvents'] != null) {
      myEvents = <Null>[];
      json['myEvents'].forEach((v) {
        // myEvents!.add(new Null.fromJson(v));
      });
    }
    email = json['email'];
    name = json['name'];
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['userType'] = this.userType;
    data['isDeleted'] = this.isDeleted;
    data['status'] = this.status;
    data['notificationOn'] = this.notificationOn;
    if (this.myEvents != null) {
      // data['myEvents'] = this.myEvents!.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}

// class Location {
//   String? type;
//   List<double>? coordinates;

//   Location({this.type, this.coordinates});

//   Location.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     coordinates = json['coordinates'].cast<double>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['coordinates'] = this.coordinates;
//     return data;
//   }
// }

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

class Image {
  String? sId;
  String? file;

  Image({this.sId, this.file});

  Image.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['file'] = this.file;
    return data;
  }
}
