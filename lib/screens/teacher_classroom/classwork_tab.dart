import 'package:flutter/material.dart';

import '../../data/announcements.dart';
import '../student_classroom/announcement_page.dart';

class ClassWork extends StatefulWidget {
  final String className;

  ClassWork(this.className);

  @override
  _ClassWorkState createState() => _ClassWorkState();
}

class _ClassWorkState extends State<ClassWork> {
  @override
  Widget build(BuildContext context) {
    List _classWorkList = announcementList
        .where((i) =>
            i.type == "Ödevler" && i.classroom.className == widget.className)
        .toList();

    return ListView.builder(
        itemCount: _classWorkList.length,
        itemBuilder: (context, int index) {
          return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      AnnouncementPage(announcement: _classWorkList[index]))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _classWorkList[index].classroom.uiColor),
                        child: Icon(
                          Icons.assignment,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _classWorkList[index].title,
                            style: TextStyle(letterSpacing: 1),
                          ),
                          Text(
                            "Süresi Dolmuş " + _classWorkList[index].dueDate,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
