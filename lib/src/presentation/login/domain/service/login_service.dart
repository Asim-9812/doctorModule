import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/api.dart';
import '../model/user.dart';

class AuthService {
  static final dio = Dio();

  static Future<Either<String, User>> userLogin(
      {
        required String email,
        required String password,
      }) async {
    try {
      final response = await dio.post(
        Api.userLogin,
        data: {
          'key':'12',
          'email': email,
          'password': password,
          'flag':'Login'
        },
      );
      final box = Hive.box<String>('user');
      box.put('userData', jsonEncode(response.data));
      final userData = box.get('userData');
      if (userData != null) {
        final decodedData = jsonDecode(userData);
        print('userdata : $decodedData');
      }
      print(response.data);
      return Right(User.fromJson(response.data));

    } on DioError catch (err) {
      print(err.response);
      throw Exception(err.response?.data['data']);
    }
  }




}