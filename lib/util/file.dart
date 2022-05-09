
import 'dart:ffi';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:shopapp/config/api.dart';

import 'package:shopapp/net/net_request.dart';

Future uploadHeader(String type) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print(image.path);
    print(image.name);

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path)
    });
    await NetRequest()
        .request(MyApi.UP_LOAD, data: formdata, method: "post")
        .then((response) {

    }).catchError((error) {
      print(error);
    });
  }
  return Future;
}

Future savePic(String type) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print(image.path);
    print(image.name);

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path)
    });
    await NetRequest()
        .request(MyApi.SAVE_PIC, data: formdata, method: "post")
        .then((response) {

    }).catchError((error) {
      print(error);
    });
  }
  return Future;
}
