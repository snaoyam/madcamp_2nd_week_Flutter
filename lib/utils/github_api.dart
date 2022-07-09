import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GithubApi {
  
  Map<String, String?> parse(String url) {
    Uri url_parse = Uri.parse(url);
    List<String> url_list = url_parse.path.split('/');
    if(url_parse.host.split('.').reversed.elementAt(1) == 'github') {
      return {'username': url_list.elementAt(1), 'repository': url_list.elementAt(2)};
    }
    else return {'username': null, 'repository': null};
  }

  contributors(String url) async {
    await dotenv.load();
    Map<String, String?> _parse = parse(url);
    if(!_parse.values.contains(null)) {
      String _username = _parse['username']!;
      String _repository = _parse['repository']!;
      String? _githubToken = dotenv.env['GITHUBTOKEN'];
      http.Response response = await http.get(
        Uri.parse('https://api.github.com/repos/$_username/$_repository/contributors'),
        headers: <String, String> { 'Content-Type': 'application/json', 'Authorization': 'token $_githubToken',}, 
      ).timeout(const Duration(seconds: 5), onTimeout: () { return http.Response('Error', 408); }); //!
      return json.decode(response.body);
    }
    
  }

}