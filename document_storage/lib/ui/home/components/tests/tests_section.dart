import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../data/db_helper.dart';
import '../../../../utility/styles.dart';
import 'models/test_model.dart';
import 'test_item.dart';

class TestsSection extends StatelessWidget {
  const TestsSection({Key? key, required this.onOpenTestClicked})
      : super(key: key);

  final void Function(TestModel) onOpenTestClicked;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getTestsListenable(),
      builder: (context, Box<dynamic> box, widget) {
        var tests = getTests(box);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: sectionTitlePadding,
              color: Colors.blueAccent,
              child: const Text(
                'Tests',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            if (tests.isEmpty)
              const SizedBox(
                height: 140,
                child: Center(
                  child: Text("No data"),
                ),
              )
            else
              SizedBox(
                height: 140,
                child: ListView.builder(
                  padding: sectionListItemPadding,
                  itemCount: tests.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TestItem(
                      item: tests[index],
                      onItemClick: () {
                        onOpenTestClicked(tests[index]);
                      },
                      onCancelClick: () {
                        tests.removeAt(index);
                        updateTests(tests, box);
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
