// To parse this JSON data, do
//
//     final specialtiesModel = specialtiesModelFromJson(jsonString);

import 'dart:convert';

List<SpecialtiesModel> specialtiesModelFromJson(String str) =>
    List<SpecialtiesModel>.from(
      json.decode(str).map((x) => SpecialtiesModel.fromJson(x)),
    );

String specialtiesModelToJson(List<SpecialtiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecialtiesModel {
  String? title;
  String? image;

  SpecialtiesModel({this.title, this.image});

  factory SpecialtiesModel.fromJson(Map<String, dynamic> json) =>
      SpecialtiesModel(title: json["title"], image: json["image"]);

  Map<String, dynamic> toJson() => {"title": title, "image": image};
}
// ========
// To parse this JSON data, do
//
//     final doctorsBySpecialtyModels = doctorsBySpecialtyModelsFromJson(jsonString);

DoctorsBySpecialtyModels doctorsBySpecialtyModelsFromJson(String str) =>
    DoctorsBySpecialtyModels.fromJson(json.decode(str));

class DoctorsBySpecialtyModels {
  List<Cardiology>? cardiology;
  List<Cardiology>? dermatology;
  List<Cardiology>? generalMedicine;
  List<Cardiology>? gynecology;
  List<Cardiology>? odontology;
  List<Cardiology>? oncology;
  List<Cardiology>? ophtamology;
  List<Cardiology>? orthopedics;

  DoctorsBySpecialtyModels({
    this.cardiology,
    this.dermatology,
    this.generalMedicine,
    this.gynecology,
    this.odontology,
    this.oncology,
    this.ophtamology,
    this.orthopedics,
  });

  factory DoctorsBySpecialtyModels.fromJson(Map<String, dynamic> json) =>
      DoctorsBySpecialtyModels(
        cardiology: List<Cardiology>.from(
          json["Cardiology"].map((x) => Cardiology.fromJson(x)),
        ),
        dermatology: List<Cardiology>.from(
          json["Dermatology"].map((x) => Cardiology.fromJson(x)),
        ),
        generalMedicine: List<Cardiology>.from(
          json["General medicine"].map((x) => Cardiology.fromJson(x)),
        ),
        gynecology: List<Cardiology>.from(
          json["Gynecology"].map((x) => Cardiology.fromJson(x)),
        ),
        odontology: List<Cardiology>.from(
          json["Odontology"].map((x) => Cardiology.fromJson(x)),
        ),
        oncology: List<Cardiology>.from(
          json["Oncology"].map((x) => Cardiology.fromJson(x)),
        ),
        ophtamology: List<Cardiology>.from(
          json["Ophtamology"].map((x) => Cardiology.fromJson(x)),
        ),
        orthopedics: List<Cardiology>.from(
          json["Orthopedics"].map((x) => Cardiology.fromJson(x)),
        ),
      );
}

class Cardiology {
  String? name;
  String? specialty;
  String? image;

  Cardiology({this.name, this.specialty, this.image});

  factory Cardiology.fromJson(Map<String, dynamic> json) => Cardiology(
    name: json["name"],
    specialty: json["specialty"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "specialty": specialty,
    "image": image,
  };
}
