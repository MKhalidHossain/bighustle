
import 'package:dartz/dartz.dart';
import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../model/profile_response_model.dart';


abstract base class ProfileInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<ProfileResponseModel>>> getProfile();
}
