// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/consts/colors.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';

class AddScreen extends StatefulWidget {
  bool isUpdate;
  Note? note;
  AddScreen({super.key, required this.isUpdate, this.note});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // Function to add a new note to the NotesProvider
  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(), // Generate a new unique ID for the note
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      userid: FirebaseAuth.instance.currentUser!.email
          .toString(), // Assuming a hardcoded user ID for now
      dateAdded:
          DateTime.now(), // Set the current date and time as the 'dateAdded'
    );

    // Add the new note to the NotesProvider using the 'addNote' method
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(
        context); // Go back to the previous screen after adding the note
  }

  // Function to update an existing note in the NotesProvider
  void updateNote() {
    // Update the properties of the existing note with the new values
    widget.note!.title = titleController.text.trim();
    widget.note!.content = contentController.text.trim();
    widget.note!.dateAdded = DateTime.now();

    // Update the note in the NotesProvider using the 'updateNote' method
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(
        context); // Go back to the previous screen after updating the note
  }

  @override
  void initState() {
    super.initState();
    // If the widget is used for updating a note, prefill the text fields with existing values
    if (widget.isUpdate == true) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  FocusNode noteFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Create notes",
          style: TextStyle(color: fontwhite),
        ),
        foregroundColor: buttonColor,
        actions: [
          IconButton(
            onPressed: () {
              // When the user clicks the check icon in the app bar
              if (widget.isUpdate == true) {
                // If it's an update, call the 'updateNote' function
                updateNote();
              } else {
                // If it's a new note, call the 'addNewNote' function
                addNewNote();
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                // If it's an update, autofocus is set to false; otherwise, set it to true to focus on the title field initially
                autofocus: widget.isUpdate ? false : true,
                onSubmitted: (val) {
                  // When the user submits the title field, move focus to the content field if the title is not empty
                  if (val != "") {
                    noteFocus.requestFocus();
                  }
                },
                cursorColor: fontwhite,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: fontwhite),
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(color: fontwhite, fontWeight: FontWeight.w500),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: fontGrey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: fontwhite)),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  style: const TextStyle(
                    fontSize: 18,
                    color: fontGreyLight,
                  ),
                  cursorColor: fontwhite,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Write your Content",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: fontGrey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
