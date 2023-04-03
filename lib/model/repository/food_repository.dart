import 'package:pbl5/model/data/search_food.dart';

import '../services/network/food_network_services.dart';

class FoodRepository {
  final FoodNetworkServices networkFood;
  FoodRepository({required this.networkFood});
  Future<List<SearchFood>> getAllSearchFood() async {
    final foodSearchRaw =
        await networkFood.getResponse('getallfoodsearch', null);
    List<SearchFood> searchfood =
        foodSearchRaw.map((json) => SearchFood.fromJson(json)).toList();
    return searchfood;
  }

  Future<void> insertSearchFood(SearchFood searchFood) async {
    final isHad = await networkFood.getResponse(
                'getfoodsearch', {'name_food': searchFood.nameFood}) ==
            null
        ? false
        : true;
    if (isHad == false) {}
  }
}
