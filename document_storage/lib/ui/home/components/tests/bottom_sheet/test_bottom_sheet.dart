import 'package:document_storage/data/firestore_service.dart';
import 'package:document_storage/ui/home/components/tests/bottom_sheet/test_text_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../data/db_helper.dart';
import '../models/test_model.dart';

class TestBottomSheet extends StatelessWidget {
  const TestBottomSheet(
      {Key? key, this.testModel, required this.testTextController})
      : super(key: key);

  final TestModel? testModel;
  final TestTextController testTextController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Test Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enabled: testModel == null,
              keyboardType: TextInputType.name,
              controller: testTextController.myNameFieldController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Test Name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Height',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enabled: testModel == null,
              keyboardType: TextInputType.number,
              controller: testTextController.myAgeFieldController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Height',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Weight',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enabled: testModel == null,
              keyboardType: TextInputType.number,
              controller: testTextController.myWeightFieldController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Weight',
              ),
            ),
            const SizedBox(height: 30),
            if (testModel == null)
              OutlinedButton(
                onPressed: () async {
                  final data = testTextController.getTestModel();
                  final result = await FirestoreService().uploadTest(data);
                  if (result != null) {
                    DBHelper().insertTest(result);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              )
          ],
        ),
      ),
    );
  }
}
