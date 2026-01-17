import 'package:dartz/dartz.dart';

import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../model/license_create_request_model.dart';

abstract base class LicenseInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<String>>> createLicense({
    required LicenseCreateRequestModel param,
  });
}
