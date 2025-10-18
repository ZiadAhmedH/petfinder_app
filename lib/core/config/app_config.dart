import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static final String apiVersion = dotenv.env['API_VERSION'] ?? '';
  static final String apiKey = dotenv.env['CAT_API_KEY'] ?? '';
  static String get endpoint => '$baseUrl$apiVersion/';
}
