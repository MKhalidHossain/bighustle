import 'package:flutter/foundation.dart';
enum DebugLabel {
  ui,
  networkCall,
  controller,
  dataParsing
}

void dekhao(dynamic data, {DebugLabel? label}) {
  // if(kDebugMode) {
  //   String prefix = label != null ? "[${label.name}]" : "";
  //   print("dekho $prefix>> ${data.toString()}");
  //   //debugPrint(data.toString());
  // }
}

void dekhao2(dynamic data, {DebugLabel? label}) {
  if(kDebugMode) {
    String prefix = label != null ? "[${label.name}]" : "";
    print("dekho2 $prefix>> ${data.toString()}");
    //debugPrint(data.toString());
  }
}