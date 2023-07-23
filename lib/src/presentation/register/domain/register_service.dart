




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



}