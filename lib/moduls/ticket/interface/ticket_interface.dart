import 'package:dartz/dartz.dart';

import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../model/ticket_model.dart';

abstract base class TicketInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<TicketResponse>>> getMyTickets({
    String? status,
  });

  Future<Either<DataCRUDFailure, Success<TicketModel>>> getTicketById(
    String ticketId,
  );
}
