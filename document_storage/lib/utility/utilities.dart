import 'package:document_storage/data/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path_helper;
import 'package:url_launcher/url_launcher.dart';

Future<FilePickerResult?> uploadFile() async {
  return await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'doc'],
  );
}

Future<void> openFile(String filename) async {
  var path = await StorageService().getUrl(filename);
  if (path != null) {
    var url = Uri.parse(path);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

String getFileName(String path) {
  return path_helper.basename(path);
}
