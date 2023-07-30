

import 'package:dio/dio.dart';
import 'package:medical_app/src/presentation/login/domain/model/user.dart';

import '../../core/api.dart';

class UserService{

  final dio = Dio();

  Future<List<User>> getDoctors() async {
    dio.options.headers['Authorization'] = Api.bearerToken;
    try {
      final response = await dio.get('${Api.getUsers}',);

        final data = (response.data['result'] as List)
            .map((e) => User.fromJson(e))
            .where((element) => element.typeID == 3)
            .toList();
        return data;

    } on DioException catch (err) {
      print(err);
      throw Exception('Unable to fetch data');
    }
  }


}