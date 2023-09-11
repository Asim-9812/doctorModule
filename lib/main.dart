import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_app/src/app/app.dart';
import 'package:medical_app/src/presentation/login/domain/model/user.dart';
import 'package:workmanager/workmanager.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) { //simpleTask will be emitted here.
    return Future.value(true);
  });
}

final box = Provider<String?>((ref) => null);

final boxA = Provider<List<User>>((ref) => []);

late Box userBox2;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerOneOffTask("task-identifier", "simpleTask");

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      )
  );


  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  final userBox = await Hive.openBox<String>('user1');
  await Hive.openBox<String>('tokenBox');
  final userSession = await Hive.openBox< User>('session');
  userBox2 = await Hive.openBox('user');
  runApp(ProviderScope(
      overrides: [
        box.overrideWithValue(userBox.get('userData')),
        boxA.overrideWithValue(userSession.values.toList()),
      ],

      child: MyApp()));
}

