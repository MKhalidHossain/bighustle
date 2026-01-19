class NotificationSettingsRequestModel {
  final bool ticketAlerts;
  final bool licenseExpiryAlerts;
  final bool inactiveAlerts;
  final bool teenDriverAlerts;
  final bool communityAlerts;

  NotificationSettingsRequestModel({
    required this.ticketAlerts,
    required this.licenseExpiryAlerts,
    required this.inactiveAlerts,
    required this.teenDriverAlerts,
    required this.communityAlerts,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketAlerts': ticketAlerts,
      'licenseExpiryAlerts': licenseExpiryAlerts,
      'inactiveAlerts': inactiveAlerts,
      'teenDriverAlerts': teenDriverAlerts,
      'communityAlerts': communityAlerts,
    };
  }
}
