import 'package:flutter/material.dart';

import '../../data/classrooms.dart';
import '../teacher_classroom/classwork_tab.dart';
import '../teacher_classroom/people_tab.dart';
import '../teacher_classroom/stream_tab.dart';
import 'announcement_crud/add_announcement.dart';

class ClassRoomPage extends StatefulWidget {
  ClassRooms classRoom;
  Color uiColor;

  ClassRoomPage({required this.classRoom, required this.uiColor});

  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      StreamTab(className: widget.classRoom.className, uiColor: widget.uiColor),
      ClassWork(widget.classRoom.className),
      PeopleTab(classRoom: widget.classRoom, uiColor: widget.uiColor)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.uiColor,
        elevation: 0.5,
        title: Text(
          widget.classRoom.className,
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto", fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Akış",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Sınıf Çalışmaları',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Kullanıcılar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: widget.uiColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) =>
                    AddAnnouncement(classRoom: widget.classRoom),
              ))
              .then((_) => setState(() {}));
        },
        backgroundColor: widget.uiColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
