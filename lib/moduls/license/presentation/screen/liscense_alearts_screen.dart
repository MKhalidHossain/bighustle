import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/services/app_pigeon/app_pigeon.dart';
import '../../implement/license_interface_impl.dart';
import '../../interface/license_interface.dart';
import '../../model/license_alert_model.dart';
import '../widget/license_alert_item.dart';

class LicenseAlertsScreen extends StatefulWidget {
  const LicenseAlertsScreen({super.key});

  @override
  State<LicenseAlertsScreen> createState() => _LicenseAlertsScreenState();
}

class _LicenseAlertsScreenState extends State<LicenseAlertsScreen> {
  bool _isLoading = true;
  List<LicenseAlertModel> _alerts = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _fetchAlerts();
    }
  }

  Future<void> _fetchAlerts() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (!Get.isRegistered<LicenseInterface>()) {
        Get.put<LicenseInterface>(
          LicenseInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
        );
      }

      final licenseInterface = Get.find<LicenseInterface>();
      final result = await licenseInterface.getAlerts();

      if (!mounted) return;

      result.fold(
        (failure) {
          final snackbarNotifier = SnackbarNotifier(context: context);
          snackbarNotifier.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Failed to load alerts',
          );
          setState(() {
            _isLoading = false;
            _alerts = [];
          });
        },
        (success) {
          setState(() {
            _isLoading = false;
            _alerts = success.data ?? [];
          });
        },
      );
    } catch (e) {
      if (!mounted) return;
      final snackbarNotifier = SnackbarNotifier(context: context);
      snackbarNotifier.notifyError(
        message: 'An error occurred while loading alerts',
      );
      setState(() {
        _isLoading = false;
        _alerts = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.black),
                const Text(
                  'License Alerts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 26,)
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alert & Information',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : _alerts.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No alerts available',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF999999),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _alerts.length,
                                  itemBuilder: (context, index) {
                                    return LicenseAlertItem(
                                      alert: _alerts[index],
                                      showDivider: index != _alerts.length - 1,
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
