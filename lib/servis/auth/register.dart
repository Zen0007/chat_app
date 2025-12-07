import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> register(Map<String, String> data) async {
  final res = await http.post(
    Uri.parse("http://localhost:8080/register"),
    body: json.encode(data),
  );

  if (res.statusCode == 200) {
    final decodeData = jsonDecode(res.body);
    final box = await Hive.openBox('auth');
    box.put("profile", decodeData["Success"]);
    print("${box.get("profile")}");
    return {
      "success": "success register",
    };
  } else {
    final decodeData = jsonDecode(res.body);
    return {
      "error": decodeData["Error"],
    };
  }
}
