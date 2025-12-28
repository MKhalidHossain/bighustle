import 'package:dartz/dartz.dart';

import '../../api_handler/failure.dart';
import '../../helpers/typedefs.dart';

abstract interface class AsyncUsecase<SuccessType, Params>{
  Future<SuccessType> call(Params params);
}

abstract interface class AsyncEitherUsecase<SuccessType, Params>{
  Future<Either<DataCRUDFailure, SuccessType>> call(Params params);
}

abstract interface class AsyncEitherUsecase2<SuccessType, Params>{
  FutureRequest<SuccessType> call(Params params);
}

abstract interface class EitherUsecase<SuccessType, Params>{
  Either<DataCRUDFailure, SuccessType> call(Params params);
}

abstract interface class NormalUsecase<SuccessType, Params>{
  SuccessType call(Params params);
}

class NoParams{}