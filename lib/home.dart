import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication/savedNote.dart';

class DataStore extends StatefulWidget {
  const DataStore({super.key});

  @override
  State<DataStore> createState() => _DataStoreState();
}

class _DataStoreState extends State<DataStore> {
  TextEditingController noteController = TextEditingController();

  void saveNoteToFirestore() async {
    String note = noteController.text.trim();
    if (note.isNotEmpty) {
      var documentReference = await FirebaseFirestore.instance.collection("notes").add({
        "note": note,
        "timestamp": Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Note saved successfully")),
      );

      noteController.clear(); // Clear field after saving
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Note is empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Add Note", style: TextStyle(color: Colors.black)),

              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Note", style: TextStyle(fontSize: 18)),
                  TextField(
                    controller: noteController,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your note",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveNoteToFirestore,

                    child: Text("Save in FireStore"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowNotesPage()),
                      );
                    },
                    child: Text("View Saved Notes"),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
