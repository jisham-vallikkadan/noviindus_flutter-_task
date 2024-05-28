import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus_machine_test/model/patientList_model.dart';
import 'package:noviindus_machine_test/presentation/common_widgets/custom_button.dart';
import 'package:noviindus_machine_test/presentation/screens/registation_screen/widgets/treatments.dart';
import 'package:noviindus_machine_test/provider/Patient_provider.dart';
import 'package:noviindus_machine_test/utils/toast_util.dart';
import 'package:provider/provider.dart';

import '../../../model/treatment_list_model.dart';
import '../../common_widgets/field_widgets.dart';

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({super.key});

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<PatientProvider>(context, listen: false);
    provider.fetchBarnchList(context: context);
    provider.fetchTreatMentList(context: context);
    provider.initLoading();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Provider.of<PatientProvider>(context, listen: false).ctrlDispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.notifications_none_outlined),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size(ScreenUtil().screenWidth, 15),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: const Color(0xFF404040),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<PatientProvider>(builder: (context, register, _) {
                final hoursList = register.generateHoursList();
                final miutsList = register.generateMinutsList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Register.text(
                      heading: 'Name',
                      hintText: 'Enter your full name',
                      controller: register.nameCtrl,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Name ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Register.text(
                      keyboardType: TextInputType.number,
                      heading: 'Whatsapp Number',
                      hintText: 'Enter your Whatsapp number',
                      controller: register.phoneCtrl,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Phone number ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Register.text(
                      heading: 'Address',
                      hintText: 'Enter your full address',
                      controller: register.addressCtrl,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Address ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Register.dropDown(
                      validator: (val) {
                        if (val == null) {
                          return "Select Location ";
                        } else {
                          return null;
                        }
                      },
                      hint: "Select the Location",
                      heading: 'Location',
                      context: context,
                      value: register.selectedLocation,
                      items: register.location.map((items) {
                        return DropdownMenuItem(
                          value: items ?? "",
                          child: Text(
                            items ?? "",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? item) {
                        register.selectedLocation = item;
                        register.notifyListeners();
                      },
                    ),
                    Register.dropDown(
                      validator: (val) {
                        if (val == null) {
                          return "Select branch ";
                        } else {
                          return null;
                        }
                      },
                      hint: "Select the branch",
                      heading: 'Branch',
                      context: context,
                      value: register.selectedBranch,
                      items: register.branchList?.branches?.map((items) {
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
                        register.selectedBranch = item;
                        register.notifyListeners();
                      },
                    ),
                    const TreatmentsSection(),
                    Register.radioBtn(
                      scrollDirection: Axis.horizontal,
                      heading: "Payment Option",
                      groupValue: register.paymentOption,
                      value: ['Cash', 'Card', 'UPI'],
                      valueNames: ['Cash', 'Card', 'UPI'],
                      onChanged: (va) {
                        register.paymentOption = va;
                        register.notifyListeners();
                      },
                    ),
                    Register.text(
                      keyboardType: TextInputType.number,
                      heading: 'Total Amount',
                      controller: register.totalamountCtrl,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Total Amount";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Register.text(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Discount Amount";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      heading: 'Discount Amount',
                      controller: register.discountAmountCtrl,
                    ),
                    Register.text(
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Advance Amount";
                          } else {
                            return null;
                          }
                        },
                        heading: 'Advance Amount',
                        controller: register.advanceAmountCtrl),
                    Register.text(
                      keyboardType: TextInputType.number,
                      heading: 'Balance Amount',
                      controller: register.balanceAmountCtrl,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Balance Amount";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Register.date(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Select Date";
                        } else {
                          return null;
                        }
                      },
                      controller:
                          TextEditingController(text: register.dateAndTime),
                      heading: 'Date of recovery',
                      onTap: () async {
                        register.dateAndTime = await register.selectDate(
                          context: context,
                        );
                        List<String> parts = register.dateAndTime!.split('-');
                        DateTime dateTime = DateTime(int.parse(parts[2]),
                            int.parse(parts[1]), int.parse(parts[0]));
                        String formattedDate =
                            "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                        register.dateAndTime = formattedDate;
                        register.notifyListeners();
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Register.dropDown(
                            validator: (val) {
                              if (val == null) {
                                return "Select Time ";
                              } else {
                                return null;
                              }
                            },
                            hint: "Hour",
                            heading: 'Treatment Time',
                            context: context,
                            value: register.hour,
                            items: hoursList.map((items) {
                              return DropdownMenuItem(
                                value: items ?? "",
                                child: Text(
                                  items ?? "",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? item) {
                              register.hour = item;
                              register.notifyListeners();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Register.dropDown(
                            validator: (val) {
                              if (val == null) {
                                return "Select Time ";
                              } else {
                                return null;
                              }
                            },
                            hint: "Minutes",
                            heading: '',
                            context: context,
                            value: register.minits,
                            items: miutsList.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? item) {
                              register.minits = item;
                              register.notifyListeners();
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      // isLoading: register.isLoadingRegister,
                      text: 'save',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          if (register.selectedTretment.isEmpty) {
                            ToastUtil.show("Select Treatment");
                          } else {
                            register.register(
                                context: context,
                                male: register.selectedTretment
                                    .map((e) => e.maleCount)
                                    .join(','),
                                female: register.selectedTretment
                                    .map((e) => e.femaleCount)
                                    .join(','),
                                branch: register.branchList?.branches
                                    ?.firstWhere((e) =>
                                        e.name == register.selectedBranch)
                                    .id
                                    .toString(),
                                treatments: register.selectedTretment
                                    .map((e) => e.treatments)
                                    .map((e) => e.id!)
                                    .join(','));
                          }
                        } else {}
                      },
                    )
                  ],
                );
              }),
            ),
          )),
    );
  }
}
