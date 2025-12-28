import 'package:dio/dio.dart';

import '../../services/debug/debug_service.dart';

  dynamic extractBodyData(Response<dynamic> response) {
    return response.data["data"];
  }

  String? extractSuccessMessage(Response<dynamic> response, {Debugger? debugger}){
    debugger?.dekhao(response);
    try {
      return (response.data["success"] as bool) == true ? response.data["message"] as String : null;
    } catch (e) {
      debugger?.dekhao("Error from parsing success message: $e");
      return null;
    }
  }

  