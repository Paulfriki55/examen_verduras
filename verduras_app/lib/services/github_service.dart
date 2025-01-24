import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verdura.dart';
import '../config/app_config.dart';

class GithubService {
  final String _baseUrl = 'https://api.github.com/repos/Paulfriki55/examen_verduras/contents/Verduras.json';
  // Elimina el final String _token, ahora se accede desde AppConfig
  Future<List<Verdura>> getVerduras() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'Authorization': 'token ${AppConfig.getGitHubToken()}'},
    );

    if (response.statusCode == 200) {
      final jsonContent = json.decode(utf8.decode(base64.decode(json.decode(response.body)['content'])));
      return (jsonContent as List).map((item) => Verdura.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load verduras');
    }
  }

  Future<void> updateVerduras(List<Verdura> verduras) async {
    final content = json.encode(verduras.map((v) => v.toJson()).toList());
    final encodedContent = base64Encode(utf8.encode(content));

    final currentFile = await http.get(Uri.parse(_baseUrl), headers: {'Authorization': 'token ${AppConfig.getGitHubToken()}'});
    final sha = json.decode(currentFile.body)['sha'];

    final response = await http.put(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'token ${AppConfig.getGitHubToken()}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'message': 'Update verduras',
        'content': encodedContent,
        'sha': sha,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update verduras');
    }
  }
}