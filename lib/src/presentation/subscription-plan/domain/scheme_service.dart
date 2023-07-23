

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/src/presentation/subscription-plan/domain/scheme_model.dart';

import '../../../core/api.dart';


final schemeList = FutureProvider<List<SchemeModel>>(
        (ref) => SchemeService().getSchemeList());


class SchemeService {

  final dio = Dio();

  Future<List<SchemeModel>> getSchemeList() async {
    try {
      final response = await dio.get(Api.schemePlan);
      final data = (response.data['result'] as List)
          .map((e) => SchemeModel.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}