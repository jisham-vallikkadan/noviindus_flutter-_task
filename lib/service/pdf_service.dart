import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../model/tremnetSelection_model.dart';

class PdfService {
  Future<Uint8List> generatePdf({
    String? name,
    String? address,
    String? phone,
    String? totalamount,
    String? discount,
    String? balance,
    String? advanve,
    String? date,
    String? time,
    List<TreatmentSelection>? tretmentList,
  }) async {
    final pdf = pw.Document();
    final image = (await rootBundle.load('assets/images/bgimage.png'))
        .buffer
        .asUint8List();
    final logo = (await rootBundle.load('assets/images/splash_icon.png'))
        .buffer
        .asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
              decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                      image: pw.MemoryImage(image,), fit: pw.BoxFit.fill)),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: pw.BoxDecoration(
                              image: pw.DecorationImage(
                                  image: pw.MemoryImage(logo),
                                  fit: pw.BoxFit.fill))),
                      pw.Spacer(),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "KUMARAKOM",
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563",
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                color: PdfColors.grey,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "e-mail: unknown@gmail.com",
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                color: PdfColors.grey,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "Mob: +91 9876543210 | +91 9786543210",
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                color: PdfColors.grey,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "GST No: 32AABCU9603R1ZW",
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ])
                    ]),
                    pw.Divider(),
                    pw.Text(
                      "Patient Details",
                      style: pw.TextStyle(
                        fontSize: 13.0,
                        color: PdfColors.green,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    patientDetails(
                        questionone: 'Name',
                        answeOne: name ?? '',
                        questionTwo: 'Booked On',
                        answerTwo: '31/01/2024 | 12:12pm'),
                    patientDetails(
                        questionone: 'Address',
                        answeOne: address ?? '',
                        questionTwo: 'Treatment Date',
                        answerTwo: date ?? ""),
                    patientDetails(
                        questionone: 'WhatsApp Number',
                        answeOne: phone ?? '',
                        questionTwo: 'Treatment Time ',
                        answerTwo: time ?? ""),
                    pw.SizedBox(height: 10),
                    pw.Divider(),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 5,
                        child: pw.Text(
                          "Treatment",
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.green,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Price",
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.green,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Male",
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.green,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Female",
                          style: pw.TextStyle(
                            fontSize: 13.0,
                            color: PdfColors.green,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Text(
                        "Total",
                        style: pw.TextStyle(
                          fontSize: 13.0,
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ]),
                    pw.ListView.separated(
                        padding: const pw.EdgeInsets.symmetric(vertical: 15),
                        itemBuilder: (context, index) {
                          var totalpetientCount =
                              tretmentList![index].femaleCount +
                                  tretmentList[index].maleCount;
                          return pw.Row(children: [
                            pw.Expanded(
                              flex: 5,
                              child: pw.Text(
                                tretmentList![index].treatments.name ?? "",
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                tretmentList[index].treatments.price ?? "",
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                tretmentList[index].maleCount.toString(),
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                tretmentList[index].femaleCount.toString(),
                                style: pw.TextStyle(
                                  fontSize: 13.0,
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ),
                            pw.Text(
                              '${totalpetientCount * (int.parse(tretmentList[index].treatments.price.toString()))}',
                              style: pw.TextStyle(
                                fontSize: 13.0,
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ]);
                        },
                        separatorBuilder: (context, index) =>
                            pw.SizedBox(height: 10),
                        itemCount: tretmentList?.length ?? 0),
                    pw.SizedBox(height: 10),
                    pw.Divider(),
                    pw.Align(
                        alignment: pw.Alignment.topRight,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.SizedBox(
                                      width: 100.w,
                                      child: pw.Text(
                                        "Total Amount",
                                        style: pw.TextStyle(
                                          fontSize: 10.0,
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    pw.Text(
                                      totalamount ?? '',
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.SizedBox(
                                      width: 100.w,
                                      child: pw.Text(
                                        "Discount",
                                        style: pw.TextStyle(
                                          fontSize: 10.0,
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    pw.Text(
                                      discount ?? '',
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.SizedBox(
                                      width: 100.w,
                                      child: pw.Text(
                                        "Advance",
                                        style: pw.TextStyle(
                                          fontSize: 10.0,
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    pw.Text(
                                      advanve ?? "",
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              pw.Divider(indent: 300.w),
                              pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.SizedBox(
                                      width: 100.w,
                                      child: pw.Text(
                                        "Balance",
                                        style: pw.TextStyle(
                                          fontSize: 10.0,
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    pw.Text(
                                      balance ?? "",
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              pw.SizedBox(height: 25.h),
                              pw.Text(
                                "Thank you for choosing us",
                                style: pw.TextStyle(
                                  fontSize: 16.0,
                                  color: PdfColors.green,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(
                                width: ScreenUtil().screenWidth / 1.8,
                                child: pw.Text(
                                  "Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                                  style: pw.TextStyle(
                                    fontSize: 8.0,
                                    color: PdfColors.grey,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              )
                            ]))
                  ])); // Center
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget patientDetails(
      {String? questionone,
      String? answeOne,
      String? questionTwo,
      String? answerTwo}) {
    return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 2),
        child: pw.Row(
          children: [
            pw.SizedBox(
              width: 150.w,
              child: pw.Text(
                questionone ?? "WhatsApp Number",
                style: pw.TextStyle(
                  fontSize: 10.0,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(
              width: 150.w,
              child: pw.Text(
                answeOne ?? "+91 987654321",
                style: pw.TextStyle(
                  fontSize: 10.0,
                  color: PdfColors.grey,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(child: pw.SizedBox()),
            pw.SizedBox(
              width: 100.w,
              child: pw.Text(
                questionTwo ?? "WhatsApp Number",
                style: pw.TextStyle(
                  fontSize: 10.0,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(
              width: 100.w,
              child: pw.Text(
                answerTwo ?? "+91 987654321",
                style: pw.TextStyle(
                  fontSize: 10.0,
                  color: PdfColors.grey,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> savefile(String filename, Uint8List byteList) async {
    final pdf = pw.Document();
    final output = await getTemporaryDirectory();
    final filepath = "${output.path}/$filename.pdf";
    final file = File("${output.path}/$filename.pdf");
    await file.writeAsBytes(byteList);
    await OpenFile.open(filepath);
  }
}
