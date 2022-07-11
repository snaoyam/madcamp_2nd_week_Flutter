import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
void main() async {
  var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/post/new'));
  request.fields.addAll({
    'asad': '123'
  });
  request.files.add(await http.MultipartFile.fromPath('image', '/Users/vm/Downloads/dOsbV.png'));
  request.files.add(await http.MultipartFile.fromPath('image', '/Users/vm/Pictures/고양이.jpg'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}