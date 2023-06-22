import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SubmitQuestion extends ChatEvent {
  final String question;

  const SubmitQuestion(this.question);

  @override
  List<Object> get props => [question];
}
