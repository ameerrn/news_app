import 'dart:convert';
import '../../constant/categories.dart';
import '../data_provider/news_api_data.dart';
import '../models/articel.dart';
import '../models/articels.dart';

class RepositoryNewsApi {
  Future<List<Articel>> fetchAndStoreArticels(
      String country, String category) async {
    final response = await NewsApiData().fetchArticals(country, category);
    final jsonData = jsonDecode(response);
    Articels articels = Articels.fromJson(jsonData);
    List<Articel> listArticels =
        articels.articels.map((e) => Articel.fromJson(e)).toList();
    for (int i = 0; i < listArticels.length; i++) {
      listArticels[i].id = i;
      listArticels[i].countryData =
          countriesData.firstWhere((element) => element['code'] == country);
      listArticels[i].category = category;
    }

    return listArticels;
  }
}
