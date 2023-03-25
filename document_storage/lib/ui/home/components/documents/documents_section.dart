import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../data/db_helper.dart';
import '../../../../utility/styles.dart';
import '../../../../utility/utilities.dart';
import 'document_item.dart';

class DocumentsSection extends StatelessWidget {
  const DocumentsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getDocumentsListenable(),
      builder: (context, Box<dynamic> box, widget) {
        var docs = getDocuments(box);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blueAccent,
              padding: sectionTitlePadding,
              child: const Text(
                'Documents',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            if (docs.isEmpty)
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
                  itemCount: docs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return DocumentItem(
                      item: docs[index],
                      onItemClick: () {
                        openFile(docs[index]);
                      },
                      onCancelClick: () {
                        docs.removeAt(index);
                        updateDocuments(docs, box);
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
