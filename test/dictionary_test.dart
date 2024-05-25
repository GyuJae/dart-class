import 'package:dart_playground/class/abstract_dictionary.dart';
import 'package:dart_playground/class/list_dictionary.dart';
import 'package:dart_playground/class/map_dictionary.dart';
import 'package:dart_playground/class/set_dictionary.dart';
import 'package:dart_playground/common/exceptions.dart';
import 'package:test/test.dart';

void main() {
  void runTests(AbstractDictionary Function() dictionaryFactory) {
    group(
      "Dictionary",
      () {
        test("add: 단어를 추가함.", () {
          final dictionary = dictionaryFactory();

          dictionary.add("apple", "사과");

          expect(dictionary.get("apple"), "사과");
        });

        test("add: 이미 단어가 존재하는 경우 에러를 던짐", () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");

          expect(
            () => dictionary.add("apple", "사과"),
            throwsA(isA<WordAlreadyExistsException>()),
          );
        });

        test("get: 단어의 정의를 리턴함.", () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");
          dictionary.add("banana", "바나나");

          expect(dictionary.get("apple"), "사과");
          expect(dictionary.get("banana"), "바나나");
        });

        test('get: 존재하지 않는 단어를 요청할 때 에러를 던짐.', () {
          final dictionary = dictionaryFactory();

          expect(
            () => dictionary.get("banana"),
            throwsA(isA<WordNotFoundException>()),
          );
        });

        test('delete: 단어를 삭제함.', () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");
          dictionary.add("banana", "바나나");

          dictionary.delete("apple");

          expect(
            () => dictionary.get("apple"),
            throwsA(isA<WordNotFoundException>()),
          );
          expect(dictionary.get("banana"), "바나나");
        });

        test("delete: 존재하지 않는 단어를 삭제 시 에러를 던짐.", () {
          final dictionary = dictionaryFactory();

          expect(
            () => dictionary.delete("banana"),
            throwsA(isA<WordNotFoundException>()),
          );
        });

        test("update: 단어를 업데이트 함.", () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");

          dictionary.update("apple", "사과, 사과나무");

          expect(dictionary.get("apple"), "사과, 사과나무");
        });

        test("update: 존재하지 않는 단어를 업데이트 시 에러를 던짐.", () {
          final dictionary = dictionaryFactory();

          expect(
            () => dictionary.update("banana", "바나나"),
            throwsA(isA<WordNotFoundException>()),
          );
        });

        test("showAll: 사전 단어를 모두 보여줌.", () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");
          dictionary.add("banana", "바나나");

          expect(dictionary.showAll(), ["apple", "banana"]);
        });

        test("count: 사전 단어들의 총 갯수를 리턴함.", () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");
          dictionary.add("banana", "바나나");

          expect(dictionary.count(), 2);
        });

        test("upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)",
            () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");

          dictionary.upsert("apple", "사과, 사과나무");
          dictionary.upsert("banana", "바나나");

          expect(dictionary.get("apple"), "사과, 사과나무");
          expect(dictionary.get("banana"), "바나나");
        });

        test("exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.", () {
          final dictionary = dictionaryFactory();
          dictionary.add("apple", "사과");

          expect(dictionary.exists("apple"), true);
          expect(dictionary.exists("banana"), false);
        });

        test(
            'bulkAdd: 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]',
            () {
          final dictionary = dictionaryFactory();

          dictionary.bulkAdd([
            {"term": "김치", "definition": "대박이네~"},
            {"term": "아파트", "definition": "비싸네~"},
          ]);

          expect(dictionary.get("김치"), "대박이네~");
          expect(dictionary.get("아파트"), "비싸네~");
        });

        test(
            "bulkAdd: 이미 존재하는 단어를 추가 시 에러를 던짐. (존재하지 않는 단어도 이미 존재하는 단어가 리스트에 존재 시에 추가가 되면 안됩니다.)",
            () {
          final dictionary = dictionaryFactory();
          dictionary.add("김치", "대박이네~");

          expect(
            () => dictionary.bulkAdd([
              {"term": "아파트", "definition": "비싸네~"},
              {"term": "김치", "definition": "대박이네~"},
            ]),
            throwsA(isA<WordAlreadyExistsException>()),
          );
          expect(
            () => dictionary.get("아파트"),
            throwsA(isA<WordNotFoundException>()),
          );
        });

        test('bulkDelete: 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]',
            () {
          final dictionary = dictionaryFactory();
          dictionary.add("김치", "대박이네~");
          dictionary.add("아파트", "비싸네~");

          dictionary.bulkDelete(["김치", "아파트"]);

          expect(
            () => dictionary.get("김치"),
            throwsA(isA<WordNotFoundException>()),
          );
          expect(
            () => dictionary.get("아파트"),
            throwsA(isA<WordNotFoundException>()),
          );
        });

        test(
            "bulkDelete: 존재하지 않는 단어를 삭제 시 에러를 던짐. (존재하는 단어도 이미 존재하지 않는 단어가 리스트에 존재 시에 삭제가 되면 안됩니다.)",
            () {
          final dictionary = dictionaryFactory();
          dictionary.add("김치", "대박이네~");

          expect(
            () => dictionary.bulkDelete(["김치", "아파트"]),
            throwsA(isA<WordNotFoundException>()),
          );
          expect(dictionary.get("김치"), "대박이네~");
        });
      },
    );
  }

  runTests(() => ListDictionary());
  runTests(() => MapDictionary());
  runTests(() => SetDictionary());
}
