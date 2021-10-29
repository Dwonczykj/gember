import 'package:equatable/equatable.dart';

class EnvironmentalImpact extends Equatable {
  final double carbonCost;

  EnvironmentalImpact({required this.carbonCost});

  List<Object?> get props => [carbonCost];

  factory EnvironmentalImpact.fromJson(Map<String, dynamic> json) =>
      EnvironmentalImpact(carbonCost: json['carbonCost'] ?? 0.0);
}
