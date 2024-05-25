import 'package:dart_playground/class/abstract_dictionary.dart';
import 'package:dart_playground/common/exceptions.dart';
import 'package:dart_playground/model/dictionary_entry.dart';

typedef Dictionary = Map<String, String>;

class MapDictionary implements AbstractDictionary {
  final Dictionary _dictionary = {};

  void _ensureWordExists(String term) {
    if (!_dictionary.containsKey(term)) {
      throw WordNotFoundException("$term 단어를 찾을 수 없습니다.");
    }
  }

  void _ensureWordNotExists(String term) {
    if (_dictionary.containsKey(term)) {
      throw WordAlreadyExistsException("$term 단어가 이미 존재합니다.");
    }
  }

  @override
  String get(String term) {
    _ensureWordExists(term);
    return _dictionary[term]!;
  }

  @override
  void add(String term, String definition) {
    _ensureWordNotExists(term);
    _dictionary[term] = definition;
  }

  @override
  void delete(String term) {
    _ensureWordExists(term);
    _dictionary.remove(term);
  }

  @override
  void update(String term, String definition) {
    _ensureWordExists(term);
    _dictionary[term] = definition;
  }

  @override
  List<String> showAll() {
    return _dictionary.keys.toList();
  }

  @override
  int count() {
    return _dictionary.length;
  }

  @override
  void upsert(String term, String definition) {
    if (_dictionary.containsKey(term)) {
      update(term, definition);
    } else {
      add(term, definition);
    }
  }

  @override
  bool exists(String term) {
    return _dictionary.containsKey(term);
  }

  @override
  void bulkAdd(List<Map<String, String>> words) {
    for (final word in words) {
      final entry = DictionaryEntry.fromJson(word);
      _ensureWordNotExists(entry.term);
    }

    for (final word in words) {
      final entry = DictionaryEntry.fromJson(word);
      add(entry.term, entry.definition);
    }
  }

  @override
  void bulkDelete(List<String> terms) {
    for (final term in terms) {
      _ensureWordExists(term);
    }

    for (final term in terms) {
      delete(term);
    }
  }
}
