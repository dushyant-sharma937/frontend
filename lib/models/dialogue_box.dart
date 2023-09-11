import 'package:flutter/material.dart';

import '../providers/notes_provider.dart';
import 'note.dart';

// Function to display a dialog box for confirming note deletion
Future<dynamic> DialogueBox(
    BuildContext context, NotesProvider notesProvider, Note currentNote) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // Title of the dialog box
      title: const Text(
        "Delete Note",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      // Content of the dialog box, asking for confirmation
      content: const Text(
        "Are you sure you want to delete this note?",
        style: TextStyle(fontSize: 18),
      ),
      // Actions (buttons) to be displayed at the bottom of the dialog box
      actions: <Widget>[
        // Button for canceling the delete operation
        TextButton(
          onPressed: () {
            // Close the dialog box without doing anything (cancel)
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            color: null,
            // Text for the cancel button
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ),
        ),
        // Button for confirming the delete operation
        TextButton(
          onPressed: () {
            // Call the 'deleteNote' method of the 'NotesProvider' to delete the note
            notesProvider.deleteNote(currentNote);
            // Close the dialog box after the note is deleted
            Navigator.of(context).pop();
          },
          child: Container(
            color: null,
            padding: const EdgeInsets.all(14),
            // Text for the confirmation button
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
