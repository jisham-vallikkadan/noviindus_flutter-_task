import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus_machine_test/presentation/common_widgets/custom_button.dart';
import 'package:noviindus_machine_test/presentation/common_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../../provider/Patient_provider.dart';
import '../registation_screen/registration_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PatientProvider>(context, listen: false)
        .fetchPatientList(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'Register Now',
          onPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPatient(),
                ));
          },
        ),
      ),
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
      ),
      body: Consumer<PatientProvider>(builder: (context, patient, _) {
        return RefreshIndicator(
          color: Colors.green,
          onRefresh: () async {
            patient.fetchPatientList(context: context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: CustomTextField(
                          fillColor: Colors.white,
                          hintText: 'Search for treatments',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomButton(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          onPress: () {},
                          text: 'Search',
                          size: const Size(70, 50),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: patient.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        )
                      : (patient.patientList?.patient?.length ?? 0) > 0
                          ? ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (context, index) {
                                var data = patient.patientList?.patient![index];
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF000000)
                                          .withOpacity(.05)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data?.name ?? '',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    (data!.patientdetailsSet!
                                                        .map((elemnet) =>
                                                            elemnet
                                                                .treatmentName)
                                                        .toList()
                                                        .join(", ")
                                                        .toString()),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF006837),
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        height: 2),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_sharp,
                                                        size: 15,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        patient.date(
                                                            data.createdAt),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const Flexible(
                                                          child: SizedBox(
                                                        width: 20,
                                                      )),
                                                      const Icon(
                                                        size: 15,
                                                        Icons.person_add_alt,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        data.user ?? '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "View Booking details",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                                Icons.arrow_forward_ios_sharp)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount:
                                  patient.patientList?.patient?.length ?? 0)
                          : Text('no patiem'),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
