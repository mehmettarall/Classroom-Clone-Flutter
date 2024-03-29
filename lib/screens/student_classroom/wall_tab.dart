import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../data/announcements.dart';
import '../student_classroom/announcement_page.dart';

class WallTab extends StatefulWidget {
  @override
  _WallTabState createState() => _WallTabState();
}

class _WallTabState extends State<WallTab> {
  @override
  Widget build(BuildContext context) {
    if (notificationList.length == 0) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
              child: Text(
            "Bildirim Yok",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontFamily: "Roboto", fontSize: 22),
          )));
    }

    return ListView.builder(
        itemCount: notificationList.length,
        itemBuilder: (context, int index) {
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  notificationList.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bildirim reddedildi')));
              },
              child: InkWell(
                  onTap: () {
                    notificationList[index].active = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AnnouncementPage(
                            announcement: notificationList[index])));
                  },
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 0.05)
                          ]),
                      child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "${notificationList[index].user.userDp}"),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notificationList[index]
                                                      .user
                                                      .firstName +
                                                  " " +
                                                  notificationList[index]
                                                      .user
                                                      .lastName,
                                              style: TextStyle(),
                                            ),
                                            Text(
                                              notificationList[index].dateTime,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ]),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  margin: EdgeInsets.only(
                                      left: 15, top: 5, bottom: 10),
                                  child: Text(notificationList[index].title,
                                      style: notificationList[index].active
                                          ? TextStyle(
                                              fontWeight: FontWeight.bold)
                                          : null))
                            ],
                          )))));
        });
  }
}
