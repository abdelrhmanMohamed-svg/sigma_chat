import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgima_chat/firebase_options.dart';
import 'package:sgima_chat/services/hive_local_database.dart';
import 'package:sgima_chat/utils/app_constants.dart';
import 'package:sgima_chat/utils/routes/app_router.dart';
import 'package:sgima_chat/utils/routes/app_routes.dart';
import 'package:sgima_chat/utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    HiveLocalDatabase.hiveInit(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.themeData,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.chatRoutePage,
    );
  }
}
