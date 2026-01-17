import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bighustle/core/api_handler/failure.dart';
import 'package:flutter_bighustle/core/api_handler/success.dart';
import 'package:flutter_bighustle/core/constants/api_endpoints.dart';
import 'package:flutter_bighustle/core/services/app_pigeon/app_pigeon.dart';
import '../interface/license_interface.dart';
import '../model/license_create_request_model.dart';

final class LicenseInterfaceImpl extends LicenseInterface {
  final AppPigeon appPigeon;

  LicenseInterfaceImpl({required this.appPigeon});

  @override
  Future<Either<DataCRUDFailure, Success<String>>> createLicense({
    required LicenseCreateRequestModel param,
  }) async {
    return asyncTryCatch(
      tryFunc: () async {
        final formData = FormData.fromMap({
          'fullName': param.fullName,
          'licenseNumber': param.licenseNumber,
          'state': param.state,
          'dateOfBirth': param.dateOfBirth,
          'expiryDate': param.expiryDate,
          'licenseClass': param.licenseClass,
          'userPhoto': await MultipartFile.fromFile(
            param.userPhoto,
            filename: param.userPhoto.split('/').last,
          ),
          'licensePhoto': await MultipartFile.fromFile(
            param.licensePhoto,
            filename: param.licensePhoto.split('/').last,
          ),
        });
        final response = await appPigeon.post(
          ApiEndpoints.createLicense,
          data: formData,
        );
        final message =
            extractSuccessMessage(response) ??
            'License submitted successfully';
        return Success(message: message, data: message);
      },
    );
  }
}
