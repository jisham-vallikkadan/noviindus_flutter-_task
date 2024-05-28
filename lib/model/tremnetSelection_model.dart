import 'package:noviindus_machine_test/model/treatment_list_model.dart';

class TreatmentSelection {
  final int id;
  final int maleCount;
  final int femaleCount;
  Treatments treatments;
  TreatmentSelection({required this.maleCount, required this.femaleCount, required this.treatments,
  required this.id
  });
}
