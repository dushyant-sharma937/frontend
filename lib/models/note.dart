class Note {
  String? id; // Unique identifier for the note
  String? userid; // User ID associated with the note
  String? title; // Title of the note
  String? content; // Content/body of the note
  DateTime? dateAdded; // Date and time when the note was added

  // Constructor for the Note class
  Note({this.id, this.userid, this.title, this.content, this.dateAdded});

  // Factory method to create a Note object from a map (JSON data from the backend)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map[
          "id"], // Assigning the 'id' field from the map to the 'id' property of the Note object
      userid: map[
          "userid"], // Assigning the 'userid' field from the map to the 'userid' property of the Note object
      title: map[
          "title"], // Assigning the 'title' field from the map to the 'title' property of the Note object
      content: map[
          "content"], // Assigning the 'content' field from the map to the 'content' property of the Note object
      dateAdded: DateTime.tryParse(map[
          "dateAdded"]), // Parsing the 'dateAdded' field as a DateTime and assigning it to the 'dateAdded' property of the Note object
    );
  }

  // Method to convert a Note object to a map (JSON format)
  Map<String, dynamic> toMap() {
    return {
      "id": id, // Adding the 'id' property to the map with key "id"
      "userid":
          userid, // Adding the 'userid' property to the map with key "userid"
      "title": title, // Adding the 'title' property to the map with key "title"
      "content":
          content, // Adding the 'content' property to the map with key "content"
      "dateAdded": dateAdded!
          .toIso8601String(), // Converting the 'dateAdded' DateTime to ISO 8601 format (string) and adding it to the map with key "dateAdded"
    };
  }
}
