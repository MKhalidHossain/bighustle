import 'package:get/get.dart';

import '../../moduls/auth/implement/auth_interface_impl.dart';
import '../../moduls/auth/interface/auth_interface.dart';
import '../../moduls/license/implement/license_interface_impl.dart';
import '../../moduls/license/interface/license_interface.dart';
import '../../moduls/ticket/implement/ticket_interface_impl.dart';
import '../../moduls/ticket/interface/ticket_interface.dart';
import '../services/app_pigeon/app_pigeon.dart';

void initServices() {
  Get.put<AuthInterface>(
    AuthInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
  );
  Get.put<LicenseInterface>(
    LicenseInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
  );
  Get.put<TicketInterface>(
    TicketInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
  );
}
