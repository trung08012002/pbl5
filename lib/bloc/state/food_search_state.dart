import 'package:equatable/equatable.dart';
import 'package:pbl5/model/data/search_food.dart';

enum FoodSearchStatus { empty, loading, loaded, error }

class FoodSearchState extends Equatable {
  final List<SearchFood> listFood;
  final FoodSearchStatus status;
  const FoodSearchState(
      {this.listFood = const [], this.status = FoodSearchStatus.empty});
  FoodSearchState copywith({
    List<SearchFood>? listFood,
    FoodSearchStatus? status,
  }) =>
      FoodSearchState(
          listFood: listFood ?? this.listFood, status: status ?? this.status);
  @override
  List<Object?> get props => [listFood, status];
}
