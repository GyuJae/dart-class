/// 사전을 나타내는 추상 클래스.
abstract class AbstractDictionary {
  /// 사전에 단어와 정의를 추가합니다.
  ///
  /// @param term 추가할 단어.
  /// @param definition 단어의 정의.
  /// @throws WordAlreadyExistsException 단어가 이미 존재할 때.
  void add(String term, String definition);

  /// 사전에서 단어의 정의를 반환합니다.
  ///
  /// @param term 정의를 가져올 단어.
  /// @return 단어의 정의.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  String get(String term);

  /// 사전에서 단어를 삭제합니다.
  ///
  /// @param term 삭제할 단어.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  void delete(String term);

  /// 사전에서 단어의 정의를 업데이트합니다.
  ///
  /// @param term 업데이트할 단어.
  /// @param definition 단어의 새로운 정의.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  void update(String term, String definition);

  /// 사전의 모든 단어를 보여줍니다.
  ///
  /// @return 사전의 모든 단어 리스트.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  List<String> showAll();

  /// 사전의 총 단어 수를 반환합니다.
  ///
  /// @return 사전의 총 단어 수.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  int count();

  /// 단어의 정의를 업데이트합니다. 만약 단어가 존재하지 않으면 추가합니다.
  ///
  /// @param term 업서트할 단어.
  /// @param definition 단어의 정의.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  void upsert(String term, String definition);

  /// 단어가 사전에 존재하는지 여부를 확인합니다.
  ///
  /// @param term 확인할 단어.
  /// @return 단어가 존재하면 true, 그렇지 않으면 false.
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  bool exists(String term);

  /// 여러 개의 단어와 정의를 사전에 추가합니다.
  ///
  /// @param words 단어와 정의를 포함한 맵 리스트. 예) [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
  /// @throws WordAlreadyExistsException 단어가 이미 존재할 때.
  void bulkAdd(List<Map<String, String>> words);

  /// 여러 개의 단어를 사전에서 삭제합니다.
  ///
  /// @param terms 삭제할 단어 리스트. 예) ["김치", "아파트"]
  /// @throws WordNotFoundException 단어가 존재하지 않을 때.
  void bulkDelete(List<String> terms);
}
