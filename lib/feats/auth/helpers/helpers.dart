import 'dart:io';

import 'package:path_provider/path_provider.dart' as sysPath;

Future<File> saveImageInAppDir(String userId, File image) async {
  final appDir = await sysPath.getApplicationDocumentsDirectory();
  // final fileName = path.join(appDir.path, '$userId.jpg');
  final file = await image.copy('${appDir.path}/$userId.jpg');

  return file;
}
