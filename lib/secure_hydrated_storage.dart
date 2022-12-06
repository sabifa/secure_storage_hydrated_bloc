import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SecureHydratedStorage implements Storage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked_this_device,
    ),
  );

  late final Map<String, String> _storageCache;

  SecureHydratedStorage();

  Future<void> initialize() async {
    _storageCache = await _secureStorage.readAll();
  }

  @override
  Future<void> clear() async {
    _storageCache.clear();
    await _secureStorage.deleteAll();
  }

  @override
  Future<void> delete(String key) async {
    _storageCache.remove(key);
    await _secureStorage.delete(key: key);
  }

  @override
  dynamic read(String key) {
    final value = _storageCache[key];
    return value != null ? json.decode(value) : null;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    final encodedValue = json.encode(value);
    _storageCache[key] = encodedValue;
    await _secureStorage.write(key: key, value: encodedValue);
  }
}
