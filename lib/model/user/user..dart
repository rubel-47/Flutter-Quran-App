class User {
  int? status;
  String? message;
  List<UserData>? userData;

  User({this.status, this.message, this.userData});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user_data'] != null) {
      userData = <UserData>[];
      json['user_data'].forEach((v) {
        userData!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userData != null) {
      data['user_data'] = this.userData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? password;

  UserData(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.address,
      this.password});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['password'] = this.password;
    return data;
  }
}
