import 'package:dartz/dartz.dart';

import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';
import '../interface/license_interface.dart';
import '../model/license_response_model.dart';

final class LicenseInterfaceImpl extends LicenseInterface {
  final AppPigeon appPigeon;

  LicenseInterfaceImpl({required this.appPigeon});

  @override
  Future<Either<DataCRUDFailure, Success<List<LicenseResponseModel>>>> getLicense() async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get(ApiEndpoints.getLicense);
        final responseBody = response.data is Map
            ? Map<String, dynamic>.from(response.data)
            : <String, dynamic>{};
        final responseData = responseBody["data"];
        
        if (responseData == null) {
          return Success(
            message: 'No license data found',
            data: <LicenseResponseModel>[],
          );
        }

        List<LicenseResponseModel> licenses = [];
        if (responseData is List) {
          licenses = responseData
              .map((item) => LicenseResponseModel.fromJson(
                  Map<String, dynamic>.from(item)))
              .toList();
        } else if (responseData is Map) {
          // If single license object instead of array
          licenses = [LicenseResponseModel.fromJson(
              Map<String, dynamic>.from(responseData))];
        }

        return Success(
          message: responseBody['message']?.toString() ?? 'Licenses fetched successfully',
          data: licenses,
        );
      },
    );
  }
}
