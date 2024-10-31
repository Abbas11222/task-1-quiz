import 'package:flutter/material.dart';
import 'DBhelper.dart';
import 'model.dart';

class ManageFlashcards extends StatefulWidget {
  const ManageFlashcards({super.key});

  @override
  State<ManageFlashcards> createState() => _ManageFlashcardsState();
}

class _ManageFlashcardsState extends State<ManageFlashcards> {
  List<User> flashcards = [];
  final Dbhelper dbHelper = Dbhelper();

  @override
  void initState() {
    super.initState();
    _loadFlashcards(); // Load flashcards when the page initializes
  }

  // Load flashcards from the database
  Future<void> _loadFlashcards() async {
    final List<dynamic> tasks = await dbHelper.getAlltasks();
    setState(() {
      flashcards = tasks.map((task) => User.fromMap(task)).toList(); // Convert to User objects
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Flashcards"),
        backgroundColor: const Color.fromARGB(240, 190, 158, 115),
      ),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index){
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(flashcards[index].question),
              subtitle: Text(flashcards[index].answer),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Call the edit function with the selected flashcard
                      _editFlashcard(flashcards[index]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteFlashcard(flashcards[index].id!); // Delete flashcard
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a page to add a new flashcard
          _addFlashcard();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to delete a flashcard
  Future<void> _deleteFlashcard(int id) async {
    await dbHelper.deletebyid(id);
    _loadFlashcards(); // Reload flashcards after deletion
  }

  // Function to edit a flashcard
  void _editFlashcard(User user) {
    TextEditingController questionController = TextEditingController(text: user.question);
    TextEditingController answerController = TextEditingController(text: user.answer);
    // Get the current id from the user
    int? currentId = user.id; // Store the current ID in a local variable
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Flashcard"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: "Question"),
                ),
                const SizedBox(height: 10), // Add spacing
                TextField(
                  controller: answerController,
                  decoration: const InputDecoration(labelText: "Answer"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                User updatedUser = User(questionController.text, answerController.text);
                dbHelper.updatetask(User.fromMap({
                  'id': currentId,
                  'question': questionController.text,
                  'answer': answerController.text,
                }));

                Navigator.pop(context);
                _loadFlashcards(); // Reload flashcards
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Function to add a new flashcard
  void _addFlashcard() {
    TextEditingController questionController = TextEditingController();
    TextEditingController answerController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Flashcard"),
          content: SingleChildScrollView( // Use SingleChildScrollView for better scrolling
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: "Question"),
                ),
                const SizedBox(height: 10), // Add spacing
                TextField(
                  controller: answerController,
                  decoration: const InputDecoration(labelText: "Answer"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                User newUser = User(questionController.text, answerController.text);
                dbHelper.savetask(newUser); // Save the new flashcard to the database
                Navigator.pop(context);
                _loadFlashcards(); // Reload flashcards
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
