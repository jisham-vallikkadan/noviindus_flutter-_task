import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:noviindus_machine_test/model/branch_list_model.dart';
import 'package:noviindus_machine_test/model/treatment_list_model.dart';
import '../model/patientList_model.dart';
import '../utils/toast_util.dart';
import '../utils/urls.dart';
import 'network_helper.dart';

class PatientService {
  Future<PatientListModel?> getPatientList({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await NetworkHelper().getRequest(
      context: context,
      url:Urls.patientListUrl,
    );

    if (response!.statusCode == 200) {
      return  PatientListModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
    }
  }

  Future<BranchListModel?> getBranchList({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await NetworkHelper().getRequest(
      context: context,
      url:Urls.branchListUrl,
    );

    if (response!.statusCode == 200) {
      return  BranchListModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
    }
  }

  Future<TreatmentListModel?> getTreatmentList({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await NetworkHelper().getRequest(
      context: context,
      url:Urls.treatmentListUrl,
    );

    if (response!.statusCode == 200) {
      return  TreatmentListModel.fromJson(jsonDecode(response.body));
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
    }
  }
}
