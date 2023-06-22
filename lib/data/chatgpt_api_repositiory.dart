
import 'package:chatgpt_flutter_app/domain/chat_repositiory.dart';
import 'package:chatgpt_flutter_app/network/network_repositiory.dart';
import 'package:dartz/dartz.dart';

class ChatGPTApiRepository implements ChatRepository {
  final NetworkRepository _networkRepository;

  ChatGPTApiRepository(this._networkRepository);

  @override
  Future<Either<String, String>> fetchResponses(question) {
    const apiUrl = 'https://api.openai.com/v1/chat/completions';
    return _networkRepository.post(
      apiUrl,
      body: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": question}
        ],
        "temperature": 0,
        "stream": false
      },
    ).then(
      (value) => value.fold(
        (error) => left(error),
        (response) {
          final choices = response['choices'];
          if (choices.isNotEmpty) {
            final answer = choices[0]['message']['content'].toString();
            return right(answer);
          } else {
            return left('Response not found');
          }
        },
      ),
    );
  }
 
}
