import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/custom_user.dart';
import '../utils/datetime.dart';

class SubmissionDB {
  CollectionReference submissionReference =
      FirebaseFirestore.instance.collection("Submissions");

  CustomUser? user;

  SubmissionDB({this.user});

  Future<void> addSubmissions(
      String uid, String classroom, String assignment) async {
    return await submissionReference
        .doc(uid + "_" + classroom + "_" + assignment)
        .set({
      'uid': uid,
      'classroom': classroom,
      'assignment': assignment,
      'dateTime': todayDate(),
      'submitted': false,
    });
  }

  Future<void> updateSubmissions(
      String uid, String classroom, String assignment, bool submission) async {
    return await submissionReference
        .doc(uid + "_" + classroom + "_" + assignment)
        .update({
      'uid': uid,
      'classroom': classroom,
      'assignment': assignment,
      'dateTime': todayDate(),
      'submitted': submission,
    });
  }

  Future<void> deleteSubmissions(
      String uid, String classroom, String assignment) async {
    return await submissionReference
        .doc(uid + "_" + classroom + "_" + assignment)
        .delete();
  }

  Future<List?> createSubmissionListDB() async {
    return await submissionReference.get().then((ss) => ss.docs.toList());
  }
}
