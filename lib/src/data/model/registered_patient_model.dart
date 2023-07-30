

class RegisteredPatientModel {
  int id;
  String patientID;
  String firstName;
  String lastName;
  DateTime dob;
  String imagePhoto;
  int countryID;
  String countryName;
  int provinceID;
  String provinceName;
  int districtID;
  String municipality;
  int municipalityID;
  String districtName;
  int ward;
  String localAddress;
  int genderID;
  String nid;
  String uhid;
  DateTime entryDate;
  dynamic flag;

  RegisteredPatientModel({
    required this.id,
    required this.patientID,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.imagePhoto,
    required this.countryID,
    required this.countryName,
    required this.provinceID,
    required this.provinceName,
    required this.districtID,
    required this.municipality,
    required this.municipalityID,
    required this.districtName,
    required this.ward,
    required this.localAddress,
    required this.genderID,
    required this.nid,
    required this.uhid,
    required this.entryDate,
    required this.flag,
  });

  factory RegisteredPatientModel.fromJson(Map<String, dynamic> json) {
    return RegisteredPatientModel(
      id: json['id'],
      patientID: json['patientID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: DateTime.parse(json['dob']),
      imagePhoto: json['imagePhoto'],
      countryID: json['countryID'],
      countryName: json['countryName'],
      provinceID: json['provinceID'],
      provinceName: json['provinceName'],
      districtID: json['districtID'],
      municipality: json['municipality'],
      municipalityID: json['municipalityID'],
      districtName: json['districtName'],
      ward: json['ward'],
      localAddress: json['localAddress'],
      genderID: json['genderID'],
      nid: json['nid'],
      uhid: json['uhid'],
      entryDate: DateTime.parse(json['entryDate']),
      flag: json['flag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientID': patientID,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob.toIso8601String(),
      'imagePhoto': imagePhoto,
      'countryID': countryID,
      'countryName': countryName,
      'provinceID': provinceID,
      'provinceName': provinceName,
      'districtID': districtID,
      'municipality': municipality,
      'municipalityID': municipalityID,
      'districtName': districtName,
      'ward': ward,
      'localAddress': localAddress,
      'genderID': genderID,
      'nid': nid,
      'uhid': uhid,
      'entryDate': entryDate.toIso8601String(),
      'flag': flag,
    };
  }
}
