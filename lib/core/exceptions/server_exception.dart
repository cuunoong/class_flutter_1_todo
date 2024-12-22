class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server Error, try again later']);

  @override
  String toString() {
    return message;
  }
}
