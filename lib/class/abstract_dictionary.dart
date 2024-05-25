abstract class AbstractDictionary {
  void add(String term, String definition);
  String get(String term);
  void delete(String term);
  void update(String term, String definition);
  void showAll();
  int count();
  void upsert(String term, String definition);
  bool exists(String term);
  void bulkAdd(List<Map<String, String>> words);
  void bulkDelete(List<String> terms);
}
