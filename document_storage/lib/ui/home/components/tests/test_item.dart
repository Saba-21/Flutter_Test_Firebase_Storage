import 'package:flutter/material.dart';

import '../../../../utility/styles.dart';
import 'models/test_model.dart';

class TestItem extends StatelessWidget {
  const TestItem({
    Key? key,
    required this.onItemClick,
    required this.onCancelClick,
    required this.item,
  }) : super(key: key);

  final VoidCallback onItemClick;
  final VoidCallback onCancelClick;
  final TestModel item;

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
                        Icons.text_snippet_rounded,
                        size: 36,
                      ),
                      Text(item.name, maxLines: 2),
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
