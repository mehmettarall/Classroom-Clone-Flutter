import 'package:donem_btr/screens/teacher_classroom/add_class.dart';
import 'package:donem_btr/screens/teacher_classroom/classes_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Navigation_Drawer/navigation_drawer.dart';
import '../data/accounts.dart';
import '../data/custom_user.dart';
import '../services/auth.dart';

class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          "Sınıflar",
          style: TextStyle(
              color: Colors.black, fontFamily: "Roboto", fontSize: 22),
        ),
        backgroundColor: Colors.deepOrangeAccent[100],
        actions: [
          // Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20),
          //     child: Text("Welcome, " + (account!.firstName as String),
          //       style: TextStyle(color: Colors.black, fontSize: 16),
          //     ),
          // ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black87,
              size: 30,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: ClassesTab(account),
      backgroundColor: Colors.deepOrangeAccent[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => AddClass(),
              ))
              .then((_) => setState(() {}));
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
