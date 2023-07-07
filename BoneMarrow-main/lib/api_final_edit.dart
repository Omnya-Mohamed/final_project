import "dart:convert";
import "dart:developer";

import "package:g_project/models.dart";
import "package:g_project/shared_pref.dart";
import "package:http/http.dart" as http;

class ApiHelperFinalEdit {
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
    log(userData.toString(), name: "user data");

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

  static Future searchInPatient({
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

  static Future editPatient({
    required int id,
    required String address,
    required String phoneNumber,
    required String gender,
    required String? profilePhoto,
    required int age,
    required String birthDate,
    required String name,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      'Authorization': '${CashHelper.getData(key: 'token')}',
    };

    var request = http.Request(
        'PUT',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/4/edit/"));
    request.body = json.encode({
      "id": id,
      "address": address.toString(),
      "phone_number": phoneNumber.toString(),
      "gender": gender.toLowerCase(),
      "age": age,
      "name": name.toString(),
      "birth_date": birthDate.toString(),
      "profile_photo": profilePhoto == null
          ? null
          : await http.MultipartFile.fromPath('', profilePhoto),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 200) {
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
      'Authorization': '${CashHelper.getData(key: 'token')}',
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/patients/$id/delete/"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 200) {
      print('deleted successfully');
      //return PatientModel.fromJson(userData);
    } else {
      print("error error server");
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

  static Future addPatient({
    required String nid,
    required String address,
    required String phoneNumber,
    required String gender,
    required String? profilePhoto,
    required int age,
    required String birthDate,
    required String name,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      'Authorization': '${CashHelper.getData(key: 'token')}',
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            "http://ec2-16-16-128-143.eu-north-1.compute.amazonaws.com/api/v1/patients/"));
    request.body = json.encode({
      "national_id": nid.toString(),
      "address": address.toString(),
      "phone_number": phoneNumber.toString(),
      "gender": gender.toLowerCase(),
      "age": age,
      "name": name.toString(),
      "birth_date": birthDate.toString(),
      "profile_photo": profilePhoto == null
          ? null
          : await http.MultipartFile.fromPath('', profilePhoto),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final stringData = await response.stream.bytesToString();
    dynamic userData = json.decode(stringData);
    print(userData);
    if (response.statusCode == 201) {
      // CashHelper.saveData(key: 'nid', value: userData['national_id']);
      // CashHelper.saveData(key: 'name', value: userData['name']);
      //  CashHelper.saveData(key: 'age', value: userData['age']);
      // CashHelper.saveData(key: 'address', value: userData['address']);
      //  CashHelper.saveData(key: 'phoneNumber', value: userData['phone_number']);
      // CashHelper.saveData(key: 'birthDate', value: userData['birth_date']);
      //  CashHelper.saveData(key: 'gender', value: userData['gender']);
      // CashHelper.saveData(key: 'profilePhoto', value: userData['profile_photo']);

      print("hello");
      return PatientModel.fromJson(userData);
    } else {
      print("error error server");
      return PatientModel.fromJson(userData);
    }
  }
}
