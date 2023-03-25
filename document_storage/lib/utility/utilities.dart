import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path_helper;

Future<FilePickerResult?> uploadFile() async {
  return await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'doc'],
  );
}

void openFile(String path) {
  OpenFilex.open(path);
}

String getFileName(String path) {
  return path_helper.basename(path);
}
