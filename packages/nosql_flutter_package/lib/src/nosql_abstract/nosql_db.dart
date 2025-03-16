import 'dart:async' show FutureOr;

import 'package:nosql_flutter_package/src/nosql_abstract/nosql_abstract.dart'
    show NoSqlBox;

abstract class NoSqlDB {
  FutureOr<void> init({String dirName = 'nosqldb'});
  FutureOr<bool> deleteFromDevice();
  FutureOr<NoSqlBox<T>?> openBox<T>(String boxName);
}
