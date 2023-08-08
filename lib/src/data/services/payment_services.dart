


import 'dart:io';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api.dart';

final verificationProvider = StateProvider((ref) => KhaltiPaymentServices());
final paymentSuccessProvider = StateProvider((ref) => PaymentSuccessfulService());



class PaymentSuccessfulService{
  final dio =Dio();

  Future<Either<String,dynamic>> InsertPaymentInfo({
    required String token,
    required int amount,
    required String mobile,
    required String pid,
    required String orderName,
    required String tId,
  }) async{
    try{
      final response = await dio.post('${Api.paymentSuccessUrl}',
          data: {
            "pidx": token,
            "txnId": tId,
            "amount": amount,
            "mobile": mobile,
            "purchase_order_id": pid,
            "purchase_order_name": orderName,
            "transaction_id": tId
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


// CLIENT_ID = JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R
// SECRET_KEY = BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==

const String kEsewaClientId = 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
const String kEsewaSecretKey = 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';


class Esewa{
  final dio = Dio();
  pay(){
    try{
      EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
            environment: Environment.test,
            clientId: kEsewaClientId,
            secretId: kEsewaSecretKey,
          ),
          esewaPayment: EsewaPayment(
            productId: "ORG3080",
            productName: "GOLD",
            productPrice: "100",
            callbackUrl: '',
          ),
          onPaymentSuccess: (EsewaPaymentSuccessResult result){
            debugPrint('SUCCESS');
          },
          onPaymentFailure: (){
            debugPrint('FAILURE');
          },
          onPaymentCancellation: (){
            debugPrint('CANCELLED');
          }
      );
    }catch(e){
      debugPrint('EXCEPTION');
    }
  }


}