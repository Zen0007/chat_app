import 'package:hive/hive.dart';

Stream<bool> verify() async* {
  final box = await Hive.openBox("auth");
  final isLogin = box.get("profile");
  print("islogin $isLogin");

  yield isLogin != null;
}
