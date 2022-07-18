// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const fire());
// }
//
// class fire extends StatelessWidget {
//   const fire({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Anketler',
//       home: firePage(),
//     );
//   }
// }
//
// class firePage extends StatefulWidget {
//   const firePage({Key? key}) : super(key: key);
//
//   @override
//   _FirePageState createState() => _FirePageState();
// }
//
// class _FirePageState extends State<firePage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _voteController = TextEditingController();
//   final TextEditingController _voteNoController = TextEditingController();
//   final TextEditingController _sinifisim = TextEditingController();
//   final TextEditingController _icisim = TextEditingController();
//   //final TextEditingController _al1 = TextEditingController();
//   //final TextEditingController _al2 = TextEditingController();
//   String className = "";
//   String classalt = "";
//   //final TextEditingController _boolController = TextEditingController();
//
//   //final CollectionReference _vote = FirebaseFirestore.instance.collection('oy');
//   //final alovelaceDocumentRef = db.collection("users").doc("alovelace");
//   // final CollectionReference _vote = FirebaseFirestore.instance
//   //     .collection('Classes')
//   //     .doc("aa") as CollectionReference<Object?>;
//   // final _vote = FirebaseFirestore.instance
//   //     .collection("Classes")
//   //     .doc(className)
//   //     .collection("dene");
//
//   Future<void> _getgecdata([DocumentSnapshot? documentSnapshot]) async {
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                       labelText: "Sınıf İsmi", border: OutlineInputBorder()),
//                   validator: (val) =>
//                       val!.isEmpty ? 'Sınıf İsmini Giriniz' : null,
//                   onChanged: (val) {
//                     setState(() {
//                       className = val;
//                     });
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       labelText: "Sınıf İsmi", border: OutlineInputBorder()),
//                   validator: (val) =>
//                       val!.isEmpty ? 'Sınıf İsmini Giriniz' : null,
//                   onChanged: (val) {
//                     setState(() {
//                       classalt = val;
//                     });
//                   },
//                 ),
//                 /*TextField(
//                   controller: _boolController,
//                   decoration: const InputDecoration(labelText: 'Yes-No'),
//                 ),*/
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   child: Text("helo"),
//                   onPressed: () async {
//                     // Hide the bottom sheet
//                     Navigator.of(context).pop(_createOrUpdate());
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }
//
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     final _vote = FirebaseFirestore.instance
//         .collection("Classes")
//         .doc(className)
//         .collection(classalt);
//
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _nameController.text = documentSnapshot['name'];
//       _voteController.text = documentSnapshot['vote'].toString();
//       _voteNoController.text = documentSnapshot['voteno'].toString();
//       //_boolController.text = documentSnapshot['yes'].toString();
//     }
//
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 // prevent the soft keyboard from covering text fields
//                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   controller: _voteController,
//                   decoration: const InputDecoration(
//                     labelText: 'Vote',
//                   ),
//                 ),
//                 TextField(
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   controller: _voteNoController,
//                   decoration: const InputDecoration(
//                     labelText: 'No-Vote',
//                   ),
//                 ),
//                 /*TextField(
//                   controller: _boolController,
//                   decoration: const InputDecoration(labelText: 'Yes-No'),
//                 ),*/
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   child: Text(action == 'create' ? 'Create' : 'Update'),
//                   onPressed: () async {
//                     final String? name = _nameController.text;
//                     final double? vote = double.tryParse(_voteController.text);
//                     final double? voteno =
//                         double.tryParse(_voteNoController.text);
//                     //final bool yesno = _boolController.text as bool;
//                     if (name != null && vote != null && voteno != null) {
//                       if (action == 'create') {
//                         // Persist a new product to Firestore
//                         await _vote.add(
//                             {"name": name, "vote": vote, "voteno": voteno});
//                       }
//
//                       if (action == 'update') {
//                         // Update the product
//                         await _vote.doc(documentSnapshot!.id).update(
//                             {"name": name, "vote": vote, "voteno": voteno});
//                       }
//
//                       // Clear the text fields
//                       _nameController.text = '';
//                       _voteController.text = '';
//                       _voteNoController.text = '';
//
//                       // Hide the bottom sheet
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }
//
//   Future<void> _add([DocumentSnapshot? documentSnapshot]) async {
//     final _vote = FirebaseFirestore.instance
//         .collection("Classes")
//         .doc(className)
//         .collection(classalt);
//     if (documentSnapshot != null) {
//       _voteController.text = documentSnapshot['vote'].toString();
//       final double? vote = double.tryParse(_voteController.text);
//       await _vote.doc(documentSnapshot.id).update({"vote": (vote! + 1)});
//     }
//   }
//
//   Future<void> _dusuk([DocumentSnapshot? documentSnapshot]) async {
//     final _vote = FirebaseFirestore.instance
//         .collection("Classes")
//         .doc(className)
//         .collection(classalt);
//     if (documentSnapshot != null) {
//       _voteController.text = documentSnapshot['vote'].toString();
//       final double? vote = double.tryParse(_voteController.text);
//       await _vote.doc(documentSnapshot.id).update({"vote": (vote! - 1)});
//     }
//   }
//
//   Future<void> _down([DocumentSnapshot? documentSnapshot]) async {
//     final _vote = FirebaseFirestore.instance
//         .collection("Classes")
//         .doc(className)
//         .collection(classalt);
//     if (documentSnapshot != null) {
//       _voteNoController.text = documentSnapshot['voteno'].toString();
//       final double? vote = double.tryParse(_voteNoController.text);
//       await _vote.doc(documentSnapshot.id).update({"voteno": (vote! - 1)});
//     }
//   }
//
//   // Deleteing a product by id
//   Future<void> _deleteProduct(String productId) async {
//     final _vote = FirebaseFirestore.instance
//         .collection("Classes")
//         .doc(className)
//         .collection(classalt);
//     await _vote.doc(productId).delete();
//
//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('You have successfully deleted a product')));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _vote = FirebaseFirestore.instance
//         .collection("Classes")
//         .doc(className)
//         .collection(classalt);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Anketler'),
//       ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _vote.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Column(
//                       children: [
//                         Text(documentSnapshot['vote'].toString()),
//                         Text(documentSnapshot['voteno'].toString())
//                       ],
//                     ), //Text(documentSnapshot['vote'].toString()),
//                     trailing: SizedBox(
//                       width: 200,
//                       child: Row(
//                         children: [
//                           IconButton(
//                               icon: const Icon(Icons.add),
//                               onPressed: () => _add(documentSnapshot)),
//                           IconButton(
//                               icon: const Icon(Icons.people),
//                               onPressed: () => _dusuk(documentSnapshot)),
//                           // IconButton(
//                           //     icon: const Icon(Icons.edit),
//                           //     onPressed: () =>
//                           //         _createOrUpdate(documentSnapshot)),
//                           IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       // Add new product
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _getgecdata(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
