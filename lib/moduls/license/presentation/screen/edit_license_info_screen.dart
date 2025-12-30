import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/license_info_controller.dart';

class EditLicenseInfoScreen extends StatefulWidget {
  const EditLicenseInfoScreen({super.key});

  @override
  State<EditLicenseInfoScreen> createState() => _EditLicenseInfoScreenState();
}

class _EditLicenseInfoScreenState extends State<EditLicenseInfoScreen> {
  static const Color _background = Color(0xFFF2F2F2);
  static const Color _primaryBlue = Color(0xFF3F76F6);
  static const Color _borderColor = Color(0xFFBDBDBD);
  static const Color _textDark = Color(0xFF222222);
  static const Color _textMuted = Color(0xFF8B8B8B);

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _licenseNoController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _userPhotoController = TextEditingController();
  final TextEditingController _licensePhotoController = TextEditingController();

  final List<String> _states = const [
    'Alabama',
    'Alaska',
    'Arizona',
    'California',
    'Florida',
    'New York',
    'Texas',
  ];
  final List<String> _licenseClasses = const [
    'Class A',
    'Class B',
    'Class C',
    'Class D',
  ];

  String? _selectedState;
  String? _selectedClass;

  @override
  void initState() {
    super.initState();
    final info = LicenseInfoController.notifier.value;
    _nameController.text = info.name;
    _licenseNoController.text = info.licenseNo;
    _expirationController.text = info.expireDate;
    _selectedState = _states.contains(info.state) ? info.state : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _licenseNoController.dispose();
    _expirationController.dispose();
    _userPhotoController.dispose();
    _licensePhotoController.dispose();
    super.dispose();
  }

  Future<void> _pickUserPhoto() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile == null) {
      return;
    }
    setState(() => _userPhotoController.text = pickedFile.name);
  }

  Future<void> _pickLicensePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile == null) {
      return;
    }
    setState(() => _licensePhotoController.text = pickedFile.name);
  }

  Future<void> _selectExpirationDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 15),
    );
    if (selected == null) {
      return;
    }
    final month = selected.month.toString().padLeft(2, '0');
    final day = selected.day.toString().padLeft(2, '0');
    _expirationController.text = '$month/$day/${selected.year}';
  }

  void _submit() {
    final name = _nameController.text.trim();
    final licenseNo = _licenseNoController.text.trim();
    final expiration = _expirationController.text.trim();
    final userPhoto = _userPhotoController.text.trim();
    final licensePhoto = _licensePhotoController.text.trim();
    if (name.isEmpty ||
        licenseNo.isEmpty ||
        expiration.isEmpty ||
        _selectedState == null ||
        _selectedClass == null ||
        userPhoto.isEmpty ||
        licensePhoto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
      return;
    }

    final info = LicenseInfoController.notifier.value;
    LicenseInfoController.update(
      info.copyWith(
        name: name,
        licenseNo: licenseNo,
        state: _selectedState,
        expireDate: expiration,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('License info submitted.')),
    );
    Navigator.of(context).pop();
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _textMuted),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _primaryBlue, width: 1.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    Center(
                      child: Text(
                        'Add Your License Info',
                        style: TextStyle(
                          fontSize: (size.width * 0.055).clamp(18.0, 24.0),
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Personal Info',
                      style: TextStyle(
                        fontSize: (size.width * 0.048).clamp(16.0, 20.0),
                        fontWeight: FontWeight.w600,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _nameController,
                      decoration: _inputDecoration('Write here'),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'User Photo',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _userPhotoController,
                      readOnly: true,
                      onTap: _pickUserPhoto,
                      decoration: _inputDecoration('Select a file (jpg/png)')
                          .copyWith(
                        suffixIcon: IconButton(
                          onPressed: _pickUserPhoto,
                          icon: const Icon(Icons.attach_file),
                          color: _textDark,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'License Number',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _licenseNoController,
                      decoration: _inputDecoration('Write here'),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'State',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    DropdownButtonFormField<String>(
                      value: _selectedState,
                      decoration: _inputDecoration('Select State'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: const Text('Select State'),
                      items: _states
                          .map(
                            (state) => DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedState = value);
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Expiration Date',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _expirationController,
                      readOnly: true,
                      onTap: _selectExpirationDate,
                      decoration: _inputDecoration('MM/DD/YYYY'),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'License Class',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    DropdownButtonFormField<String>(
                      value: _selectedClass,
                      decoration: _inputDecoration('Select Class'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: const Text('Select Class'),
                      items: _licenseClasses
                          .map(
                            (licenseClass) => DropdownMenuItem(
                              value: licenseClass,
                              child: Text(licenseClass),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedClass = value);
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Upload License Photo',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _licensePhotoController,
                      readOnly: true,
                      onTap: _pickLicensePhoto,
                      decoration: _inputDecoration('Select a file (jpg/png)')
                          .copyWith(
                        suffixIcon: IconButton(
                          onPressed: _pickLicensePhoto,
                          icon: const Icon(Icons.attach_file),
                          color: _textDark,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.fromLTRB(
                size.width * 0.06,
                size.height * 0.01,
                size.width * 0.06,
                viewInsets.bottom + size.height * 0.02,
              ),
              child: SizedBox(
                width: double.infinity,
                height: (size.height * 0.07).clamp(48.0, 58.0),
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: (size.width * 0.05).clamp(16.0, 20.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
