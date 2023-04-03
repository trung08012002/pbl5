import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl5/bloc/state/food_search_state.dart';

import '../../model/repository/food_repository.dart';

class FoodSearchBloc extends Cubit<FoodSearchState> {
  FoodSearchBloc({required this.repository}) : super(const FoodSearchState());
  final FoodRepository repository;
  Future<void> searchShopNameFood() async {}
}
