import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/src/presentation/login/presentation/login_page.dart';

import '../../patient/patient_dashboard/main_page.dart';
import '../domain/service/login_service.dart';

class StatusPage extends ConsumerWidget {

  final int accountId;
  StatusPage({required this.accountId});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(userProvider);
    if(auth.isNotEmpty){
      if(auth[0].typeID == 1 && accountId == 1){
        print('merchant');
        return const PatientMainPage();
      }
      else if(auth[0].typeID == 2 && accountId == 2){
        print('org');
        return const PatientMainPage();
      }
      else if(auth[0].typeID == 3 && accountId == 3){
        print('doctor');
        return const PatientMainPage();
      }
      else if(auth[0].typeID == 4 && accountId == 4){
        print('patient');
        return const PatientMainPage();
      }
      else{
        return LoginPage();
      }
    }
    else{
      return LoginPage();
    }



  }
}
