import 'package:flutter/material.dart';
import 'package:sdgs_frontend/susForm.dart';

class SusFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  SusForm susForm;

  SusFormProvider(this.susForm);

  // updateAvailability(bool value) {
  //   print(value);
  //   this.susForm.available = value;
  //   notifyListeners();
  // }

  // bool isValidForm() {
  //   print(susForm.answerEco);
  //   print(susForm.answerEnv);
  //   print(susForm.available);

  //   return formKey.currentState?.validate() ?? false;
  // }
}
