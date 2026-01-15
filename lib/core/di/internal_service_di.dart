import 'package:get/get.dart';

import '../../moduls/auth/implement/auth_interface_impl.dart';
import '../../moduls/auth/interface/auth_interface.dart';
import '../services/app_pigeon/app_pigeon.dart';

void initServices() {
  Get.put<AuthInterface>(
    AuthInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
  );
}
