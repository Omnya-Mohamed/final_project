import "dart:convert";
import "dart:io";
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:g_project/models.dart';
import 'package:g_project/shared_pref.dart';

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
}
