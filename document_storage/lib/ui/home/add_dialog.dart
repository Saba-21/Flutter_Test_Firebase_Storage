import 'package:document_storage/utility/utilities.dart';
import 'package:flutter/material.dart';

import '../../data/db_helper.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({Key? key, required this.onAddTestClicked}) : super(key: key);

  final VoidCallback onAddTestClicked;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Add medical record'),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              var result = await uploadFile();
              if (result != null) {
                insertDocument(result.files.single.path!);
              }
            },
            child: const Text(
              'Upload Document',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onAddTestClicked();
            },
            child: const Text(
              'Take a Test',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
