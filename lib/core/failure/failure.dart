class Failure {
  final String message;

  Failure({required this.message});
}

class PostgrestFailure extends Failure {
  PostgrestFailure({required super.message});
}

class FormatFailure extends Failure {
  FormatFailure({required super.message});
}
class ConnectionFailure extends Failure {
  ConnectionFailure({required super.message});
}

class PlatformFailure extends Failure {
  PlatformFailure({required super.message});
}

class StorageFailure extends Failure {
  StorageFailure({required super.message});
}