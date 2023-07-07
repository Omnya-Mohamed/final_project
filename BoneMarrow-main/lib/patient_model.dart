class PatientModel {
  int id;
  String nationalId;
  String name;
  int age;
  String address;
  String phoneNumber;
  String birthdate;
  String gender;
  String profilePhoto;

  PatientModel({
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
  
}
