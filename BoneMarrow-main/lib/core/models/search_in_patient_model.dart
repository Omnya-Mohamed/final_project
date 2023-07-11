import 'package:g_project/core/models/patient_model.dart';
import 'classification_model.dart';

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
