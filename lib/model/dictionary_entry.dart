class DictionaryEntry {
  final String _term;
  String _definition;

  DictionaryEntry({
    required String term,
    required String definition,
  })  : _term = term,
        _definition = definition;

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(
      term: json['term'],
      definition: json['definition'],
    );
  }

  String get term => _term;
  String get definition => _definition;

  void setDefinition(String definition) {
    _definition = definition;
  }
}
