import 'package:document_storage/utility/utilities.dart';
import 'package:flutter/material.dart';

import '../../../../utility/styles.dart';

class DocumentItem extends StatelessWidget {
  const DocumentItem({
    Key? key,
    required this.onItemClick,
    required this.onCancelClick,
    required this.item,
  }) : super(key: key);

  final VoidCallback onItemClick;
  final VoidCallback onCancelClick;
  final String item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemClick,
      child: SizedBox(
        width: 100,
        child: Card(
          color: Colors.lightBlueAccent,
          shape: sectionListItemShape,
          child: Padding(
            padding: sectionListItemCardPadding,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_present_rounded,
                        size: 36,
                      ),
                      Text(
                        getFileName(item),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                    onPressed: onCancelClick,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
