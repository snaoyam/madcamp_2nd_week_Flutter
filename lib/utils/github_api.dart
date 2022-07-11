import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GithubApi {
  
  Map<String, String?> parse(String url) {
    String checkurl = url;
    if(!checkurl.startsWith('http')) {
      checkurl = 'https://' + checkurl;
    }
    Uri urlParse = Uri.parse(checkurl);
    List<String> url_list = urlParse.path.split('/');
    if(url_list.length > 2 && urlParse.host.endsWith('github.com')) {
      return {'username': url_list.elementAt(1), 'repository': url_list.elementAt(2)};
    }
    else return {'username': '', 'repository': ''};
  }

  contributors(String url) async {
    await dotenv.load();
    Map<String, dynamic> _parse = parse(url);
    if(!_parse.values.contains(null)) {
      String _username = _parse['username']!;
      String _repository = _parse['repository']!;
      String? _githubToken = dotenv.env['GITHUBTOKEN'];
      http.Response response = await http.get(
        Uri.parse('https://api.github.com/repos/$_username/$_repository/contributors'),
        headers: <String, String> { 'Content-Type': 'application/json', 'Authorization': 'token $_githubToken',}, 
      ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); }); //!
      if(response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      }
      else {
        return [];
      }
    }
  }

  projectInfo(String url, String? name, String? description) async {
    name ??= '';
    description ??= '';

    if(name == '' || description == '') {
      await dotenv.load();
      Map<String, String?> _parse = parse(url);
      if(!_parse.values.contains(null)) {
        String _username = _parse['username']!;
        String _repository = _parse['repository']!;
        String? _githubToken = dotenv.env['GITHUBTOKEN'];
        http.Response response = await http.get(
          Uri.parse('https://api.github.com/repos/$_username/$_repository'),
          headers: <String, String> { 'Content-Type': 'application/json', 'Authorization': 'token $_githubToken',}, 
        ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); }); //!
        print(response.statusCode);
        if(response.statusCode >= 200 && response.statusCode < 300) {
          //print(name);
          print({'name': name == '' ? (json.decode(response.body)['name'] ?? '') : name, 'description': description == '' ? (json.decode(response.body)['description'] ?? '') : description});
          return {'name': name == '' ? (json.decode(response.body)['name'] ?? '') : name, 'description': description == '' ? (json.decode(response.body)['description'] ?? '') : description};
        }
        else {
          return {'name': name, 'description': description};
        }
      }
    }
    else {
      return {'name': name, 'description': description};
    }
  }

  rawReadme(String url) async {
    await dotenv.load();
    Map<String, String?> _parse = parse(url);
    if(!_parse.values.contains(null)) {
      String _username = _parse['username']!;
      String _repository = _parse['repository']!;
      String? _githubToken = dotenv.env['GITHUBTOKEN'];
      http.Response response = await http.get(
        Uri.parse('https://api.github.com/repos/$_username/$_repository/contents/'),
        headers: <String, String> { 'Content-Type': 'application/json', 'Authorization': 'token $_githubToken',}, 
      ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); });
      if(response.statusCode >= 200 && response.statusCode < 300 && json.decode(response.body) is List) {
       return (json.decode(response.body) as List).firstWhere((element) => element['name'] == 'README.md', orElse: () => {'download_url', ''})['download_url'];
      }
    }
    return '';
  }
}