import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/model/treatment_list_model.dart';
import 'package:noviindus_machine_test/service/patient_service.dart';
import 'package:noviindus_machine_test/utils/toast_util.dart';

import '../model/branch_list_model.dart';
import '../model/patientList_model.dart';
import '../model/tremnetSelection_model.dart';
import '../service/auth_service.dart';
import '../service/pdf_service.dart';

class PatientProvider with ChangeNotifier {
  final PdfService pdfService = PdfService();
  bool isLoading = false;
  PatientListModel? patientList;
  late TextEditingController? nameCtrl;
  late TextEditingController? phoneCtrl;
  late TextEditingController? addressCtrl;
  String? selectedBranch;
  String? selectedTretmet;
  int? selectedTretmetId;
  late TextEditingController? totalamountCtrl;
  late TextEditingController? discountAmountCtrl;
  late TextEditingController? advanceAmountCtrl;
  late TextEditingController? balanceAmountCtrl;
  String? paymentOption;
  String? dateAndTime;
  String? hour;
  String? minits;

  initLoading() {
    nameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    addressCtrl = TextEditingController();
    totalamountCtrl = TextEditingController();
    discountAmountCtrl = TextEditingController();
    advanceAmountCtrl = TextEditingController();
    balanceAmountCtrl = TextEditingController();
    paymentOption = null;
    dateAndTime = null;
    hour = null;
    minits = null;
    selectedBranch = null;
    selectedTretmet = null;
    selectedTretmetId = null;
    selectedLocation = null;
    selectedTretment.clear();
  }

  ctrlDispose() {
    nameCtrl?.dispose();
    phoneCtrl?.dispose();
    addressCtrl?.dispose();
    totalamountCtrl?.dispose();
    discountAmountCtrl?.dispose();
    advanceAmountCtrl?.dispose();
    balanceAmountCtrl?.dispose();
  }

  fetchPatientList({
    required BuildContext context,
  }) async {
    if (patientList != null) {
      isLoading = true;
      notifyListeners();
    }
    patientList = await PatientService().getPatientList(
      context: context,
    );
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

  BranchListModel? branchList;
  bool branchApiLoading = false;
  List<String> location = [
    "Manjeri",
    "Perinthalmanna",
    "Tirur",
    "Malappuram Town",
    "Kondotty",
    "Kottakkal",
    "Ponnani",
    "Nilambur",
    "Vengara",
    "Tanur",
  ];

  String? selectedLocation;

  fetchBarnchList({
    required BuildContext context,
  }) async {
    branchApiLoading = true;
    notifyListeners();
    branchList = (await PatientService().getBranchList(
      context: context,
    ))!;
    print('----${jsonEncode(patientList)}');
    branchApiLoading = false;
    notifyListeners();
  }

  TreatmentListModel? treatmentList;
  bool treatmentApiLoading = false;

  fetchTreatMentList({
    required BuildContext context,
  }) async {
    treatmentApiLoading = true;
    // notifyListeners();
    treatmentList = (await PatientService().getTreatmentList(
      context: context,
    ))!;
    print('----${jsonEncode(patientList)}');
    treatmentApiLoading = false;
    notifyListeners();
  }

  int maleCount = 0;
  int femaleCount = 0;

  addCount({bool? ismale}) {
    print(ismale);
    if (ismale == true) {
      maleCount = maleCount + 1;
      notifyListeners();
    } else {
      femaleCount = femaleCount + 1;
      print(femaleCount);
      notifyListeners();
    }
  }

  miniusCount({bool? ismale}) {
    print(ismale);
    if (ismale == true) {
      if (maleCount != 0) {
        maleCount = maleCount - 1;
        notifyListeners();
      }
    } else {
      if (femaleCount != 0) {
        femaleCount = femaleCount - 1;
        print(femaleCount);
        notifyListeners();
      }
    }
  }

  List<TreatmentSelection> selectedTretment = <TreatmentSelection>[];
  int currentId = 0;

  addTreatments({
    BuildContext? context,
  }) {
    if (selectedTretmetId == null) {
      ToastUtil.show("Select Treatment");
    } else if (maleCount == 0 && femaleCount == 0) {
      ToastUtil.show("Add PatientCount");
    } else {
      Treatments? tretment;
      tretment = treatmentList?.treatments
          ?.firstWhere((element) => element.id == selectedTretmetId);
      print(jsonEncode(tretment));
      Navigator.pop(context!);
      currentId++;
      selectedTretment.add(TreatmentSelection(
          femaleCount: femaleCount,
          maleCount: maleCount,
          treatments: tretment!,
          id: currentId));
      selectedTretmetId = null;
      selectedTretmet = null;
      maleCount = 0;
      femaleCount = 0;
      notifyListeners();
    }
  }

  removeTreatment(int id) {
    selectedTretment.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  String? ownerFromDate;
  String? ownerToDate;
  Future<String?> selectDate({
    BuildContext? context,
  }) async {
    String? pikedDate;
    final DateTime? picked = await showDatePicker(
        context: context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    // return picked.toString();
    if (picked != null) {
      pikedDate = '${picked.day}-${picked.month}-${picked.year}';
    }
    return pikedDate;
  }

  List<String> generateHoursList() {
    return List<String>.generate(12, (index) => (index + 1).toString());
  }

  List<String> generateMinutsList() {
    return List<String>.generate(60, (index) => (index + 1).toString());
  }

  bool isLoadingRegister = false;
  register({
    required BuildContext context,
    String? male,
    String? female,
    String? treatments,
    String? branch,
  }) async {
    isLoadingRegister = true;
    print('---------$male');
    print('---------$female');
    print('---------$treatments');
    print(branch);
    print('$dateAndTime-----$hour-----$minits');
    String date = '$dateAndTime-$hour:$minits AM';
    print(date);
    notifyListeners();

    var respoce = await AuthService().register(
      context: context,
      treatments: treatments,
      name: nameCtrl?.text,
      address: addressCtrl?.text,
      phone: phoneCtrl?.text,
      advanceamount: advanceAmountCtrl?.text,
      balanceamount: balanceAmountCtrl?.text,
      branch: branch,
      datendtime: date,
      discountamount: discountAmountCtrl?.text,
      female: female,
      male: male,
      payment: paymentOption ?? "Cash",
      totalamount: totalamountCtrl?.text,
    );

    if (respoce['status'] == true) {
      ToastUtil.show(respoce['message']);
      final data = await pdfService.generatePdf(
          name: nameCtrl!.text,
          totalamount: totalamountCtrl?.text,
          phone: phoneCtrl?.text,
          address: addressCtrl?.text,
          advanve: advanceAmountCtrl?.text,
          balance: balanceAmountCtrl?.text,
          discount: discountAmountCtrl?.text,
          tretmentList: selectedTretment,
          date: dateAndTime,
          time: '$hour:$minits ');
      pdfService.savefile('test', data);
      Navigator.pop(context);
      fetchPatientList(context: context);
    } else {
      ToastUtil.show(respoce['message']);
    }
    isLoadingRegister = false;
    notifyListeners();
  }
}
