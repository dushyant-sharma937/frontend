import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/consts/colors.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:frontend/screens/add_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../auth/auth_controller.dart';
import '../models/dialogue_box.dart';
import '../models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to store the search query entered by the user
  String searchQuery = "";
  // FocusNode to handle the focus of the search TextField
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Get the instance of NotesProvider using Provider.of
    var controller = Get.put(AuthController());
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Notes App"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: buttonColor,
            ),
            onPressed: () => controller.signOut(context: context),
          )
        ],
      ),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: (notesProvider.notes.isNotEmpty)
                  ? GestureDetector(
                      onTap: () {
                        // Function to unfocus the search TextField when tapped outside
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: ListView(children: [
                        // Search TextField for filtering notes
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            onChanged: (value) {
                              // Update the search query when the user types in the TextField
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            style: const TextStyle(color: fontwhite),
                            cursorColor: fontwhite,
                            decoration: const InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: fontwhite),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: fontGrey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: fontwhite)),
                            ),
                          ),
                        ),
                        // Display notes in a GridView
                        (notesProvider.getFilteredNotes(searchQuery).isNotEmpty)
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: notesProvider
                                    .getFilteredNotes(searchQuery)
                                    .length,
                                itemBuilder: (context, index) {
                                  // Get the current note from the filtered notes list
                                  Note currentNote = notesProvider
                                      .getFilteredNotes(searchQuery)[index];
                                  return GestureDetector(
                                    onLongPress: () {
                                      // Show a dialogue box when the note is long-pressed
                                      DialogueBox(
                                          context, notesProvider, currentNote);
                                    },
                                    onTap: () {
                                      // Navigate to the AddScreen when the note is tapped
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) {
                                        return AddScreen(
                                          isUpdate: true,
                                          note: currentNote,
                                        );
                                      }));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: tileColor,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.black54,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Display note title
                                            Text(
                                              currentNote.title!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                                color: fontwhite,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            // Display note content
                                            Text(
                                              currentNote.content!,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                color: fontGrey,
                                              ),
                                              maxLines: 7,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "No notes found!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: fontwhite,
                                  ),
                                ),
                              ),
                      ]),
                    )
                  : const Center(
                      child: Text(
                        "No notes yet! Try adding some...",
                        style: TextStyle(
                          fontSize: 18,
                          color: fontwhite,
                        ),
                      ),
                    ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: buttonColor,
              ),
            ),
      // Floating action button for adding a new note
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          // Navigate to the AddScreen when the button is pressed
          Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => AddScreen(
                      isUpdate: false,
                    )),
          );
        },
        child: const Icon(
          Icons.add,
          color: fontwhite,
        ),
      ),
    );
  }
}
