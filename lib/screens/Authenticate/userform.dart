// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/custom_user.dart';
import '../../services/accounts_db.dart';
import '../../services/updatealldata.dart';
import '../loading.dart';
import '../wrapper.dart';

class Userform extends StatefulWidget {
  const Userform({Key? key}) : super(key: key);

  @override
  _UserformState createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  String ad = "";
  String soyad = "";
  String rool = "student";
  String error = "";

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final AccountsDB pointer = AccountsDB(user: user!);

    return loading
        ? Loading()
        : Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //     "User Details",
            //     style: TextStyle(color: Colors.black),
            //   ),
            //   backgroundColor: Colors.white,
            // ),
            body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepOrange,
                  Colors.cyan,
                  Colors.deepOrangeAccent,
                  Colors.cyan,
                  Colors.deepOrange
                ],
              ),
            ),
            // form widget
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      const Text(
                        'Kayıt Bilgileri ',
                        style: TextStyle(
                          fontFamily: 'PT-Sans',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      SizedBox(height: 20.0),

                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Adınız", border: OutlineInputBorder()),
                        validator: (val) =>
                            val!.isEmpty ? 'Adınızı Giriniz' : null,
                        onChanged: (val) {
                          setState(() {
                            ad = val;
                          });
                        },
                      ),

                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Soyadınız",
                            border: OutlineInputBorder()),
                        validator: (val) =>
                            val!.isEmpty ? 'Soyadınızı Giriniz' : null,
                        onChanged: (val) {
                          setState(() {
                            soyad = val;
                          });
                        },
                      ),

                      SizedBox(height: 30.0),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: "Rolünüzü Seçiniz",
                            border: OutlineInputBorder()),
                        value: "Student",
                        onChanged: (newValue) {
                          setState(() {
                            rool = (newValue as String).toLowerCase();
                          });
                        },
                        items: ['Student', 'Teacher'].map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),

                      SizedBox(height: 20.0),

                      ElevatedButton(
                        child: Text("Kayıta Devam.."),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);

                            await pointer.updateAccounts(ad, soyad, rool);

                            await updateAllData();

                            setState(() => loading = false);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wrapper()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                      ),

                      SizedBox(height: 12.0),

                      // Prints error if any while registering
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ))),
          ));
  }
}
