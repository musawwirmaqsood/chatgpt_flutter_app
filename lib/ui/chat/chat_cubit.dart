import 'package:chatgpt_flutter_app/domain/chat_repositiory.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_event.dart';
import 'package:chatgpt_flutter_app/ui/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<SubmitQuestion>((event, emit) async {
      emit(ChatLoading());
      final response = await chatRepository.fetchResponses(event.question);
      response.fold(
        (error) {
          emit(ChatFailure(error));
        },
        (data) {
          emit(ChatSuccess(data));
        },
      );
    });
  }
}
