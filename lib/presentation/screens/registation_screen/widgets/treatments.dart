import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus_machine_test/provider/Patient_provider.dart';
import 'package:provider/provider.dart';

import '../../../../model/treatment_list_model.dart';
import '../../../../model/tremnetSelection_model.dart';
import '../../../../utils/Dialogbox_util.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/field_widgets.dart';

class TreatmentsSection extends StatelessWidget {
  const TreatmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(builder: (context, treatment, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Treatments',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Column(
              children: List.generate(
            treatment.selectedTretment.length ?? 0,
            (index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF000000).withOpacity(.05)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$index.",
                            style: TextStyle(
                              color: const Color(0xFF404040),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        treatment.selectedTretment[index]
                                                .treatments.name ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        treatment.removeTreatment(treatment
                                            .selectedTretment[index].id);
                                      },
                                      child: const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Male',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      height: 26.h,
                                      width: 44.h,
                                      child: Text(
                                        treatment
                                            .selectedTretment[index].maleCount
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const Flexible(
                                        child: SizedBox(
                                      width: 20,
                                    )),
                                    Text(
                                      'Female',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      height: 26.h,
                                      width: 44.h,
                                      child: Text(
                                        treatment
                                            .selectedTretment[index].femaleCount
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    const Icon(Icons.edit)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
          CustomButton(
            text: '+ Add Treatments',
            onPress: () {
              dialogBox(context: context, content: Content());
            },
            bgColor: const Color(0xFF006837).withOpacity(0.2),
          ),
        ],
      );
    });
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(builder: (context, treatment, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Register.dropDown(
            hint: "Select the treatments",
            heading: 'Treatments',
            context: context,
            value: treatment.selectedTretmet,
            items: treatment.treatmentList?.treatments?.map((items) {
              return DropdownMenuItem(
                value: items.name ?? "",
                child: Text(
                  items.name ?? "",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? item) {
              treatment.selectedTretmet = item;
              treatment.selectedTretmetId = treatment.treatmentList?.treatments
                  ?.firstWhere((element) => element.name == item)
                  .id;
              treatment.notifyListeners();
            },
          ),
          Text(
            'Add Patients',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                height: 50.h,
                width: 120.h,
                child: Text(
                  'Male',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  treatment.miniusCount(ismale: true);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                height: 50.h,
                width: 44.h,
                child: Text(
                  treatment.maleCount.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  treatment.addCount(ismale: true);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                height: 50.h,
                width: 120.h,
                child: Text(
                  'Female',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  treatment.miniusCount(ismale: false);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                height: 50.h,
                width: 44.h,
                child: Text(
                  treatment.femaleCount.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  treatment.addCount(ismale: false);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          CustomButton(
            text: "Save",
            onPress: () {
              treatment.addTreatments(
                context: context,
              );
            },
          ),
        ],
      );
    });
  }
}
