import 'package:flutter/material.dart';
import 'package:profile1_flutter/my_profile_page.dart';
class MyProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: "My Profile App",
     home: MyProfilePage(),
     theme: ThemeData.light(),
   );
  }
}
