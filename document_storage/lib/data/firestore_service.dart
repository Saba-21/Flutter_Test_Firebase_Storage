import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_storage/data/auth_service.dart';
import 'package:document_storage/ui/home/components/tests/models/test_model.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<TestModel?> uploadTest(TestModel testModel) async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      final test = <String, dynamic>{
        'weight': testModel.weight,
        'height': testModel.age,
        'test_name': testModel.name
      };
      try {
        final result = await db.collection(user.uid).add(test);
        return TestModel(
          testModel.name,
          testModel.age,
          testModel.weight,
          result.id,
        );
      } catch (error) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> deleteTest(String testId) async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      try {
        await db.collection(user.uid).doc(testId).delete();
        return true;
      } catch (error) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<TestModel>> getTests() async {
    final user = AuthService().getCurrentUser();
    if (user != null) {
      try {
        final result = await db.collection(user.uid).get();
        final tests = result.docs
            .map(
              (e) => TestModel(e.get('test_name') as String,
                  e.get('height') as int, e.get('weight') as double, e.id),
            )
            .toList();
        return tests;
      } catch (error) {
        return List.empty();
      }
    } else {
      return List.empty();
    }
  }
}
