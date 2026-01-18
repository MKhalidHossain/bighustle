import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_bighustle/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_bighustle/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_bighustle/moduls/home/controller/teen_driver_experience_controller.dart';
import 'package:flutter_bighustle/moduls/home/implement/teen_driver_experience_interface_impl.dart';
import 'package:flutter_bighustle/moduls/home/interface/teen_driver_experience_interface.dart';

class AddTeenDriverExperienceScreen extends StatefulWidget {
  const AddTeenDriverExperienceScreen({super.key});

  @override
  State<AddTeenDriverExperienceScreen> createState() =>
      _AddTeenDriverExperienceScreenState();
}

class _AddTeenDriverExperienceScreenState
    extends State<AddTeenDriverExperienceScreen> {
  static const Color _background = Color(0xFFF2F2F2);
  static const Color _primaryBlue = Color(0xFF3F76F6);
  static const Color _borderColor = Color(0xFFBDBDBD);

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  late final TeenDriverExperienceController _controller;
  bool _initialized = false;
  bool _isSubmitting = false;

  void _onControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _fileController.dispose();
    if (_initialized) {
      _controller.removeListener(_onControllerUpdate);
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      if (!Get.isRegistered<TeenDriverExperienceInterface>()) {
        Get.put<TeenDriverExperienceInterface>(
          TeenDriverExperienceInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
        );
      }
      _controller = TeenDriverExperienceController(
        SnackbarNotifier(context: context),
      );
      _controller.addListener(_onControllerUpdate);
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile == null) {
      return;
    }
    final fileName = pickedFile.name.isNotEmpty
        ? pickedFile.name
        : pickedFile.path.split('/').last;
    setState(() {
      _fileController.text = fileName;
    });
    _controller.mediaPath = pickedFile.path;
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    final success = await _controller.submit();
    if (!mounted) {
      return;
    }
    setState(() => _isSubmitting = false);
    if (success) {
      _titleController.clear();
      _descriptionController.clear();
      _fileController.clear();
      _controller.title = '';
      _controller.description = '';
      _controller.mediaPath = '';
    }
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
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
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add teen driver experience',
          style: TextStyle(
            fontSize: (size.width * 0.055).clamp(18.0, 24.0),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111111),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111111)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                    Text(
                      'Personal Info',
                      style: TextStyle(
                        fontSize: (size.width * 0.048).clamp(16.0, 20.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Post Title',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _titleController,
                      onChanged: (value) => _controller.title = value,
                      decoration: _inputDecoration('Write here'),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Post description',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 8,
                      minLines: 6,
                      onChanged: (value) => _controller.description = value,
                      decoration: _inputDecoration('Write here'),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Upload Photo',
                      style: TextStyle(
                        fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextField(
                      controller: _fileController,
                      readOnly: true,
                      onTap: _pickImage,
                      decoration: _inputDecoration('Select a file (jpg/png)')
                          .copyWith(
                        suffixIcon: IconButton(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.attach_file),
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
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
                  onPressed:
                      _controller.canSubmit && !_isSubmitting ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          'Submit',
                          style: TextStyle(
                            fontSize:
                                (size.width * 0.05).clamp(16.0, 20.0),
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
