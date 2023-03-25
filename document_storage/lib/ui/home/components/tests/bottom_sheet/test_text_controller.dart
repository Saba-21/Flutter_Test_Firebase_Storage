import 'package:flutter/cupertino.dart';

import '../models/test_model.dart';

class TestTextController {
  final myNameFieldController = TextEditingController();
  final myAgeFieldController = TextEditingController();
  final myWeightFieldController = TextEditingController();

  void dispose() {
    myNameFieldController.dispose();
    myAgeFieldController.dispose();
    myWeightFieldController.dispose();
  }

  void onOpened(TestModel? testModel) {
    if (testModel != null) {
      myNameFieldController.text = testModel.name;
      myAgeFieldController.text = testModel.age.toString();
      myWeightFieldController.text = testModel.weight.toString();
    } else {
      myNameFieldController.clear();
      myAgeFieldController.clear();
      myWeightFieldController.clear();
    }
  }

  TestModel getTestModel() {
    return TestModel(
      myNameFieldController.text,
      int.parse(myAgeFieldController.text),
      double.parse(myWeightFieldController.text),
    );
  }
}
