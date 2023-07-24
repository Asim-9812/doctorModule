import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/src/app/main_page.dart';
import 'package:medical_app/src/presentation/login/presentation/login_page.dart';

import '../data/login_provider.dart';

class StatusPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);


    return auth.user.token!=null ? MainPage():LoginPage();

  }
}
