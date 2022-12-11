import 'package:http/http.dart' as http;

class NewsApiData {
  final String key = 'bb4dbfdf19fe42c2bbb0bdc5a29b1c2f';
  Future<String> fetchArticals(String country, String category) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$key'),
    );

    return response.body;
  }
}
