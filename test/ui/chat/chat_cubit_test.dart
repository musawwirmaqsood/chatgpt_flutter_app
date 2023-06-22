import 'package:bloc_test/bloc_test.dart';
import 'package:chatgpt_flutter_app/domain/chat_repositiory.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_cubit.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_event.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements ChatRepository {}

void main() {
  late ChatRepository mockRepository;
  late ChatBloc chatBloc;
  setUp(() {
    mockRepository = MockRepository();
    chatBloc = ChatBloc(mockRepository);
  });
  group('ChatBloc', () {
    const String testQuestion = 'What is flutter?';

    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, ChatSuccess] when'
      'SubmitQuestion is called successfully.',
      setUp: () {
        when(() => mockRepository.fetchResponses(testQuestion))
            .thenAnswer((_) async => right('success'));
      },
      build: () => chatBloc,
      act: (bloc) => bloc.add(const SubmitQuestion(testQuestion)),
      expect: () => <ChatState>[ChatLoading(), const ChatSuccess('success')],
    );

    blocTest<ChatBloc, ChatState>(
      'emits [ChatLoading, ChatFailure] when'
      'SubmitQuestion is faield',
      setUp: () {
        when(() => mockRepository.fetchResponses(testQuestion))
            .thenAnswer((_) async => left('failure'));
      },
      build: () => chatBloc,
      act: (bloc) => bloc.add(const SubmitQuestion(testQuestion)),
      expect: () => <ChatState>[ChatLoading(), const ChatFailure('failure')],
    );
  });
}
