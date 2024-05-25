import 'package:dio/dio.dart';
import 'package:openbankapp/api/api.dart';
import 'package:openbankapp/models/account.dart';
import 'package:openbankapp/models/money.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Account>> getAccounts() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");

  if (token == null) {
    throw Exception("Not authenticated");
  }

  final resp = await dio.get("/accounts",
      options: Options(headers: {
        "Authorization": "Bearer " + token as String,
      }));
  if (resp.statusCode != 200) {
    throw Exception(resp.data["error"]);
  }

  return (resp.data["accounts"] as List)
      .map((e) => Account(
          id: e["id"],
          balance: Money(
              amount: (e["balance"]["amount"] as num).toDouble(),
              currency: e["balance"]["currency"])))
      .toList();
}
