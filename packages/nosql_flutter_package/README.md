# nosql_flutter_package - NoSqlHive Database Adapter

Creates an abstraction/interface for NoSql Databases to allow for different packages, like [hive_ce][1] or [sembast][2]

[1]: https://pub.dev/packages/hive_ce "pub.dev"
[2]: https://pub.dev/packages/sembast "pub.dev"

This repository provides a lightweight NoSQL database adapter built on top of [Hive](https://docs.hivedb.dev/). It offers a simple abstraction layer to interact with Hive using custom interfaces defined by `NoSqlDB` and `NoSqlBox`.

## Overview

The repository implements two main classes:

- **NoSqlHive**: Implements the `NoSqlDB` interface. It initializes Hive, handles deletion of Hive data from the device, and opens Hive boxes.
- **NoSqlHiveBox**: Extends the `NoSqlBox` abstract class. It wraps a Hive `Box` and provides basic operations to retrieve (`get`) and store (`put`) data.

Both classes utilize Dart's `FutureOr` type to allow for both synchronous and asynchronous operations, and they use try-catch blocks for robust error handling.

## Code Explanation

### NoSqlHive Class

- **init({String subDir = 'nosql_hive'})**
  Initializes Hive with the provided subdirectory (default is `nosql_hive`).
  - Returns `true` if initialization is successful.
  - Returns `false` if an exception occurs during initialization.

- **deleteFromDevice()**
  Deletes all Hive data from the disk.
  - Returns `true` if the deletion is successful.
  - Returns `false` if an error occurs.

- **`openBox<T>(String boxName)`**
  Opens a Hive box with the given name and wraps it in a `NoSqlHiveBox<T>`.
  - Returns an instance of `NoSqlHiveBox<T>` if the operation is successful.
  - Returns `null` if an exception is caught during the process.

### NoSqlHiveBox Class

- **get(dynamic key, {T? defaultValue})**
  Retrieves a value from the Hive box using the specified key.
  - Returns the value corresponding to the key.
  - If the key does not exist or an exception occurs, it returns `null` or the provided default value.

- **put(dynamic key, T value)**
  Stores a value in the Hive box under the given key.
  - Returns `true` if the operation is successful.
  - Returns `false` if an exception occurs during the operation.

## Installation & Setup

1. **Add Dependencies**:
  Ensure that your `pubspec.yaml` file includes the following dependencies:

```yaml
  dependencies:
    hive_ce: ^<version>
    nosql_flutter_package: ^<version>
```

Replace `<version>` with the appropriate version numbers.

1. **Initialize Hive**
  Before performing any operations, initialize Hive by calling the init method of the NoSqlHive class.

1. **Using Boxes**
  Open a Hive box by calling the ```openBox``` method and use the returned ```NoSqlHiveBox``` instance to perform CRUD operations with the get and put methods.

## Error Handling

All methods in both ```NoSqlHive``` and ```NoSqlHiveBox``` use try-catch blocks to handle exceptions gracefully. This design ensures that database operations do not crash the application and that error states are clearly indicated by returning ```false``` or null```.

## Contributing

Contributions to improve and extend this NoSQL database adapter are welcome. Please fork the repository and submit pull requests or open issues via GitHub.

## License

This project is licensed under the Apache License.
