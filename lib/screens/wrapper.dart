// ignore_for_file: prefer_const_constructors

import 'package:donem_btr/screens/student_homepage.dart';
import 'package:donem_btr/screens/teacher_homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/accounts.dart';
import '../data/custom_user.dart';
import 'Authenticate/authenticate.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    if (user != null && accountExists(user.uid)) {
      var typeOfCurrentUser = getAccount(user.uid)!.type;
      return typeOfCurrentUser == 'student'
          ? StudentHomePage()
          : TeacherHomePage();
    } else
      return Authenticate();
  }
}
