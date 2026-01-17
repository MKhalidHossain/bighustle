import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/license_interface.dart';
import '../model/license_create_request_model.dart';

class LicenseCreateController extends ChangeNotifier {
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();
  final SnackbarNotifier snackbarNotifier;

  LicenseCreateController(this.snackbarNotifier);

  String _fullName = '';
  String _userPhoto = '';
  String _licenseNumber = '';
  String _state = '';
  String _dateOfBirth = '';
  String _expiryDate = '';
  String _licenseClass = '';
  String _licensePhoto = '';

  String get fullName => _fullName;
  String get userPhoto => _userPhoto;
  String get licenseNumber => _licenseNumber;
  String get state => _state;
  String get dateOfBirth => _dateOfBirth;
  String get expiryDate => _expiryDate;
  String get licenseClass => _licenseClass;
  String get licensePhoto => _licensePhoto;

  bool get canSubmit =>
      _fullName.isNotEmpty &&
      _userPhoto.isNotEmpty &&
      _licenseNumber.isNotEmpty &&
      _state.isNotEmpty &&
      _dateOfBirth.isNotEmpty &&
      _expiryDate.isNotEmpty &&
      _licenseClass.isNotEmpty &&
      _licensePhoto.isNotEmpty;

  void _updateButtonState() {
    if (canSubmit) {
      processStatusNotifier.setEnabled();
    } else {
      processStatusNotifier.setDisabled();
    }
  }

  set fullName(String value) {
    if (value != _fullName) {
      _fullName = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set userPhoto(String value) {
    if (value != _userPhoto) {
      _userPhoto = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set licenseNumber(String value) {
    if (value != _licenseNumber) {
      _licenseNumber = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set state(String value) {
    if (value != _state) {
      _state = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set dateOfBirth(String value) {
    if (value != _dateOfBirth) {
      _dateOfBirth = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set expiryDate(String value) {
    if (value != _expiryDate) {
      _expiryDate = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set licenseClass(String value) {
    if (value != _licenseClass) {
      _licenseClass = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  set licensePhoto(String value) {
    if (value != _licensePhoto) {
      _licensePhoto = value.trim();
      _updateButtonState();
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    if (!canSubmit) {
      snackbarNotifier.notifyError(message: 'Please fill all fields.');
      return false;
    }

    processStatusNotifier.setLoading();
    final result = await Get.find<LicenseInterface>().createLicense(
      param: LicenseCreateRequestModel(
        fullName: _fullName,
        userPhoto: _userPhoto,
        licenseNumber: _licenseNumber,
        state: _state,
        dateOfBirth: _dateOfBirth,
        expiryDate: _expiryDate,
        licenseClass: _licenseClass,
        licensePhoto: _licensePhoto,
      ),
    );

    bool success = false;
    handleFold(
      either: result,
      processStatusNotifier: processStatusNotifier,
      successSnackbarNotifier: snackbarNotifier,
      errorSnackbarNotifier: snackbarNotifier,
      onSuccess: (_) => success = true,
    );
    return success;
  }

  @override
  void dispose() {
    processStatusNotifier.dispose();
    super.dispose();
  }
}
