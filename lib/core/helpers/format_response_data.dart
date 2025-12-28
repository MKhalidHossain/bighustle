import 'package:dio/dio.dart';

import 'dekhao.dart';

  dynamic extractBodyData(Response<dynamic> response) {
    return response.data["data"];
  }

  String? extractSuccessMessage(Response<dynamic> response){
    dekhao(response);
    try {
      return (response.data["success"] as bool) == true ? response.data["message"] as String : null;
    } catch (e) {
      dekhao("Error from parsing success message: $e");
      return null;
    }
  }