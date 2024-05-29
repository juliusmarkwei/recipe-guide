import 'package:recipies_app/models/recipe.dart';
import 'package:recipies_app/services/http_service.dart';

class DataService {
  static final DataService _dataService = DataService._internal();

  factory DataService() {
    return _dataService;
  }

  DataService._internal();

  final HTTPService _httpService = HTTPService();

  Future<List<Recipe>?> getRecipes(String filter) async {
    String path = 'recipes/';
    if (filter.isNotEmpty) path += 'meal-type/$filter';

    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data['recipes'];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();

      return recipes;
    }
    return null;
  }
}
