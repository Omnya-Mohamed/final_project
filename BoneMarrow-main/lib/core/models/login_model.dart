
class loginAuthModel {
  String? authToken;

  loginAuthModel({this.authToken});

  loginAuthModel.fromJson(Map<String, dynamic> json) {
    authToken = json['access'];
  }
}