import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  if (image != null && image.files.isNotEmpty) {
    return image;
  }

  return null;
}
