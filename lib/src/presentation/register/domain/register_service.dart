




import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api.dart';

class RegisterService {

  final dio = Dio();

  Map<String,dynamic> outputValue = {};

  Future<Either<String, dynamic>> orgRegister({

    required String orgName,
    required int pan,
    required String email,
    required String mobileNo,
    required int natureId,
    required String password
  }) async {
    try {
      final response = await dio.post(
          Api.registerOrganization,
          data: {
            "organizationName": orgName,
            "pan": pan,
            "email": email,
            "contact": mobileNo,
            "natureId":natureId,
            "password":password
          }
      );



      return Right(response.data);
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Dio error: ${err.message}');
    }}

  Future<Either<String, dynamic>> docRegister({

    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String mobileNo,
    required int subscriptionId,
    required int genderId
  }) async {
    try {
      final response = await dio.post(
          Api.registerDoctor,
          data: {
            "doctorID": 0,
            "docID": "",
            "firstName": firstName,
            "lastName": lastName,
            "doctorEmail": email,
            "doctorPassword": password,
            "roleID": 1,
            "referenceNo": "1",
            "subscriptionID": subscriptionId,
            "isActive": true,
            "entryDate": "2023-07-17T10:43:10.315Z",
            "genderID": 1,
            "key": "12",
            "flag": "Insert"
          }
      );



      return Right(response.data);
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Dio error: ${err.message}');
    }}



  Future<Either<String, dynamic>> patientRegister({

    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String mobileNo,
    required String userName,
    required int genderId
  }) async {
    try {
      final response = await dio.post(
          Api.registerPatient,
          data: {
            "userName": userName,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "gender": genderId,
            "email": email,
            "contact": mobileNo
          }
      );

      print(response.data['result']['id']);
      
      if(response.data['result']['id']==0){
        return left('Username already exist');
      }
      else{
        return Right(response.data);
      }




    } on DioException catch (err) {
      print(err.response);
      return Left('Something went wrong');
    }}




}