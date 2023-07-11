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
