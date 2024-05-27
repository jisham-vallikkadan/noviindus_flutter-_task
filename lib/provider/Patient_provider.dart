import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:noviindus_machine_test/service/patient_service.dart';

import '../model/patientList_model.dart';

class PatientProvider with ChangeNotifier {
  bool isLoading = false;
  PatientListModel? patientList;

  fetchPatientList({
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    patientList = (await PatientService().getPatientList(
      context: context,
    ))!;
    print('----${jsonEncode(patientList)}');
    isLoading = false;
    notifyListeners();
  }


  String date(String? date) {
    String? created;
    created = date ?? "";
    if (created != '') {
      DateTime dateTime = DateTime.parse(created);
      String? createdAt;
      createdAt = '${dateTime.month}/${dateTime.day}/${dateTime.year}';
      return createdAt;
    } else {
      return '';
    }
  }
}
