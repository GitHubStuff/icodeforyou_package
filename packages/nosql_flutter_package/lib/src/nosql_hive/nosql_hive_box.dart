import 'dart:async' show FutureOr;
import 'package:hive_ce/hive.dart' show Box;
import 'package:nosql_flutter_package/src/nosql_abstract/nosql_box.dart'
    show NoSqlBox;

class NoSqlHiveBox<T> extends NoSqlBox<T> {
  NoSqlHiveBox(this._box);

  final Box<T> _box;

  @override
  FutureOr<T?> get(dynamic key, {T? defaultValue}) {
    try {
      return _box.get(key, defaultValue: defaultValue);
    } on Object catch (_) {
      return null;
    }
  }

  @override
  FutureOr<bool> put(dynamic key, T value) async {
    try {
      await _box.put(key, value);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  void close() => _box.close();
}
