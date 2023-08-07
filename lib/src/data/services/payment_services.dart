


import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verificationProvider = StateProvider((ref) => KhaltiPaymentServices());

class KhaltiPaymentServices{
  final dio = Dio();
  final String key = 'test_secret_key_6d0b852d9e0c43838af2adbb72878c21';


  Future<Either<String,dynamic>> VerificationProcess({
    required String token,
    required int amount,
}) async{
    try{
      final response = await dio.post('https://khalti.com/api/v2/payment/verify/',
          options: Options( headers:  {HttpHeaders.authorizationHeader: 'Key $key'}),
        data: {
        'amount':amount,
          'token':token
        }
      );
      if(response.statusCode == 200){
        print(response.data);
        return Right(response.data);
      }else{
        print(response.data);
        return Left('Something went wrong');
      }
    } on DioException catch(e){
      print('$e');
      return Left('error');
    }
  }


}