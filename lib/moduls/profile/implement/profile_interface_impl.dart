
import 'package:flutter_bighustle/core/services/app_pigeon/app_pigeon.dart';
import '../interface/profile_interface.dart';
// import '../model/forget_password_request_model.dart';
// import '../model/login_request_model.dart';
// import '../model/logout_request_model.dart';
// import '../model/register_request_model.dart';
// import '../model/reset_password_request_model.dart';
// import '../model/change_password_request_model.dart';
// import '../model/verify_email_request_model.dart';
// import '../model/verify_email_register_request_model.dart';

final class ProfileInterfaceImpl extends ProfileInterface {
  final AppPigeon appPigeon;

  ProfileInterfaceImpl({required this.appPigeon});

  // ///{signup}
  // @override
  // Future<Either<DataCRUDFailure, Success<String>>> register({
  //   required RegisterRequest param,
  // }) async {
  //   return asyncTryCatch(
  //     tryFunc: () async {
  //       final response = await appPigeon.post(
  //         ApiEndpoints.signup,
  //         data: param.toJson(),
  //       );
  //       final responseBody = response.data is Map
  //           ? Map<String, dynamic>.from(response.data)
  //           : <String, dynamic>{};
  //       final responseData = responseBody["data"];
  //       final payload = responseData is Map
  //           ? Map<String, dynamic>.from(responseData)
  //           : responseBody;
  //       final userData = payload['user'] is Map
  //           ? Map<String, dynamic>.from(payload['user'])
  //           : payload;

  //       String readString(dynamic value) => value?.toString() ?? '';
  //       String pickFirstString(List<dynamic> values) {
  //         for (final value in values) {
  //           final stringValue = readString(value);
  //           if (stringValue.isNotEmpty) {
  //             return stringValue;
  //           }
  //         }
  //         return '';
  //       }

  //       final accessToken = pickFirstString([
  //         payload['accessToken'],
  //         payload['token'],
  //         responseBody['accessToken'],
  //         responseBody['token'],
  //       ]);
  //       var refreshToken = pickFirstString([
  //         payload['refreshToken'],
  //         responseBody['refreshToken'],
  //       ]);
  //       if (refreshToken.isEmpty) {
  //         refreshToken = accessToken;
  //       }
  //       final userId = pickFirstString([
  //         userData['id'],
  //         userData['_id'],
  //         payload['userId'],
  //         payload['_id'],
  //         responseBody['userId'],
  //         responseBody['_id'],
  //       ]);

  //       if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
  //         await appPigeon.saveNewAuth(
  //           saveAuthParams: SaveNewAuthParams(
  //             accessToken: accessToken,
  //             refreshToken: refreshToken,
  //             data: userData,
  //             uid: userId.isNotEmpty ? userId : null,
  //           ),
  //         );
  //       }

  //       return Success(
  //         message: 'Register Successfuly',
  //         data: 'Successful Register.',
  //       );
  //     },
  //   );
  // }

}
