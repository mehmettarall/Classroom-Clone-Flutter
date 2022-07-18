import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/custom_user.dart';

class ClassesDB {
  CollectionReference classReference =
      FirebaseFirestore.instance.collection("Classes");
  CollectionReference studentReference =
      FirebaseFirestore.instance.collection("Students");

  CustomUser? user;

  ClassesDB({this.user});

  Future<void> updateClasses(
      String className, String description, Color uiColor) async {
    return await classReference.doc(className).set({
      'className': className,
      'description': description,
      'creator': user!.uid,
      'uiColor': uiColor.value.toString(),
    });
  }

  Future<void> updateStudentClasses(String className) async {
    return await studentReference
        .doc(user!.uid + "___" + className)
        .set({'className': className, 'uid': user!.uid});
  }

  Future<List?> createClassesDataList() async {
    return await classReference.get().then((ss) => ss.docs.toList());
  }

  Future<List?> makeStudentsAccountList() async {
    return await studentReference.get().then((ss) => ss.docs.toList());
  }
}
