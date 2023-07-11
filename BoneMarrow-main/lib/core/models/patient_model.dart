

import 'dart:convert';

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
    this.id,
    this.nationalId,
    this.name,
    this.age,
    this.address,
    this.phoneNumber,
    this.birthdate,
    this.gender,
    this.profilePhoto,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nationalId': nationalId,
      'name': name,
      'age': age,
      'address': address,
      'phoneNumber': phoneNumber,
      'birthdate': birthdate,
      'gender': gender,
      'profilePhoto': profilePhoto,
      'user': user,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] != null ? map['id'] as int : null,
      nationalId:
          map['nationalId'] != null ? map['nationalId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      address: map['address'] != null ? map['address'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
      user: map['user'] != null ? map['user'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
