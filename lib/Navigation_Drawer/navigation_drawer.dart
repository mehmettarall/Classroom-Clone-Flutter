import 'package:donem_btr/Navigation_Drawer/calendar.dart';
import 'package:donem_btr/Navigation_Drawer/soruteac.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final urlImage =
        "https://www.yukadukkan.com/Uploads/Blog/Hayatinizi-duzenlemede-kullanabilecegini-a3cc.png";
    return Drawer(
      child: Material(
        color: Colors.deepOrangeAccent[100],
        child: ListView(
          children: <Widget>[
            buildHeader(urlImage: urlImage, onClicked: () {}),
            buildMenuItem(text: "Hoş Geldiniz", icon: Icons.handshake),
            Container(
              padding: padding,
              child: Column(
                children: [
                  Divider(color: Colors.white70, thickness: 1),
                  const SizedBox(height: 10),
                  //Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'Geçici Çıkış',
                    icon: Icons.business_center,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Takvim',
                    icon: Icons.room,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Grafik',
                    icon: Icons.drive_file_rename_outline_rounded,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Ders İçi Geri Dönüt',
                    icon: Icons.drive_file_rename_outline_rounded,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70, thickness: 1),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Profil',
                    icon: Icons.person,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Ayarlar',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      // case 0:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => Login(),
      //   ));
      //   break;
      // case 1:
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => /*HomePage(),*/ SettingsUI()),
      //   );
      //   break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => /*fire(),*/ MyAppnnn()),
        );
        break;
      // case 3:
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => /*HomePagedd(),*/ SettingsUI()));
      //   break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => SettingsUI()),
        );
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => fireteach() /*SettingsUI()*/ /*fire*/));
        break;
      // case 9:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => TeacherHomePage(),
      //   ));
      //   break;
    }
  }
}
