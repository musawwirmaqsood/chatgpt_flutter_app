import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<String, String>> fetchResponses(question);
}
