import 'package:equatable/equatable.dart';

class SearchFood extends Equatable {
  final String nameFood;
  const SearchFood({required this.nameFood});
  factory SearchFood.fromJson(Map<String, dynamic> json) {
    return SearchFood(nameFood: json['nameFood']);
  }
  @override
  List<Object?> get props => [nameFood];
}
