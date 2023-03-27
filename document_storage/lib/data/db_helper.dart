import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../ui/home/components/tests/models/test_model.dart';
import 'keys.dart';

class DBHelper {
  Future<void> initializeDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TestModelAdapter());
    await Hive.openBox(medicalDataBoxKey);
  }

  Future<Box<dynamic>> getDatabaseBox() async {
    return await Hive.openBox(medicalDataBoxKey);
  }

  Future<int> clearLocalDatabase() async {
    final box = await getDatabaseBox();
    return await box.clear();
  }

  //----------------------------------------------------------------------------

  getTests(Box box) {
    return box.get(testsKey, defaultValue: List.empty());
  }

  void updateTests(List<dynamic> tests, Box box) {
    box.put(testsKey, tests);
  }

  getTestsListenable() {
    return Hive.box(medicalDataBoxKey).listenable(keys: [testsKey]);
  }

  void insertTest(TestModel test) async {
    var box = await getDatabaseBox();
    var tests = List.empty(growable: true);
    tests.addAll(getTests(box));
    tests.add(test);
    updateTests(tests, box);
  }

  //----------------------------------------------------------------------------

  getDocumentsListenable() {
    return Hive.box(medicalDataBoxKey).listenable(keys: [docsKey]);
  }

  getDocuments(Box box) {
    return box.get(docsKey, defaultValue: List.empty());
  }

  void updateDocuments(List<dynamic> docs, Box box) {
    box.put(docsKey, docs);
  }

  void insertDocument(String doc) async {
    var box = await getDatabaseBox();
    var docs = List.empty(growable: true);
    docs.addAll(getDocuments(box));
    docs.add(doc);
    updateDocuments(docs, box);
  }
}
