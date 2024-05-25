class WordNotFoundException implements Exception {
  final String message;
  WordNotFoundException(this.message);
}

class WordAlreadyExistsException implements Exception {
  final String message;
  WordAlreadyExistsException(this.message);
}
