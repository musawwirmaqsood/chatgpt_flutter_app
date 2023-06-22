import 'package:flutter/material.dart';

class AnswerScreen extends StatelessWidget {
  final String question;
  final String response;

  const AnswerScreen(
      {super.key, required this.question, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT - Response'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Question:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(question),
            const SizedBox(height: 16.0),
            const Text(
              'Response:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(response),
          ],
        ),
      ),
    );
  }
}
