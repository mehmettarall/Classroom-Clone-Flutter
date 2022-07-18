import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/custom_user.dart';

class AnnouncementDB {
  CollectionReference announcementReference =
      FirebaseFirestore.instance.collection("Announcements");

  CustomUser? user;

  AnnouncementDB({this.user});

  Future<void> addAnnouncements(String title, String type, String description,
      String className, String dateTime, String dueDate) async {
    return await announcementReference.doc(className + "__" + title).set({
      'title': title,
      'description': description,
      'type': type,
      'dateTime': dateTime,
      'dueDate': dueDate,
      'className': className,
      'uid': user!.uid,
    });
  }

  Future<void> updateAnnouncements(String title, String description,
      String className, String dateTime, String dueDate) async {
    return await announcementReference.doc(className + "__" + title).update({
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'dueDate': dueDate,
      'className': className,
    });
  }

  Future<void> deleteAnnouncements(String title, String className) async {
    return await announcementReference.doc(className + "__" + title).delete();
  }

  Future<List?> createAnnouncementListDB() async {
    return await announcementReference.get().then((ss) => ss.docs.toList());
  }
}
