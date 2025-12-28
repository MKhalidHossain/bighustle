
  //functions :: 
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/debug/debug_service.dart';


  class ImageLoader{
    ImageLoader._();
    
    static ImageLoader? _instance;

    static ImageLoader get instance {
      _instance ??= ImageLoader._();
      return _instance!;
    }


    Future<File> uint8ListToFile(Uint8List uint8List, String fileName) async {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(uint8List);
      return file;
    }

    /// Creates an isolate, pick an image from client, returns the picked image, if successful.
    // Future<Uint8List?> _pickImage() async{
    //   return await compute(pickImage, "");
    // }

    Future<Uint8List?> pickImage({Debugger? debugger}) async {
      try {
        return await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 13).then((value) async{
          debugger?.dekhao(value.runtimeType);
          if(value == null) {
            return null;
          }else {
            final image = await value.readAsBytes();
            return image;
          }
          
        });
      } catch (error) {
        debugger?.dekhao(error.toString());
      }
      return null;
    }
  }
