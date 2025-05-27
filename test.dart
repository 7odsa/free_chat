import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Test {
  void testSaveImage(File image, String userID) async {
    final Directory dirPath = await getApplicationDocumentsDirectory();

    // TODO replace my_image with the user Id.
    final imagePath = '${dirPath.path}/$userID.jpg';

    final File newImage = await image.copy(imagePath);
  }
}
