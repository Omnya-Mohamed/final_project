import 'dart:io';

class RegisterModel {
  dynamic email;
  dynamic username;
  int? id;

  RegisterModel({this.email, this.username, this.id});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    id = json['id'];
  }
}

class loginAuthModel {
  String? authToken;

  loginAuthModel({this.authToken});

  loginAuthModel.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
  }
}

class PatientModel {
  int? id;
  String? nationalId;
  String? name;
  int? age;
  String? address;
  String? phoneNumber;
  String? birthdate;
  String? gender;
  String? profilePhoto;
  int? user;

  PatientModel({
    this.user,
    required this.address,
    required this.age,
    required this.birthdate,
    required this.gender,
    required this.id,
    required this.name,
    required this.nationalId,
    required this.phoneNumber,
    required this.profilePhoto,
  });
  PatientModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    user = json['user'];
    age = json['age'];
    birthdate = json['birth_date'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    nationalId = json['national_id'];
    phoneNumber = json['phone_number'];
    profilePhoto = json['profile_photo'];
  }
}

class ClassificationModel {
  String? medicalPhoto;
  String? result;
  String? processType;
  ClassificationModel({
    required this.medicalPhoto,
    required this.result,
    required this.processType,
  });

  ClassificationModel.fromJson(Map<String, dynamic> json) {
    medicalPhoto = json['medicalphoto'];
    result = json['result'];
    processType = json['process_type'];
  }
}

class SearchInPatientModel {
  List<PatientModel>? patientModel;
  List<ClassificationModel>? classification;

  SearchInPatientModel({
    required this.classification,
    required this.patientModel,
  });
  SearchInPatientModel.fromJson(Map<String, dynamic> json) {
    patientModel = List<PatientModel>.from((json['patient'] as List)
        .map((e) => PatientModel.fromJson(e))
        .toList());
    classification = List<ClassificationModel>.from(
        (json['classifications'] as List)
            .map((e) => ClassificationModel.fromJson(e))
            .toList());
  }
}
