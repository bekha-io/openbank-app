import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Money {
  final double amount;
  final String currency;

  Money({required this.amount, required this.currency});
}
