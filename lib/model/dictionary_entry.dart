class DictionaryEntry {
  final String _term;
  String _definition;

  DictionaryEntry({
    required String term,
    required String definition,
  })  : _term = term,
        _definition = definition;

  DictionaryEntry.fromJson(Map<String, dynamic> json)
      : _term = json['term'],
        _definition = json['definition'];

  String get term => _term;
  String get definition => _definition;

  void setDefinition(String definition) {
    _definition = definition;
  }
}
