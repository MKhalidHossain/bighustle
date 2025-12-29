import 'package:flutter/material.dart';

import '../controller/license_info_controller.dart';
import '../widget/license_edit_field.dart';
import '../widget/license_status_card.dart';

class EditLicenseInfoScreen extends StatefulWidget {
  const EditLicenseInfoScreen({super.key});

  @override
  State<EditLicenseInfoScreen> createState() => _EditLicenseInfoScreenState();
}

class _EditLicenseInfoScreenState extends State<EditLicenseInfoScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _licenseNoController;
  late final TextEditingController _stateController;
  late final TextEditingController _dobController;
  late final TextEditingController _expireController;

  @override
  void initState() {
    super.initState();
    final info = LicenseInfoController.notifier.value;
    _nameController = TextEditingController(text: info.name);
    _licenseNoController = TextEditingController(text: info.licenseNo);
    _stateController = TextEditingController(text: info.state);
    _dobController = TextEditingController(text: info.dateOfBirth);
    _expireController = TextEditingController(text: info.expireDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _licenseNoController.dispose();
    _stateController.dispose();
    _dobController.dispose();
    _expireController.dispose();
    super.dispose();
  }

  void _saveAndClose() {
    final info = LicenseInfoController.notifier.value;
    LicenseInfoController.update(
      info.copyWith(
        name: _nameController.text.trim(),
        licenseNo: _licenseNoController.text.trim(),
        state: _stateController.text.trim(),
        dateOfBirth: _dobController.text.trim(),
        expireDate: _expireController.text.trim(),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final info = LicenseInfoController.notifier.value;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit License Info',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          LicenseStatusCard(
            status: info.status,
            validity: info.validity,
            expiryDate: info.expiryShort,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 30,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFEDEDED),
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Color(0xFF2F2F2F)),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Upload new photo +',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 140,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/drivingLicence.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
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
                  'License Information',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                LicenseEditField(label: 'Name', controller: _nameController),
                LicenseEditField(
                  label: 'License No',
                  controller: _licenseNoController,
                ),
                LicenseEditField(label: 'State', controller: _stateController),
                LicenseEditField(
                  label: 'Date of birth',
                  controller: _dobController,
                ),
                LicenseEditField(
                  label: 'Expire Date',
                  controller: _expireController,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: _saveAndClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976F3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
