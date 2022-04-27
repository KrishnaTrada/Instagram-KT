import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_kt/responsive/mobile_screen_layout.dart';
import 'package:instagram_kt/responsive/responsive_layout_screen.dart';
import 'package:instagram_kt/responsive/web_screen_layout.dart';
import 'package:instagram_kt/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDX32kQMoZgSgFfepQZ2fHHAdVZD7TDBNM",
            appId: "1:59258408310:web:9ee006bc812f6a88633e57",
            messagingSenderId: "59258408310",
            projectId: "instagram-kt",
            storageBucket: "instagram-kt.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout()),
    );
  }
}
