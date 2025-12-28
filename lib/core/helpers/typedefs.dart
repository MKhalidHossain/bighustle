import 'package:dartz/dartz.dart';

import '../api_handler/failure.dart';

typedef Request<T> = Either<DataCRUDFailure, T>;

typedef FutureRequest<T> = Future<Request<T>>;