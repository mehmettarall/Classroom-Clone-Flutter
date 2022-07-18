import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../../data/accounts.dart';
import '../../../data/attachments.dart';
import '../../../data/classrooms.dart';
import '../../../data/custom_user.dart';
import '../../../services/announcements_db.dart';
import '../../../services/attachments_db.dart';
import '../../../services/submissions_db.dart';
import '../../../services/updatealldata.dart';
import '../../../utils/datetime.dart';
import '../../../widgets/attachment_editor_composer.dart';

class AddAnnouncement extends StatefulWidget {
  ClassRooms classRoom;

  AddAnnouncement({required this.classRoom});

  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  String title = '';
  String description = '';
  String type = 'Bildirim';
  String dateTime = todayDate();
  String dueDate = todayDate();
  List attachments = [];

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future addFile(String user, String className) async {
    File? file;
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    file = File(path);

    final fileName = basename(file.path);
    final destination = user + "/" + className + '/$fileName';

    UploadTask? task = uploadFile(destination, file);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('İndirme-Linki: $urlDownload');

    String safeURL = urlDownload.replaceAll(new RegExp(r'[^\w\s]+'), '');
    await AttachmentsDB().createAttachmentsDB(
        fileName, urlDownload, safeURL, lookupMimeType(fileName) as String);

    setState(() => attachments.add(Attachment(
        name: fileName,
        url: urlDownload,
        type: lookupMimeType(fileName) as String)));
  }

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    return Scaffold(
        // appbar part
        appBar: AppBar(
          backgroundColor: widget.classRoom.uiColor,
          elevation: 0.5,
          title: Text(
            "Duyuru Ekle.",
            style: TextStyle(
                color: Colors.white, fontFamily: "Roboto", fontSize: 22),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {},
            )
          ],
        ),

        // body part
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Başlık", border: OutlineInputBorder()),
                      validator: (val) =>
                          val!.isEmpty ? 'Başlığı Giriniz.' : null,
                      onChanged: (val) {
                        setState(() {
                          title = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Tip:", border: OutlineInputBorder()),
                      value: type,
                      onChanged: (newValue) {
                        setState(() {
                          type = newValue as String;
                        });
                      },
                      items: ['Bildirim', 'Ödev'].map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),

                    if (type == 'Ödev') SizedBox(height: 20.0),

                    if (type == 'Ödev')
                      DateTimeField(
                        decoration: InputDecoration(
                            labelText: "Süre", border: OutlineInputBorder()),
                        format: DateFormat('h:mm a EEE, MMM d, yyyy'),
                        initialValue: DateTime.now(),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                        onChanged: (date) => dueDate = formatDate(date),
                      ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Tanım", border: OutlineInputBorder()),
                      maxLines: 5,
                      onChanged: (val) {
                        setState(() {
                          description = val;
                        });
                      },
                    ),

                    SizedBox(height: 10.0),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "Ekler::",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        )),
                    if (attachments.length > 0)
                      AttachmentEditorComposer(attachmentList: attachments),

                    OutlinedButton(
                        onPressed: () {
                          addFile(account!.email as String,
                              widget.classRoom.className);
                          setState(() => {});
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Ek Ekle:",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14)),
                                  Icon(
                                    Icons.add_circle_outline_outlined,
                                    color: widget.classRoom.uiColor,
                                    size: 32,
                                  )
                                ]))),

                    SizedBox(height: 20.0),

                    // Login  button
                    ElevatedButton(
                      child: Text("Ekle",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontSize: 22)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await AnnouncementDB(user: user).addAnnouncements(
                              title,
                              type,
                              description,
                              widget.classRoom.className,
                              dateTime,
                              dueDate);

                          for (int i = 0; i < attachments.length; i++) {
                            String safeURL = attachments[i]
                                .url
                                .replaceAll(new RegExp(r'[^\w\s]+'), '');

                            await AttachmentsDB().createAttachAnnounceDB(
                                title, attachments[i].url, safeURL);
                          }

                          if (type == 'Ödev') {
                            for (int index = 0;
                                index < widget.classRoom.students.length;
                                index++) {
                              await SubmissionDB().addSubmissions(
                                  widget.classRoom.students[index].uid,
                                  widget.classRoom.className,
                                  title);
                            }
                          }
                          await updateAllData();

                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: widget.classRoom.uiColor,
                        minimumSize: Size(150, 50),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
