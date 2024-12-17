import 'package:dio/dio.dart';

Future<Map<String, dynamic>> httpClient(Uri uri) async {
  final baseOptions = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 5000,
    contentType: 'application/json',
    responseType: ResponseType.json,
  );
  final client = Dio(baseOptions);
  final Response<Map<String, dynamic>> response = await client.getUri(uri);
  if (response.statusCode != 200) {
    throw 'Request failed with status: ${response.statusCode}';
  }
  final jsonResponse = response.data!;
  String error = jsonResponse['error_message'] ?? '';
  if (error.isNotEmpty) throw 'GCP error: $error';
  return jsonResponse;
}
