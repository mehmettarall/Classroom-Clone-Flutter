import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/custom_user.dart';

class AccountsDB {
  CollectionReference accountReference =
      FirebaseFirestore.instance.collection("Accounts");

  CustomUser? user;

  AccountsDB({this.user});

  Future<void> updateAccounts(String name, String soyad, String type) async {
    return await accountReference.doc(user!.uid).set({
      'uid': user!.uid,
      'firstname': name,
      'lastname': soyad,
      'type': type,
      'email': user!.email,
    });
  }

  Future<List?> createAccountDataList() async {
    var listOfAccount = [];

    await accountReference.get().then((ss) {
      if (ss != null) {
        listOfAccount = ss.docs.toList();
      } else {
        print("Hesap Yok..");
        return [];
      }
    });

    return listOfAccount;
  }
}
