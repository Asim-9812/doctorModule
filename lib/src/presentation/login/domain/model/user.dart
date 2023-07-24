class User {
  int? id;
  String? userID;
  int? typeID;
  String? referredID;
  String? parentID;
  String? firstName;
  String? lastName;
  String? password;
  int? countryID;
  int? provinceID;
  int? districtID;
  int? municipalityID;
  int? wardNo;
  String? localAddress;
  String? contactNo;
  String? email;
  int? roleID;
  String? designation;
  String? joinedDate;
  String? validDate;
  String? signatureImage;
  String? profileImage;
  bool? isActive;
  int? genderID;
  String? entryDate;
  int? prefixSettingID;
  String? token;
  int? panNo;
  int? natureID;
  int? liscenceNo;
  String? flag;

  User({
    this.id,
    this.userID,
    this.typeID,
    this.referredID,
    this.parentID,
    this.firstName,
    this.lastName,
    this.password,
    this.countryID,
    this.provinceID,
    this.districtID,
    this.municipalityID,
    this.wardNo,
    this.localAddress,
    this.contactNo,
    this.email,
    this.roleID,
    this.designation,
    this.joinedDate,
    this.validDate,
    this.signatureImage,
    this.profileImage,
    this.isActive,
    this.genderID,
    this.entryDate,
    this.prefixSettingID,
    this.token,
    this.panNo,
    this.natureID,
    this.liscenceNo,
    this.flag,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      userID: json['userID'] as String?,
      typeID: json['typeID'] as int?,
      referredID: json['referredID'] as String?,
      parentID: json['parentID'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      countryID: json['countryID'] as int?,
      provinceID: json['provinceID'] as int?,
      districtID: json['districtID'] as int?,
      municipalityID: json['municipalityID'] as int?,
      wardNo: json['wardNo'] as int?,
      localAddress: json['localAddress'] as String?,
      contactNo: json['contactNo'] as String?,
      email: json['email'] as String?,
      roleID: json['roleID'] as int?,
      designation: json['designation'] as String?,
      joinedDate: json['joinedDate'] as String?,
      validDate: json['validDate'] as String?,
      signatureImage: json['signatureImage'] as String?,
      profileImage: json['profileImage'] as String?,
      isActive: json['isActive'] as bool?,
      genderID: json['genderID'] as int?,
      entryDate: json['entryDate'] as String?,
      prefixSettingID: json['prefixSettingID'] as int?,
      token: json['token'] as String?,
      panNo: json['panNo'] as int?,
      natureID: json['natureID'] as int?,
      liscenceNo: json['liscenceNo'] as int?,
      flag: json['flag'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'typeID': typeID,
      'referredID': referredID,
      'parentID': parentID,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'countryID': countryID,
      'provinceID': provinceID,
      'districtID': districtID,
      'municipalityID': municipalityID,
      'wardNo': wardNo,
      'localAddress': localAddress,
      'contactNo': contactNo,
      'email': email,
      'roleID': roleID,
      'designation': designation,
      'joinedDate': joinedDate,
      'validDate': validDate,
      'signatureImage': signatureImage,
      'profileImage': profileImage,
      'isActive': isActive,
      'genderID': genderID,
      'entryDate': entryDate,
      'prefixSettingID': prefixSettingID,
      'token': token,
      'panNo': panNo,
      'natureID': natureID,
      'liscenceNo': liscenceNo,
      'flag': flag,
    };
  }

  // Factory method for empty state
  factory User.empty() {
    return User(
      id: null,
      userID: null,
      typeID: null,
      referredID: null,
      parentID: null,
      firstName: null,
      lastName: null,
      password: null,
      countryID: null,
      provinceID: null,
      districtID: null,
      municipalityID: null,
      wardNo: null,
      localAddress: null,
      contactNo: null,
      email: null,
      roleID: null,
      designation: null,
      joinedDate: null,
      validDate: null,
      signatureImage: null,
      profileImage: null,
      isActive: null,
      genderID: null,
      entryDate: null,
      prefixSettingID: null,
      token: null,
      panNo: null,
      natureID: null,
      liscenceNo: null,
      flag: null,
    );
  }
}
