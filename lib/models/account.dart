import 'package:json_annotation/json_annotation.dart';
import 'package:openbankapp/models/money.dart';

@JsonSerializable()
class Account {
  final String id;
  final Money balance;

  const Account({required this.id, required this.balance});
}
