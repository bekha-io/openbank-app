import 'dart:async';

import 'package:openbankapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> authenticate(String phoneNumber) async {
  print(phoneNumber);
  var resp =
      await dio.post("/auth", data: {"phone_number": "971${phoneNumber}"});

  if (resp.statusCode != 200) {
    throw Exception(resp.data["error"]);
  }

  var sp = await SharedPreferences.getInstance();
  sp.setString("token", resp.data["token"]);

  return resp.data["token"] as String;
}
