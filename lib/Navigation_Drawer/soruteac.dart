import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const fireteach());
}

class fireteach extends StatelessWidget {
  const fireteach({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Sorular',
      home: firePage(),
    );
  }
}

class firePage extends StatefulWidget {
  const firePage({Key? key}) : super(key: key);

  @override
  _FirePageState createState() => _FirePageState();
}

class _FirePageState extends State<firePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bes = TextEditingController();
  final TextEditingController _drt = TextEditingController();
  final TextEditingController _uc = TextEditingController();
  final TextEditingController _iki = TextEditingController();
  final TextEditingController _bir = TextEditingController();

  //final TextEditingController _boolController = TextEditingController();

  Future<void> _deleteProduct(String productId) async {
    final nam = FirebaseAuth.instance.currentUser?.email.toString();

    final CollectionReference _vote = FirebaseFirestore.instance
        .collection('Sorular')
        .doc("Classlar")
        .collection(nam!);
    await _vote.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Silme işlemi başarılı.')));
  }

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    final nam = FirebaseAuth.instance.currentUser?.email.toString();

    final CollectionReference _vote = FirebaseFirestore.instance
        .collection('Sorular')
        .doc("Classlar")
        .collection(nam!);
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['Soru'];
      _bes.text = documentSnapshot['Çok iyi'].toString();
      _drt.text = documentSnapshot['iyi'].toString();
      _uc.text = documentSnapshot['Orta'].toString();
      _iki.text = documentSnapshot['Kötü'].toString();
      _bir.text = documentSnapshot['Çok Kötü'].toString();

      //_boolController.text = documentSnapshot['yes'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Soru'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _bes,
                  decoration: const InputDecoration(
                    labelText: 'Çok İyi',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _drt,
                  decoration: const InputDecoration(
                    labelText: 'İyi',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _uc,
                  decoration: const InputDecoration(
                    labelText: 'Orta',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _iki,
                  decoration: const InputDecoration(
                    labelText: 'Kötü',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _bir,
                  decoration: const InputDecoration(
                    labelText: 'Çok Kötü',
                  ),
                ),
                /*TextField(
                  controller: _boolController,
                  decoration: const InputDecoration(labelText: 'Yes-No'),
                ),*/
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final double? bes = double.tryParse(_bes.text);
                    final double? drt = double.tryParse(_drt.text);
                    final double? uc = double.tryParse(_uc.text);
                    final double? iki = double.tryParse(_iki.text);
                    final double? bir = double.tryParse(_bir.text);

                    if (name != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _vote.add({
                          "Soru": name,
                          "Çok İyi": bes,
                          "İyi": drt,
                          "Orta": uc,
                          "Kötü": iki,
                          "Çok Kötü": bir
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _vote.doc(documentSnapshot!.id).update({
                          "Soru": name,
                          "Çok İyi": bes,
                          "İyi": drt,
                          "Orta": uc,
                          "Kötü": iki,
                          "Çok Kötü": bir
                        });
                      }

                      _nameController.text = '';
                      _bes.text = '';
                      _drt.text = '';
                      _uc.text = '';
                      _iki.text = '';
                      _bir.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final nam = FirebaseAuth.instance.currentUser?.email.toString();

    final CollectionReference _vote = FirebaseFirestore.instance
        .collection('Sorular')
        .doc("Classlar")
        .collection(nam!);

    //_boolController.text = documentSnapshot['yes'].toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorular'),
        backgroundColor: Colors.deepOrangeAccent[100],
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _vote.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  color: Colors.greenAccent,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['Soru']),
                    subtitle: Column(
                      children: [
                        Text(documentSnapshot['Çok İyi'].toString()),
                        Text(documentSnapshot['İyi'].toString()),
                        Text(documentSnapshot['Orta'].toString()),
                        Text(documentSnapshot['Kötü'].toString()),
                        Text(documentSnapshot['Çok Kötü'].toString()),

                        //Text(documentSnapshot['voteno'].toString())
                      ],
                    ), //Text(documentSnapshot['vote'].toString()),
                    trailing: SizedBox(
                      width: 250,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // Add new product
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
