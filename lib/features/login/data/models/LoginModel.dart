class LoginModel {
  String? sTypename;
  Login? login;

  LoginModel({this.sTypename, this.login});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    login = json['login'] != null ? new Login.fromJson(json['login']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.login != null) {
      data['login'] = this.login!.toJson();
    }
    return data;
  }
}

class Login {
  String? sTypename;
  String? token;
  String? userId;

  Login({this.sTypename, this.token, this.userId});

  Login.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['token'] = this.token;
    data['userId'] = this.userId;
    return data;
  }
}
