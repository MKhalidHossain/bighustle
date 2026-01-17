import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../services/debug/debug_service.dart';
import 'exceptions.dart';
import 'failure.dart';

base class BaseRepository {
  Future<Either<DataCRUDFailure, T>> asyncTryCatch<T>({
    required Future<T> Function() tryFunc,
  }) async {
    try {
      return await tryFunc().then((value) => Right(value));
    } on ServerException {
      return Left(
        DataCRUDFailure(
          failure: Failure.severFailure,
          fullError: 'Server failed!',
        ),
      );
    } on NoDataException {
      return Left(
        DataCRUDFailure(failure: Failure.noData, fullError: "Doesn't exist!"),
      );
    } on SocketException {
      return Left(
        DataCRUDFailure(
          failure: Failure.socketFailure,
          fullError: 'Internet connection failed!',
        ),
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final responseMessage = responseData is Map && responseData['message'] != null
          ? responseData['message'].toString()
          : responseData is String
              ? responseData
              : null;
      debugPrint(".. \n..\n");
      if (responseMessage != null) {
        debugPrint(responseMessage);
      }
      debugPrint(".. \n..\n");
      //debugger?.dekhao("DioFailure $e");
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return Left(
            DataCRUDFailure(
              failure: Failure.timeout,
              fullError: 'Connection timeout! Make sure internet is connected!',
            ),
          );
        case DioExceptionType.receiveTimeout:
          return Left(
            DataCRUDFailure(
              failure: Failure.timeout,
              fullError: 'Connection timeout! Make sure internet is connected!',
            ),
          );
        case DioExceptionType.sendTimeout:
          return Left(
            DataCRUDFailure(
              failure: Failure.timeout,
              fullError: 'Connection timeout! Make sure internet is connected!',
            ),
          );
        case DioExceptionType.cancel:
          return Left(
            DataCRUDFailure(
              failure: Failure.unknownFailure,
              uiMessage: "Request cancelled!",
              fullError: 'Some error occured. ${'\n'} Error: ${e.toString()}',
            ),
          );
        default:
          return Left(
            DataCRUDFailure(
              failure: Failure.unknownFailure,
              uiMessage: responseMessage ?? "Some error occured.",
              fullError: 'Some error occured. ${'\n'} Error: ${e.toString()}',
            ),
          );
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      //debugger?.dekhao(e);
      return Left(
        DataCRUDFailure(
          failure: Failure.unknownFailure,
          uiMessage: 'Some error occured.',
          fullError: "Some error occured. ${'\n'} Error: ${e.toString()}",
        ),
      );
    }
  }

  Either<DataCRUDFailure, T> tryCatch<T>({required T Function() tryFunc}) {
    try {
      return Right(tryFunc());
    } on ServerException {
      return Left(
        DataCRUDFailure(failure: Failure.severFailure, fullError: ''),
      );
    } on SocketException {
      return Left(
        DataCRUDFailure(
          failure: Failure.socketFailure,
          fullError: 'Internet connection failed!',
        ),
      );
    } catch (e) {
      return Left(
        DataCRUDFailure(
          failure: Failure.unknownFailure,
          fullError: 'Some error occured. Error: ${e.toString()}',
        ),
      );
    }
  }

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
}
