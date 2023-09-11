import 'dart:convert';
import 'dart:developer';

import '../models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      "https://notes-app-backend-oi5d.onrender.com/notes";

  // Method to add a new Note to the server
  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded =
        jsonDecode(response.body); // Parse the response body from JSON to Map
    log(decoded.toString()); // Print the decoded JSON for debugging purposes
  }

  // Method to delete a Note from the server
  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded =
        jsonDecode(response.body); // Parse the response body from JSON to Map
    log(decoded.toString()); // Print the decoded JSON for debugging purposes
  }

  // Method to fetch a list of Notes from the server for a given userid
  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse("$_baseUrl/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded =
        jsonDecode(response.body); // Parse the response body from JSON to Map
    log(decoded.toString()); // Print the decoded JSON for debugging purposes

    List<Note> notes = [];
    for (var notemap in decoded) {
      Note newNote =
          Note.fromMap(notemap); // Convert each map into a Note object
      notes.add(newNote); // Add the Note object to the list
    }

    return notes; // Return the list of Notes fetched from the server
  }
}
