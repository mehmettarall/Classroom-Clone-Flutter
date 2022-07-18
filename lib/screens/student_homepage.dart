import 'package:donem_btr/Navigation_Drawer/Navigation_Drawer_Student.dart';
import 'package:donem_btr/screens/student_classroom/add_class.dart';
import 'package:donem_btr/screens/student_classroom/classes_tab.dart';
import 'package:donem_btr/screens/student_classroom/timeline_tab.dart';
import 'package:donem_btr/screens/student_classroom/wall_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/accounts.dart';
import '../data/custom_user.dart';
import '../services/auth.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    final tabs = [WallTab(), TimelineTab(), ClassesTab()];

    return Scaffold(
      drawer: NavigationDrawerWidgetStudent(),
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
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: Text(
          //     "Hoş Geldiniz, " + (account!.firstName as String),
          //     style: TextStyle(color: Colors.black, fontSize: 16),
          //   ),
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
      body: tabs[_selectedIndex],
      backgroundColor: Colors.deepOrangeAccent[100],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrangeAccent[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Çalışmalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Sınıflar",
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
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
