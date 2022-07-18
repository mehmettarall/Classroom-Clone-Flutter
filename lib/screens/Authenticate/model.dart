import '../../services/accounts_db.dart';

class UserModel {
  String? email;
  String? wrool;
  String? uid;
  String? ad;
  String? foto;

  UserModel({this.uid, this.email, this.wrool, this.ad, this.foto});
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        wrool: map['wrool'],
        ad: map["name"],
        foto: map["foto"]);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'wrool': wrool, "name": ad, "foto": ""};
  }
}

List accountList = [];

Future<bool> getListAccount() async {
  accountList = [];

  List? jsonList = await AccountsDB().createAccountDataList();
  jsonList!.forEach((element) {
    var data = element.data();

    accountList.add(UserModel(
      uid: data["uid"],
      email: data["firstname"],
      wrool: data["lastname"],
      ad: data["email"],
      foto: data["type"],
    ));
  });

  print("\t\t\t\tGot Account list");
  return true;
}

bool accountExists(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid,
      orElse: () => null);
  return data != null ? true : false;
}

UserModel? getAccount(uid) {
  var data = accountList.firstWhere((element) => element.uid == uid,
      orElse: () => null);
  return data;
}
