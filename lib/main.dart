import 'package:flutter/material.dart';
import 'quizpage.dart';
import 'manage_flashcards.dart';

void main() {
  runApp(const MaterialApp(
    title: "Flashcard Quiz",
    debugShowCheckedModeBanner: false,
    home: FlashcardHome(),
  ));
}

class FlashcardHome extends StatelessWidget {
  const FlashcardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(backgroundImage: AssetImage("image/image1.jpeg")),
        title: const Text(
          "Flashcard Quiz",
          style: TextStyle(
            fontSize: 18.3,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(240, 190, 158, 115),
      ),
      body: Container(
        color: const Color.fromRGBO(87, 99, 100, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManageFlashcards()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Manage Flashcards",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
