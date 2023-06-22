import 'package:chatgpt_flutter_app/data/chatgpt_api_repositiory.dart';
import 'package:chatgpt_flutter_app/domain/chat_repositiory.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_cubit.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'network/network_repositiory.dart';

final getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<NetworkRepository>(NetworkRepository());
  getIt.registerSingleton<ChatRepository>(ChatGPTApiRepository(getIt()));
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ChatBloc(getIt()),
    ),
  ], child: const ChatGPTApp()));
}

class ChatGPTApp extends StatelessWidget {
  const ChatGPTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: ChatScreen(),
    );
  }
}
