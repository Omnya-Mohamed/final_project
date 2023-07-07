import 'dart:convert';
import 'dart:io';

import 'package:g_project/models.dart';
import 'package:g_project/shared_pref.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart';

class ApiHelper {
  static Future<RegisterModel> registerAuth(
      {required String userName,
      required String email,
      required String password,
      required String rePassword}) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/auth/users/"));
    request.body = json.encode({
      "username": userName.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "re_password": rePassword.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 201) {
      CashHelper.saveData(key: 'email', value: userData['email']);
      CashHelper.saveData(key: 'userName', value: userData['username']);
      return RegisterModel.fromJson(userData);
    } else {
      print("error error server");
      return RegisterModel.fromJson(userData);
    }
  }

  static Future<loginAuthModel> loginAuth(
      {required String userName, required String password}) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/auth/token/login/"));
    request.body = json.encode({
      "username": userName.toString().trim(),
      "password": password.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 200) {
      print(userData);
      CashHelper.saveData(
          key: 'token', value: userData['auth_token'] as String);
      return loginAuthModel.fromJson(userData);
    } else {
      print("error error server");
      return loginAuthModel.fromJson(userData);
    }
  }

  static Future reset({
    required String email,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/auth/users/reset_password/"));
    request.body = json.encode({
      "email": email.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 204) {
      print('check your gmail');
      //return RegisterModel.fromJson(userData);
    } else {
      print("error try again");
      //return RegisterModel.fromJson(userData);
    }
  }

  // static Future changePassword(
  //     {required String newPassword,
  //     required String renewPassword,
  //     required String currentPassword}) async {
  //   var headers = {"Content-Type": "application/json"};

  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/auth/users/reset_password/"));
  //   request.body = json.encode({
  //     "current_password": currentPassword.toString(),
  //     "re_new_password": renewPassword.toString(),
  //     "new_password": newPassword.toString(),
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   final stringData = await response.stream.bytesToString();
  //   dynamic userData = json.decode(stringData);
  //   print(userData);
  //   if (response.statusCode == 204) {
  //     print('successful');
  //     //return RegisterModel.fromJson(userData);
  //   } else {
  //     print("error try again");
  //     //return RegisterModel.fromJson(userData);
  //   }
  // }
  static uploadFile({required File file, required String nationalId}) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/prediction/'));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile('medicalfile', stream, length,
        filename: basename(file.path));
    request.files.add(multiPartFile);
    request.fields.addAll({
      "national_id": nationalId.toString(),
      // "medicalfile": multiPartFile.toString(),
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    String finalResult;
    if (myRequest.statusCode == 201 || myRequest.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['result'] == "1") {
        finalResult = "${responseBody['result']}: Dead";
      } else {
        finalResult = "${responseBody['result']}: Alive";
      }
      return finalResult;
    } else {
      print('Error ${myRequest.statusCode}');
    }
  }

  static Future prediction({
    required String nationalId,
    required String file,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/prediction/"));
    List<int> fileBytes = await File(file).readAsBytes();
    request.body = json.encode({
      "national_id": nationalId.toString(),
      "medicalfile": base64Encode(fileBytes),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 201) {
      print('check your gmail');
    } else {
      print("error try again");
    }
  }

  static Future classification({
    required String nationalId,
    required String file,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/classification/"));
    request.body = json.encode({
      "national_id": nationalId.toString(),
      'medicalphoto': await http.MultipartFile.fromPath('', file),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 200) {
      //print('check your gmail');
      return userData['result'];
      //return RegisterModel.fromJson(userData);
    } else {
      print("error try again");
      //return RegisterModel.fromJson(userData);
    }
  }
}
