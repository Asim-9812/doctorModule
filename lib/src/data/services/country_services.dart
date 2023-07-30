


import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/api.dart';
import '../model/country_model.dart';

class CountryService{

  final dio = Dio();


  Future<List<Country>> getCountry() async {
    try {
      final response = await dio.get(Api.getCountry,);

      final data = (response.data['result'] as List)
          .map((e) => Country.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


  Future<List<ProvinceModel>> getProvince({
    required int countryId
}) async {
    print('$countryId');
    try {
      final response = await dio.get('${Api.getProvince}$countryId',);

      final data = (response.data['result'] as List)
          .map((e) => ProvinceModel.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<DistrictModel>> getDistrict({
    required int provinceId
}) async {
    try {
      final response = await dio.get('${Api.getDistrict}$provinceId',);

      final data = (response.data['result'] as List)
          .map((e) => DistrictModel.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


  Future<List<MunicipalityModel>> getMunicipality({
    required int districtId
  }) async {
    dio.options.headers['Authorization'] = Api.bearerToken;
    try {
      final response = await dio.get('${Api.getMunicipality}$districtId');

      final data = (response.data['result'] as List)
          .map((e) => MunicipalityModel.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err);
      throw Exception('Unable to fetch data');
    }
  }


}