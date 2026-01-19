import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../controller/profile_info_controller.dart';
import '../../interface/profile_interface.dart';
import '../../model/notification_settings_request_model.dart';
import '../../model/profile_data.dart';
import '../widget/notification_tile.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  static const Color _background = Color(0xFFF2F2F2);
  bool _isSaving = false;
  bool _isInitialized = false;
  late final SnackbarNotifier _snackbarNotifier;
  late final ProfileData _profileData;
  Timer? _saveDebounce;
  NotificationSettingsRequestModel? _queuedSettings;
  NotificationSettingsRequestModel? _lastServerSettings;

  @override
  void initState() {
    super.initState();
    _profileData = ProfileData.instance;
    if (!_profileData.hasLoaded) {
      _loadProfile();
    } else {
      _lastServerSettings = _currentSettings();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _snackbarNotifier = SnackbarNotifier(context: context);
    }
  }

  Future<void> _loadProfile() async {
    await ProfileInfoController.loadProfile(
      snackbarNotifier: _isInitialized ? _snackbarNotifier : null,
    );
    if (_profileData.hasLoaded) {
      _lastServerSettings = _currentSettings();
    }
  }

  NotificationSettingsRequestModel _currentSettings() {
    return NotificationSettingsRequestModel(
      ticketAlerts: _profileData.ticketAlerts,
      licenseExpiryAlerts: _profileData.licenseExpiryAlerts,
      inactiveAlerts: _profileData.inactiveAlerts,
      teenDriverAlerts: _profileData.teenDriverAlerts,
      communityAlerts: _profileData.communityAlerts,
    );
  }

  bool _settingsMatch(
    NotificationSettingsRequestModel settings,
    ProfileData data,
  ) {
    return settings.ticketAlerts == data.ticketAlerts &&
        settings.licenseExpiryAlerts == data.licenseExpiryAlerts &&
        settings.inactiveAlerts == data.inactiveAlerts &&
        settings.teenDriverAlerts == data.teenDriverAlerts &&
        settings.communityAlerts == data.communityAlerts;
  }

  void _applySettings(NotificationSettingsRequestModel settings) {
    _profileData.updateNotificationSettings(
      ticketAlerts: settings.ticketAlerts,
      licenseExpiryAlerts: settings.licenseExpiryAlerts,
      inactiveAlerts: settings.inactiveAlerts,
      teenDriverAlerts: settings.teenDriverAlerts,
      communityAlerts: settings.communityAlerts,
    );
  }

  void _scheduleSave() {
    _saveDebounce?.cancel();
    final nextSettings = _currentSettings();
    if (_isSaving) {
      _queuedSettings = nextSettings;
      return;
    }
    _saveDebounce = Timer(
      const Duration(milliseconds: 300),
      () => _commitSettings(nextSettings),
    );
  }

  Future<void> _commitSettings(
    NotificationSettingsRequestModel settings,
  ) async {
    if (_isSaving) {
      _queuedSettings = settings;
      return;
    }

    setState(() => _isSaving = true);
    final previousSettings = _lastServerSettings ?? _currentSettings();
    final profileInterface = Get.find<ProfileInterface>();
    final result =
        await profileInterface.updateNotificationSettings(param: settings);

    result.fold(
      (failure) {
        if (_settingsMatch(settings, _profileData)) {
          _applySettings(previousSettings);
        }
        _snackbarNotifier.notifyError(
          message:
              failure.uiMessage.isNotEmpty ? failure.uiMessage : 'Update failed',
        );
      },
      (success) {
        _lastServerSettings = settings;
        _snackbarNotifier.notifySuccess(message: success.message);
      },
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (_queuedSettings != null) {
      final queued = _queuedSettings!;
      _queuedSettings = null;
      _commitSettings(queued);
    }
  }

  void _onToggle({
    required bool ticketAlerts,
    required bool licenseExpiryAlerts,
    required bool inactiveAlerts,
    required bool teenDriverAlerts,
    required bool communityAlerts,
  }) {
    _profileData.updateNotificationSettings(
      ticketAlerts: ticketAlerts,
      licenseExpiryAlerts: licenseExpiryAlerts,
      inactiveAlerts: inactiveAlerts,
      teenDriverAlerts: teenDriverAlerts,
      communityAlerts: communityAlerts,
    );
    _scheduleSave();
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: ProfileInfoController.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return AnimatedBuilder(
            animation: _profileData,
            builder: (context, _) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  NotificationTile(
                    title: 'Tickets alerts',
                    value: _profileData.ticketAlerts,
                    onChanged: (value) {
                      _onToggle(
                        ticketAlerts: value,
                        licenseExpiryAlerts: _profileData.licenseExpiryAlerts,
                        inactiveAlerts: _profileData.inactiveAlerts,
                        teenDriverAlerts: _profileData.teenDriverAlerts,
                        communityAlerts: _profileData.communityAlerts,
                      );
                    },
                  ),
                  NotificationTile(
                    title: 'License Expiry alerts',
                    value: _profileData.licenseExpiryAlerts,
                    onChanged: (value) {
                      _onToggle(
                        ticketAlerts: _profileData.ticketAlerts,
                        licenseExpiryAlerts: value,
                        inactiveAlerts: _profileData.inactiveAlerts,
                        teenDriverAlerts: _profileData.teenDriverAlerts,
                        communityAlerts: _profileData.communityAlerts,
                      );
                    },
                  ),
                  NotificationTile(
                    title: 'Inactive alert',
                    value: _profileData.inactiveAlerts,
                    onChanged: (value) {
                      _onToggle(
                        ticketAlerts: _profileData.ticketAlerts,
                        licenseExpiryAlerts: _profileData.licenseExpiryAlerts,
                        inactiveAlerts: value,
                        teenDriverAlerts: _profileData.teenDriverAlerts,
                        communityAlerts: _profileData.communityAlerts,
                      );
                    },
                  ),
                  NotificationTile(
                    title: 'Teen driver alerts',
                    value: _profileData.teenDriverAlerts,
                    onChanged: (value) {
                      _onToggle(
                        ticketAlerts: _profileData.ticketAlerts,
                        licenseExpiryAlerts: _profileData.licenseExpiryAlerts,
                        inactiveAlerts: _profileData.inactiveAlerts,
                        teenDriverAlerts: value,
                        communityAlerts: _profileData.communityAlerts,
                      );
                    },
                  ),
                  NotificationTile(
                    title: 'Community alerts',
                    value: _profileData.communityAlerts,
                    onChanged: (value) {
                      _onToggle(
                        ticketAlerts: _profileData.ticketAlerts,
                        licenseExpiryAlerts: _profileData.licenseExpiryAlerts,
                        inactiveAlerts: _profileData.inactiveAlerts,
                        teenDriverAlerts: _profileData.teenDriverAlerts,
                        communityAlerts: value,
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
