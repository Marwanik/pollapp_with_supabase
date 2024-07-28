import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pollapp/presentation/pages/web/admin_page.dart';
import 'package:pollapp/presentation/pages/mobile/splashScreem.dart';
import 'package:pollapp/presentation/pages/web/loginadminScreen.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      // handle notification tapped logic here
    },
  );

  setupLocator();
  await Supabase.initialize(
    url: 'https://gjhtlmmqrhphbqfxmatm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqaHRsbW1xcmhwaGJxZnhtYXRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE1Nzk0NzYsImV4cCI6MjAzNzE1NTQ3Nn0.d6tNNnBzzt8HR3XKEhCIZ4I0_iOHG96OsR4vNhxy4qk',
  );

  runApp(const ProviderScope(child: MyApp()));
}

void setupLocator() {
  GetIt.instance.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     //home: SplashScreen(),
      home:Loginadminscreen(),
    );
  }
}
