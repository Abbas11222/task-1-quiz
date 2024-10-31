import 'package:flutter/material.dart';
import 'DBhelper.dart';
import 'model.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<User> flashcards = [];
  final Dbhelper dbHelper = Dbhelper();
  int currentIndex = 0;
  Map<int, String> userAnswers = {};
  int score = 0;

  TextEditingController answerController = TextEditingController();

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
        title: const Text("Quiz"),
        backgroundColor: const Color.fromARGB(240, 190, 158, 115),
      ),
      body: flashcards.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner if no flashcards
          : Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Question ${currentIndex + 1} of ${flashcards.length}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              flashcards[currentIndex].question, // Display current question
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: answerController,
              decoration: const InputDecoration(
                labelText: "Your Answer",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed:(){
              _submitAnswer();
              } ,
            child: const Text("Submit Answer"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _submitAnswer() {
    String userAnswer = answerController.text.trim();
    if (userAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter an answer")),
      );
      return;
    }

    void _showSnackBar(BuildContext context) {
      String? snake;
      if (userAnswer.toLowerCase() == flashcards[currentIndex].answer.toLowerCase()) {
        snake="correct";
      }else{
        snake="Wrong answer";
      }
      final snackBar = SnackBar(
        content: Text(snake),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    userAnswers[currentIndex] = userAnswer;

    // Check if the user's answer is correct
    if (userAnswer.toLowerCase() == flashcards[currentIndex].answer.toLowerCase()) {
      score++; // Increment score if correct
    }

    // Move to the next question or show the final score if the quiz is complete
    if (currentIndex < flashcards.length - 1) {
      setState(() {
        currentIndex++;
        answerController.clear(); // Clear the input for the next question
      });
    } else {
      // Navigate to the score page when the quiz is complete
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(score: score, total: flashcards.length),
        ),
      );
    }
  }
}
