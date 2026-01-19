import 'package:flutter/material.dart';

import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../controller/profile_info_controller.dart';
import '../../model/profile_data.dart';
import '../widget/driving_license_card.dart';
import '../widget/ticket_table.dart';
import 'personal_info_edit_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  static const Color _background = Color(0xFFF2F2F2);
  static const String _drivingLicenseAsset =
      'assets/images/drivingLicence.png';

  late final SnackbarNotifier _snackbarNotifier;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
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
  }

  @override
  Widget build(BuildContext context) {
    final profileData = ProfileData.instance;
    final ticketRows = [
      const TicketRow(status: 'Paid', statusColor: Color(0xFF1DB954)),
      const TicketRow(status: 'Unpaid', statusColor: Color(0xFFE53935)),
      const TicketRow(status: 'Paid', statusColor: Color(0xFF1DB954)),
      const TicketRow(status: 'Paid', statusColor: Color(0xFF1DB954)),
      const TicketRow(status: 'Unpaid', statusColor: Color(0xFFE53935)),
    ];

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PersonalInfoEditScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: ProfileInfoController.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: _loadProfile,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                AnimatedBuilder(
                  animation: profileData,
                  builder: (context, _) {
                    return Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 36,
                                backgroundColor: const Color(0xFFE1E1E1),
                                backgroundImage:
                                    profileData.avatarImageProvider,
                                child: profileData.avatarImageProvider == null
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.black45,
                                        size: 36,
                                      )
                                    : null,
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        Text(
                          profileData.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'User ID: ${profileData.userId}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${profileData.email}\n${profileData.phone}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                const DrivingLicenseCard(imageAssetPath: _drivingLicenseAsset),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE5E5E5)),
                  ),
                  child: Column(
                    children: [
                      const TicketHeader(),
                      const Divider(height: 16),
                      ...ticketRows,
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
