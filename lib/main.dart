import 'package:flutter/material.dart';
import 'package:instagram_kt/responsive/mobile_screen_layout.dart';
import 'package:instagram_kt/responsive/responsive_layout_screen.dart';
import 'package:instagram_kt/responsive/web_screen_layout.dart';
import 'package:instagram_kt/utils/colors.dart';

void main() {
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
