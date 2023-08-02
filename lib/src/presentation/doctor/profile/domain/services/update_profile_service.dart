



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/api.dart';

final userUpdateProvider = StateProvider((ref) => UpdateProfile());

class UpdateProfile{

  final dio = Dio();

  Future<Either<String, dynamic>> updateUser({
    required int ID,
    required String userID,
    required int typeID,
    required int referredID,
    required int parentID,
    required String firstName,
    required String lastName,
    required String password,
    required int countryID,
    required int provinceID,
    required int districtID,
    required int municipalityID,
    required int wardNo,
    required String localAddress,
    required String contactNo,
    required String email,
    required int roleID,
    required String designation,
    required String joinedDate,
    required String validDate,
    required String signatureImage,
    required String profileImage,
    required bool isActive,
    required int genderID,
    required String entryDate,
    required int PrefixSettingID,
    required String token,
    required String flag,
    required XFile profileImageUrl,
    required XFile signatureImageUrl,
  }) async {
    try {
      Map<String, dynamic> data = {
        'ID': ID,
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
        'PrefixSettingID': PrefixSettingID,
        'token': token,
        'flag': flag,
        'profileImageUrl': profileImageUrl,
        'signatureImageUrl': signatureImageUrl,
      };

      FormData formData = FormData.fromMap(data);
      final response = await dio.post('${Api.userUpdate}', data: formData);

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        print(response);
        return Left('Unable to register.');
      }
    } on DioException catch (e) {
      print('$e');
      return Left('Something went wrong');
    }
  }



}