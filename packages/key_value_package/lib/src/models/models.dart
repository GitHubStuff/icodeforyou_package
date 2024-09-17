import 'dart:async';

abstract class KeyValueAbstract {
  FutureOr<bool> setUp({required String subDir, required String containerName});
  FutureOr<T?> get<T>({required String key, T? defaultValue});
  FutureOr<void> put<T>({required String key, required T value});
}
