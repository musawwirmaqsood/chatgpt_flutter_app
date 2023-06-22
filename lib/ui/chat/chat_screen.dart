import 'package:chatgpt_flutter_app/ui/chat/answer_screen.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_cubit.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_event.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();

  ChatScreen({super.key});

  String parseResponse(String data) {
    List<String> splitData = data.split('data: ');

    return splitData[1];
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter your question',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final question = _inputController.text;

                chatBloc.add(SubmitQuestion(question));
              },
              child: const Text('Submit'),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  final question = _inputController.text;
                  _inputController.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnswerScreen(
                              question: question, response: state.response)));
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ChatSuccess) {
                  return Container();
                } else if (state is ChatFailure) {
                  return const Text('Failed to get a response');
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
