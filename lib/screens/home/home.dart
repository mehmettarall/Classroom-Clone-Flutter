// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/custom_user.dart';
import '../../services/auth.dart';

class ClassRoom extends StatefulWidget {
  const ClassRoom({Key? key}) : super(key: key);

  @override
  ClassRoomState createState() => ClassRoomState();
}

class ClassRoomState extends State<ClassRoom> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Sınıflar"),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text("Çıkış"),
            ),
            SizedBox(height: 12.0),
            Text("Email: ${user!.email}"),
            Text("uid : ${user.uid}"),
          ],
        )));
  }
}
