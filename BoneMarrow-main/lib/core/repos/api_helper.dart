import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:g_project/core/repos/shared_pref.dart';

import '../models/login_model.dart';
import '../models/patient_model.dart';
import '../models/register_model.dart';

class ApiHelper {
  static Future<RegisterModel> registerAuth(
      {required String userName,
      required String email,
      required String password,
      required String rePassword}) async {
    var headers = {
      "Content-Type": "application/json",
    };

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
      CacheHelper.saveData(key: 'email', value: userData['email']);
      CacheHelper.saveData(key: 'userName', value: userData['username']);
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
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/auth/jwt/create/"));
    request.body = json.encode({
      "username": userName.toString().trim(),
      "password": password.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    if (response.statusCode == 200) {
      print(userData['access']);
      CacheHelper.saveData(
          key: 'access_token', value: userData['access'] as String);
      CacheHelper.saveData(key: 'password', value: password);
      print("access token and password stored successfully");
      return loginAuthModel.fromJson(userData);
    } else {
      print("error error server");
      return loginAuthModel.fromJson(userData);
    }
  }

  static Future changePassword(
      {required String newPassword,
      required String confirmNewPassword,
      required String oldPassword}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "authorization": CacheHelper.getData(key: 'access_token'),
      "Authorization": "Bearer ${CacheHelper.getData(key: 'access_token')}",
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/auth/users/set_password/"));
    request.body = json.encode({
      "new_password": newPassword.toString(),
      "re_new_password": confirmNewPassword.toString(),
      "current_password": oldPassword.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    if (response.statusCode == 204 ||
        response.statusCode == 200 ||
        response.statusCode == 201) {
      print("Changed successfully");
    } else {
      print(CacheHelper.getData(key: 'password'));
      print(CacheHelper.getData(key: 'access_token'));
      print(response.statusCode);
      print("error error server");
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
  static uploadFilePrediction(
      {required File file, required String nationalId}) async {
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

  // static Future uploadFileClassification(
  //     {required File file, required String nationalId}) async {
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/classification/'));
  //   var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
  //   var length = await file.length();
  //   var multipartFile = http.MultipartFile('medicalphoto', stream, length,
  //       filename: basename(file.path));
  //   request.fields.addAll({"national_id": nationalId});
  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   if (response.statusCode == 201 || response.statusCode == 200) {
  //     print('File uploaded successfully');
  //   } else {
  //     print('Error ${response.statusCode}');
  //   }
  // }
  static Future<Map<String, dynamic>> searchInClassificationAndPrediction({
    required String nationalId,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
      'POST',
      Uri.parse(
          "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/searchp/"),
    );

    request.body = json.encode({
      "query": nationalId.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    Map<String, dynamic> userData = json.decode(stringData);
    // log(userData.toString(), name: "user data");

    if (response.statusCode == 200) {
      if ((userData['Patient']).isNotEmpty) {
        return userData['Patient'][0] as Map<String, dynamic>;
      } else {
        print('This ID is not found');
      }
    } else {
      print("Error: server error");
    }

    return {}; // Return an empty map if the ID is not found or an error occurred
  }

  static Future<List> searchInPatientRecords({
    required String nationalId,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/searchpd/"));
    request.body = json.encode({
      "query": nationalId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    // print(userData);
    if (response.statusCode == 200) {
      return [userData[0]['classifications'], userData[0]['predictions']];
    } else {
      print("error error server");
      return [];
      // return PatientModel.fromJson(userData['Patient'[0]]);
    }
  }

  static Future searchInPatientPredictions({
    required String nationalId,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/searchpd/"));
    request.body = json.encode({
      "query": nationalId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    // print(userData);
    if (response.statusCode == 200) {
      return userData[0]['predictions'];
    } else {
      print("error error server");
      return PatientModel.fromJson(userData['Patient'[0]]);
    }
  }

  static Future searchInPatientClassifications({
    required String nationalId,
  }) async {
    var headers = {"Content-Type": "application/json"};

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/searchpd/"));
    request.body = json.encode({
      "query": nationalId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    // print(userData);
    if (response.statusCode == 200) {
      return userData[0]['classifications'];
    } else {
      print("error error server");
      return PatientModel.fromJson(userData['Patient'[0]]);
    }
  }

  static Future editPatient({
    required int id,
    required String address,
    required String phoneNumber,
    required String gender,
    required File? profilePhoto,
    required int age,
    required String nationalId,
    required String name,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      'Authorization': '${CacheHelper.getData(key: 'token')}',
    };

    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/$id/edit/"));
    var length = await profilePhoto!.length();
    var stream = http.ByteStream(profilePhoto.openRead());
    var multiPartFile = http.MultipartFile('profile_photo', stream, length,
        filename: basename(profilePhoto.path));
    request.files.add(multiPartFile);
    request.fields.addAll({
      "id": id.toString(),
      "address": address,
      "phone_number": phoneNumber,
      "gender": gender.toLowerCase(),
      "age": age.toString(),
      "name": name,
      "national_id": nationalId,
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 200) {
      print("updated");
      return PatientModel.fromJson(userData);
    } else {
      print("error error server");
      return PatientModel.fromJson(userData);
    }
  }

  static Future deletePatient({
    required int id,
  }) async {
    var headers = {
      "Content-Type": "application/json",
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/$id/delete/"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // final stringData = await response.stream.bytesToString();
    // dynamic userData = json.decode(stringData);
    // print(userData);
    if (response.statusCode == 204 ||
        response.statusCode == 200 ||
        response.statusCode == 201) {
      print('deleted successfully');
      //return PatientModel.fromJson(userData);
    } else if (response.statusCode == 500) {
      print("error error server");
    } else {
      print(response.statusCode);
    }
  }

  static Future getPatientsLists() async {
    var headers = {
      "Content-Type": "application/json",
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 200) {
      return List<PatientModel>.from(
          (userData as List).map((e) => PatientModel.fromJson(e)).toList());
    } else {
      print("error error server patient  list");
    }
  }

  static Future getPatientsCount() async {
    var headers = {
      "Content-Type": "application/json",
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/count/"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    if (response.statusCode == 200) {
      print('count: ${userData['patient_count']}');
      return userData['patient_count'];
    } else {
      print("error error server patient  list");
    }
  }

  static Future addPatient({
    required String nid,
    required String address,
    required String phoneNumber,
    required String gender,
    required File? profilePhoto,
    required String age,
    required String birthDate,
    required String name,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      // 'Authorization': '${CashHelper.getData(key: 'token')}',
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/"));
    var length = await profilePhoto!.length();
    var stream = http.ByteStream(profilePhoto.openRead());
    var multiPartFile = http.MultipartFile('profile_photo', stream, length,
        filename: basename(profilePhoto.path));
    request.files.add(multiPartFile);
    request.fields.addAll({
      "national_id": nid.toString(),
      "address": address.toString(),
      "phone_number": phoneNumber.toString(),
      "gender": gender.toLowerCase(),
      "age": age,
      "name": name.toString(),
      "birth_date": birthDate.toString(),
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 201) {
      print("hello");
      return PatientModel.fromJson(userData);
    } else {
      print("error error server");
      print(response.statusCode.toString());
      return PatientModel.fromJson(userData);
    }
  }

  static Future<String?> uploadFileClassification({
    required File file,
    required String nationalId,
  }) async {
    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse(
        'http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/classification/');
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile(
      'medicalphoto',
      stream,
      length,
      filename: basename(file.path),
    );

    request.files.add(multipartFile);
    request.fields.addAll({
      "national_id": nationalId.toString(),
      "medicalphoto": multipartFile.toString(),
    });

    var response = await request.send();
    print(response.statusCode);

    String? result;

    await response.stream.transform(utf8.decoder).forEach((value) {
      Map<String, dynamic> responseBody = jsonDecode(value);
      result = responseBody['result'];
      print(result);
    });
    switch (result) {
      case "EBO":
        result = "EBO: Erythroblast";
        break;
      case "PLM":
        result = "PLM: Plasma Cell";
        break;
      case "NGB":
        result = "NGB: Neutrophil";
        break;
      case "EOS":
        result = "EOS: Eosinophil";
        break;
      case "LYT":
        result = "LYT: Lymphocyte";
        break;
      case "MON":
        result = "MON: Monocyte";
        break;
      default:
    }
    print("result: $result");
    return result;
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
