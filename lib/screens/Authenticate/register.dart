// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:donem_btr/screens/Authenticate/userform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/custom_user.dart';
import '../../services/accounts_db.dart';
import '../../services/auth.dart';
import '../../services/updatealldata.dart';
import '../loading.dart';
import 'login.dart';

class Register extends StatefulWidget {
  //final Function toggle_reg_log;
  //Register({required this.toggle_reg_log});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  // String ad = '';
  // String rool = 'student';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  Widget _buildBack() {
    return Container(
      child: TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())),
        child: const Align(
          alignment: Alignment.centerRight,
          child: const Text(
            "Girişe dönmek için tıklayınız",
            style: TextStyle(
                fontFamily: "PT-Sans", fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final AccountsDB pointer = AccountsDB(user: user);
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Colors.amberAccent,
                  // Colors.amberAccent,
                  Colors.deepOrange,
                  Colors.cyan,
                  Colors.deepOrangeAccent,
                  Colors.cyan,
                  Colors.deepOrange
                  // Color(0xFF5967ff),
                  // Color(0xFF5374ff),
                  // Colors.amberAccent,
                  //  Colors.amberAccent,
                  // Color(0xFF5180ff),
                  // Color(0xFF538bff),
                  // Color(0xFF5995ff),
                  // Colors.amberAccent,
                  // Colors.amberAccent,
                ],
              ),
            ),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    children: [
                      SizedBox(height: 60.0),
                      const Text(
                        'Yeni Üyelik Oluştur',
                        style: TextStyle(
                          fontFamily: 'PT-Sans',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Email", border: OutlineInputBorder()),
                        validator: (val) =>
                            val!.isEmpty ? 'Emaili Giriniz.' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),

                      SizedBox(height: 20.0),

                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Şifreyi Giriniz.",
                            border: OutlineInputBorder()),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Şifre uzunluğu en az 6 olmalıdır.'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       labelText: "İsim", border: OutlineInputBorder()),
                      //   validator: (val) => val!.isEmpty ? 'Adınız' : null,
                      //   onChanged: (val) {
                      //     setState(() {
                      //       ad = val;
                      //     });
                      //   },
                      // ),
                      // SizedBox(height: 20.0),
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //       labelText: "Rol Seçimi",
                      //       border: OutlineInputBorder()),
                      //   value: "Student",
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       rool = (newValue as String).toLowerCase();
                      //     });
                      //   },
                      //   items: ['Student', 'Teacher'].map((location) {
                      //     return DropdownMenuItem(
                      //       child: new Text(location),
                      //       value: location,
                      //     );
                      //   }).toList(),
                      // ),
                      _buildBack(),

                      SizedBox(height: 20.0),

                      SizedBox(height: 20.0),

                      ElevatedButton(
                        child: Text("Üye Ol",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto",
                                fontSize: 22)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);

                            var result =
                                await _auth.registerStudent(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Üye Olurken Sıkıntı Oluştu. Lütfen Bilgilerinizi Kontrol Ediniz';
                              });
                            } else {
                              await updateAllData();

                              setState(() => loading = false);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Userform()));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: Size(150, 50),
                        ),
                      ),

                      SizedBox(height: 12.0),

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
