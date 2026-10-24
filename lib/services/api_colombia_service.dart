import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../config/endpoints.dart';
import '../models/api_item.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiColombiaService {
  final http.Client _client;
  ApiColombiaService({http.Client? client}) : _client = client ?? http.Client();

  String get _base => dotenv.env['API_BASE_URL'] ?? '';

  Future<List<ApiItem>> fetchAll(EndpointConfig endpoint) async {
    final data = await _get('$_base/${endpoint.path}');
    if (data is! List) throw ApiException('Formato de respuesta inesperado');
    return data
        .map((e) => endpoint.parser(e as Map<String, dynamic>))
        .toList();
  }

  Future<ApiItem> fetchById(EndpointConfig endpoint, int id) async {
    final data = await _get('$_base/${endpoint.path}/$id');
    if (data is! Map<String, dynamic>) {
      throw ApiException('Formato de respuesta inesperado');
    }
    return endpoint.parser(data);
  }

  Future<dynamic> _get(String url) async {
    try {
      final res = await _client
          .get(Uri.parse(url), headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 15));

      if (res.statusCode == 200) {
        return jsonDecode(utf8.decode(res.bodyBytes));
      } else if (res.statusCode == 404) {
        throw ApiException('Recurso no encontrado', 404);
      } else if (res.statusCode >= 500) {
        throw ApiException('Error del servidor (${res.statusCode})', res.statusCode);
      } else {
        throw ApiException('Error inesperado (${res.statusCode})', res.statusCode);
      }
    } on SocketException {
      throw ApiException('Sin conexión a internet');
    } on TimeoutException {
      throw ApiException('La solicitud tardó demasiado');
    } on FormatException {
      throw ApiException('Respuesta con formato inválido');
    } on http.ClientException {
      throw ApiException('No se pudo conectar con el servidor');
    }
  }
}