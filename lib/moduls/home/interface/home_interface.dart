import 'package:dartz/dartz.dart';

import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../model/home_response_model.dart';

abstract base class HomeInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<HomeResponseModel>>> getHomeData();
}
