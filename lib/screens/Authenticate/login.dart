

import 'package:donem_btr/screens/Authenticate/register.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/updatealldata.dart';
import '../loading.dart';

class Login extends StatefulWidget {
  //final Function toggle_reg_log;
  //Login({required this.toggle_reg_log});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  Widget _goReg() {
    return Container(
      child: TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register())),
        child: const Align(
          alignment: Alignment.centerRight,
          child: const Text(
            "Üye Olmak İçin Tıklayınız",
            style: TextStyle(
                fontFamily: "PT-Sans", fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      Colors.deepOrange,
                      Colors.cyan,
                      Colors.deepOrangeAccent,
                      Colors.cyan,
                      Colors.deepOrange
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20.0),
                              const Text(
                                'Giriş ',
                                style: TextStyle(
                                  fontFamily: 'PT-Sans',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              SizedBox(height: 40.0),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder()),
                                validator: (val) =>
                                    val!.isEmpty ? 'Emailinizi Giriniz' : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Şifre",
                                    border: OutlineInputBorder()),
                                obscureText: true,
                                validator: (val) => val!.length < 6
                                    ? 'Şifrenizin uzunluğu en az 6 olmalı'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              _goReg(),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                child: Text("Giriş",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 30)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);

                                    await updateAllData();

                                    var result = await _auth.loginStudent(
                                        email, password);

                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Giriş Yaparken Sıkıntı Oluştu. Lütfen Bilgilerinizi Kontrol Ediniz';
                                      });
                                    } else {
                                      print("\t\t\tGiriş Başarılı.");

                                      setState(() => loading = false);
                                    }
                                  }
                                  //TeacherHomePage();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              )
                            ],
                          )),
                    ))));
  }
}
