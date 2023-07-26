import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../../main.dart';
import '../../../../core/api.dart';
import '../model/user.dart';

final userLoginProvider = StateProvider((ref) => LoginProvider());
final userProvider = StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider(ref.watch(boxA)));


class LoginProvider{
  final dio = Dio();



  Future<Either<String,Map<String,dynamic>>> userLogin({required int accountId,required String email, required String password}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      try{
        final response = await dio.post(Api.userLogin, data: {
          "key":'12',
          "email": email,
          "password": password,
          "flag":'Login'
        });
        if(accountId ==0){
          return Left('Please select an account type');
        }


        if(response.statusCode == 200 && response.data["result"]["userID"] != null){

          if(response.data["result"]["typeID"] == accountId){
            final token = response.data["result"]["token"];
            Box tokenBox = Hive.box<String>('tokenBox');
            tokenBox.put('accessToken', token);
            print(response.data);
            return Right(response.data);
          }else{
            return Left('Account Type doesn\'t match');
          }

        }else{
          print(response.data);
          return Left('Invalid Credential');
        }
      } on DioException catch(err){
        print(err);
        return Left('Something went wrong');
      }
    }else{
      return Left('No internet connection');
    }

  }
}


class UserProvider extends StateNotifier<List<User>>{
  UserProvider(super._state);

  Future<String> getUserInfo({required Map<String,dynamic> response}) async{
    print('User provider: $response');
    final newUser = User.fromJson(response["result"]);

    if(Hive.box<User>('session').isEmpty){
      Hive.box<User>('session').add(newUser);
      state = [newUser];
    }else{
      Hive.box<User>('session').putAt(0, newUser);
      state = [newUser];
    }
    return 'success';
  }

  void userLogout() async{
    Hive.box<String>('tokenBox').clear();
    Hive.box<User>('session').clear();
    state = [];
  }
}