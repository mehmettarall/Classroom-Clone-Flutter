import 'package:flutter/material.dart';

import 'login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showRegister = false;
  void toggle_reg_log() {
    setState(() => showRegister = !showRegister);
  }

  @override
  Widget build(BuildContext context) {
    // if (showRegister)
    //   return Register();
    // else
    //   return Login();
    return Login();
  }
}
