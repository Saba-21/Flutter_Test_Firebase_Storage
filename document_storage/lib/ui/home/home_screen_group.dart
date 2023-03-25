import 'package:document_storage/ui/home/profile_screen.dart';
import 'package:document_storage/utility/styles.dart';
import 'package:document_storage/ui/home/add_dialog.dart';
import 'package:flutter/material.dart';
import 'components/documents/documents_section.dart';
import 'components/tests/bottom_sheet/test_bottom_sheet.dart';
import 'components/tests/bottom_sheet/test_text_controller.dart';
import 'components/tests/models/test_model.dart';
import 'components/tests/tests_section.dart';

class HomeScreenGroup extends StatefulWidget {
  const HomeScreenGroup({super.key});

  final String title = 'Your Medical Data';

  @override
  State<HomeScreenGroup> createState() => _HomeScreenGroupState();
}

class _HomeScreenGroupState extends State<HomeScreenGroup> {
  final TestTextController testTextController = TestTextController();

  int _currentPageIndex = 0;

  @override
  void dispose() {
    testTextController.dispose();
    super.dispose();
  }

  void _add() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDialog(
          onAddTestClicked: () {
            showTestBottomSheet(null);
          },
        );
      },
    );
  }

  void showTestBottomSheet(TestModel? testModel) {
    testTextController.onOpened(testModel);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: bottomSheetShape,
      builder: (BuildContext context) {
        return TestBottomSheet(
          testModel: testModel,
          testTextController: testTextController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getHomeFAB(),
      bottomNavigationBar: getHomeNavBar(),
      appBar: getHomeAppBar(),
      body: _currentPageIndex == 0
          ? Column(
              children: [
                const DocumentsSection(),
                TestsSection(onOpenTestClicked: (TestModel test) {
                  showTestBottomSheet(test);
                })
              ],
            )
          : const ProfileScreen(),
    );
  }

  NavigationBar getHomeNavBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedIndex: _currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.file_copy_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_box_rounded),
          label: 'Profile',
        ),
      ],
    );
  }

  FloatingActionButton? getHomeFAB() {
    return _currentPageIndex == 0
        ? FloatingActionButton(
            onPressed: _add,
            tooltip: 'Add',
            child: const Icon(Icons.add),
          )
        : null;
  }

  AppBar getHomeAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }
}
