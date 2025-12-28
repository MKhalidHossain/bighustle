import 'package:flutter_bighustle/core/constants/api_endpoints.dart';
import 'package:flutter_bighustle/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_bighustle/core/services/app_pigeon/refresh_token_manager.dart';
import 'package:get/get.dart';

void externalServiceDI() {
  // Initialize other external services here
  Get.put(AppPigeon(
    RefreshTokenManager(ApiEndpoints.refreshToken),
    baseUrl: ApiEndpoints.baseUrl,
  ));
}