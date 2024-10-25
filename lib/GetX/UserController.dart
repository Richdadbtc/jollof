import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserController extends GetxController {
  final _storage = FlutterSecureStorage();
  final Rx<String?> _email = Rx<String?>(null);

  String? get email => _email.value;

  @override
  void onInit() {
    super.onInit();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    _email.value = await _storage.read(key: 'user_email');
  }

  Future<void> setEmail(String email) async {
    await _storage.write(key: 'user_email', value: email);
    _email.value = email;
  }

  Future<void> clearEmail() async {
    await _storage.delete(key: 'user_email');
    _email.value = null;
  }
}