import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class NetworkRepository {
  final apiKey = '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';
  Future<Either<String, dynamic>> post(String url, {required Map body}) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: json.encode(body));
      if (response.statusCode == 200) {
        return right(json.decode(response.body));
      }

      return left('Failed to get a response');
    } catch (ex) {
      return left('Something went wrong');
    }
  }
}
