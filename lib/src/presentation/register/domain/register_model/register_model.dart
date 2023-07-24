


class RegisterDoctorModel {
  final String firstName;
  final String lastName;
  final String email;
  final String contactNo;
  final int licenseNo;
  final String password;
  final int genderId;

  RegisterDoctorModel({
    required this.licenseNo,
    required this.genderId,
    required this.contactNo,
    required this.password,
    required this.email,
    required this.lastName,
    required this.firstName
});

}