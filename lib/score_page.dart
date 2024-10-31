import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int total;

  const ScorePage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Score"),
        backgroundColor: const Color.fromARGB(240, 190, 158, 115),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Quiz Complete!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Your Score: $score / $total",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Go back to the home page or quiz page
                Navigator.pop(context);
              },
              child: const Text("Return to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
