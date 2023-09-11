import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services.dart/api_services.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading =
      true; // A boolean flag to indicate if notes are still loading
  List<Note> notes = []; // A list to store all the notes
  // Constructor of NotesProvider
  NotesProvider() {
    fetchNotes(); // Call the fetchNotes() method when the NotesProvider instance is created
  }

  // Function to sort the notes based on their dateAdded in descending order
  void sortNodes() {
    notes.sort(
      (a, b) => b.dateAdded!.compareTo(a.dateAdded!),
    );
  }

  // Function to add a new note to the notes list
  void addNote(Note note) {
    notes.add(note); // Add the new note to the list
    sortNodes(); // Sort the notes after adding the new note
    notifyListeners(); // Notify all the listeners (widgets) that the data has changed
    ApiService.addNote(
        note); // Call the API service to add the new note to the backend
  }

  // Function to update an existing note in the notes list
  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note; // Update the note in the list with the new data
    sortNodes(); // Sort the notes after updating the note
    notifyListeners(); // Notify all the listeners (widgets) that the data has changed
    ApiService.addNote(
        note); // Call the API service to update the note in the backend
  }

  // Function to delete a note from the notes list
  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote); // Remove the note from the list
    notifyListeners(); // Notify all the listeners (widgets) that the data has changed
    ApiService.deleteNote(
        note); // Call the API service to delete the note from the backend
  }

  // Function to fetch notes from the backend
  Future<void> fetchNotes() async {
    String email = FirebaseAuth.instance.currentUser!.email.toString();
    notes = await ApiService.fetchNotes(email); // Fetch notes from the backend
    sortNodes(); // Sort the notes after fetching them
    isLoading = false; // Set isLoading to false as notes are fetched
    notifyListeners(); // Notify all the listeners (widgets) that the data has changed
  }

  // Function to filter notes based on a search query
  List<Note> getFilteredNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
