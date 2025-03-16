import 'dart:async' show FutureOr;

abstract class NoSqlBox<T> {
  FutureOr<bool> put(dynamic key, T value);
  FutureOr<T?> get(dynamic key, {T? defaultValue});
  FutureOr<void> close();
}
