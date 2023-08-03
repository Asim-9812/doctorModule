




import 'package:dio/dio.dart';
import 'package:medical_app/src/core/api.dart';
import 'package:medical_app/src/data/model/registered_patient_model.dart';

class RegisteredPatientService{
  final dio = Dio();

  Future<List<RegisteredPatientModel>> getRegisteredPatients() async {
    try{
      final response = await dio.get('${Api.getRegisteredPatients}');

      final data = (response.data['result'] as List)
          .map((e) => RegisteredPatientModel.fromJson(e))
          .toList();

      return data;

    }on DioException catch(e){
      print(e);
      throw Exception('Something went wrong');
    }
  }


}