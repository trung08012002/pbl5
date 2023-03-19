import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photo;

  const User({required this.id, this.email, this.name, this.photo});
  @override
  List<Object?> get props => [id];
  static const empty = User(id: "");
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
}
