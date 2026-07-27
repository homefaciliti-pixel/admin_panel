import 'package:flutter/material.dart';

class BookServiceViewModel extends ChangeNotifier {
  bool loading = false;

  bool autoAssign = true;

  String? selectedService;

  String? selectedPartner;

  DateTime? selectedDate;

  String? selectedTime;

  String priority = "Normal";

  final TextEditingController instructionController = TextEditingController();

  bool get isValid =>
      selectedService != null &&
      selectedPartner != null &&
      selectedDate != null &&
      selectedTime != null;

  void selectService(String value) {
    selectedService = value;
    notifyListeners();
  }

  void selectPartner(String value) {
    selectedPartner = value;
    notifyListeners();
  }

  void selectDate(String value) {
    selectedDate = value as DateTime?;
    notifyListeners();
  }

  void selectTime(String value) {
    selectedTime = value;
    notifyListeners();
  }

  void changePriority(String value) {
    priority = value;
    notifyListeners();
  }

  Future<bool> createBooking() async {
    if (!isValid) return false;

    loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    loading = false;

    notifyListeners();

    return true;
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  final Set<String> selectedInstructions = {};

  void toggleInstruction(String instruction) {
    if (selectedInstructions.contains(instruction)) {
      selectedInstructions.remove(instruction);
    } else {
      selectedInstructions.add(instruction);
    }

     notifyListeners();
  }

  void changeAutoAssign(bool value) {
    autoAssign = value;

    if (value) {
      selectedPartner = null;
    }

    notifyListeners();
  }
}
