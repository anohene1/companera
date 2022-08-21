import 'dart:io';
import 'dart:typed_data';

import 'package:companera/services/db.dart';
import 'package:companera/utils/date_time_extension.dart';
import 'package:companera/utils/timestampFormatter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:collection/collection.dart';


import '../model/fall.dart';

shareMonthlyFalls(List<Fall> falls) async {
  final pdf = pw.Document();
  final font = await PdfGoogleFonts.montserratRegular();
  final fontMedium = await PdfGoogleFonts.montserratMedium();

  List<Fall> firstWeekFalls = falls
      .where((element) => element.timestamp.toDate().isFirstWeek())
      .toList();
  List<Fall> secondWeekFalls = falls
      .where((element) => element.timestamp.toDate().isSecondWeek())
      .toList();
  List<Fall> thirdWeekFalls = falls
      .where((element) => element.timestamp.toDate().isThirdWeek())
      .toList();
  List<Fall> fourthWeekFalls = falls
      .where((element) => element.timestamp.toDate().isLastWeek())
      .toList();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Compañera',
                  style: pw.TextStyle(font: font, fontSize: 25)),
              pw.SizedBox(height: 30),
              pw.Text("${DB().signedInUser?.displayName}'s fall statistics for ${DateFormat.yMMMM().format(DateTime.now())}", style: pw.TextStyle(font: fontMedium)),
              pw.Text('Week 1',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: firstWeekFalls.length == 0
                      ? pw.Text('No falls recorded in the first week',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${firstWeekFalls.length}',
                            style:
                            pw.TextStyle(font: font, fontSize: 8)),
                        pw.Table(
                            defaultColumnWidth: pw.FixedColumnWidth(100),
                            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                            children: [
                              pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                      child: pw.Text('Date',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Time',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4),
                                        child: pw.Text('Location',
                                            style: pw.TextStyle(
                                                font: fontMedium, fontSize: 8)),),
                                  ],
                                  decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))
                              ),
                              ...firstWeekFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                        child: pw.Text(DateFormat.yMMMMEEEEd().format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4),
                                        child: pw.Text(
                                            DateFormat.jm()
                                                .format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(vertical: 4),
                                          child: pw.UrlLink(
                                              child: pw.Text('${fall.latitude},${fall.longitude}',
                                                  style: pw.TextStyle(
                                                      font: font, fontSize: 8, color: PdfColor.fromHex('#007CF8'))),
                                              destination:
                                              'https://www.google.com/maps/search/?api=1&query=${fall.latitude},${fall.longitude}')
                                      ),
                                    ],
                                    decoration: index % 2 == 0 ? null : pw.BoxDecoration(color: PdfColor.fromHex('#D2E0FD'))
                                ),
                              ),
                            ])
                      ])),
              pw.SizedBox(height: 10),
              pw.Text('Week 2',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: secondWeekFalls.length == 0
                      ? pw.Text('No falls recorded in the second week',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${secondWeekFalls.length}',
                            style:
                            pw.TextStyle(font: font, fontSize: 8)),
                        pw.Table(
                            defaultColumnWidth: pw.FixedColumnWidth(100),
                            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                            children: [
                              pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                      child: pw.Text('Date',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Time',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Location',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),),
                                  ],
                                  decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))
                              ),
                              ...secondWeekFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                        child: pw.Text(DateFormat.yMMMMEEEEd().format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4),
                                        child: pw.Text(
                                            DateFormat.jm()
                                                .format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(vertical: 4),
                                          child: pw.UrlLink(
                                              child: pw.Text('${fall.latitude},${fall.longitude}',
                                                  style: pw.TextStyle(
                                                      font: font, fontSize: 8, color: PdfColor.fromHex('#007CF8'))),
                                              destination:
                                              'https://www.google.com/maps/search/?api=1&query=${fall.latitude},${fall.longitude}')
                                      )
                                    ],
                                    decoration: index % 2 == 0 ? null : pw.BoxDecoration(color: PdfColor.fromHex('#D2E0FD'))
                                ),
                              ),
                            ])
                      ])),
              pw.SizedBox(height: 10),
              pw.Text('Week 3',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: thirdWeekFalls.length == 0
                      ? pw.Text('No falls recorded in the third week',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${thirdWeekFalls.length}',
                            style:
                            pw.TextStyle(font: font, fontSize: 8)),
                        pw.Table(
                            defaultColumnWidth: pw.FixedColumnWidth(100),
                            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                            children: [
                              pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                      child: pw.Text('Date',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Time',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Location',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),),
                                  ],
                                  decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))
                              ),
                              ...thirdWeekFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                        child: pw.Text(DateFormat.yMMMMEEEEd().format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4),
                                        child: pw.Text(
                                            DateFormat.jm()
                                                .format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(vertical: 4),
                                          child: pw.UrlLink(
                                              child: pw.Text('${fall.latitude},${fall.longitude}',
                                                  style: pw.TextStyle(
                                                      font: font, fontSize: 8, color: PdfColor.fromHex('#007CF8'))),
                                              destination:
                                              'https://www.google.com/maps/search/?api=1&query=${fall.latitude},${fall.longitude}')
                                      )
                                    ],
                                    decoration: index % 2 == 0 ? null : pw.BoxDecoration(color: PdfColor.fromHex('#D2E0FD'))
                                ),
                              ),
                            ])
                      ])),
              pw.SizedBox(height: 10),
              pw.Text('Week 4',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: fourthWeekFalls.length == 0
                      ? pw.Text('No falls recorded in the fourth week',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${fourthWeekFalls.length}',
                            style:
                            pw.TextStyle(font: font, fontSize: 8)),
                        pw.Table(
                            defaultColumnWidth: pw.FixedColumnWidth(100),
                            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                            children: [
                              pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                      child: pw.Text('Date',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Time',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                                      child: pw.Text('Location',
                                          style: pw.TextStyle(
                                              font: fontMedium, fontSize: 8)),),
                                  ],
                                  decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))
                              ),
                              ...fourthWeekFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                        child: pw.Text(DateFormat.yMMMMEEEEd().format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4),
                                        child: pw.Text(
                                            DateFormat.jm()
                                                .format(fall.timestamp.toDate()),
                                            style: pw.TextStyle(
                                                font: font, fontSize: 8)),
                                      ),
                                      pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(vertical: 4),
                                          child: pw.UrlLink(
                                              child: pw.Text('${fall.latitude},${fall.longitude}',
                                                  style: pw.TextStyle(
                                                      font: font, fontSize: 8, color: PdfColor.fromHex('#007CF8'))),
                                              destination:
                                              'https://www.google.com/maps/search/?api=1&query=${fall.latitude},${fall.longitude}')
                                      )
                                    ],
                                    decoration: index % 2 == 0 ? null : pw.BoxDecoration(color: PdfColor.fromHex('#D2E0FD'))
                                ),
                              ),
                            ])
                      ])),
              pw.Expanded(
                child: pw.SizedBox(height: 10),
              ),
              pw.Text(
                  'Generated on ${TimestampFormatter.format(DateTime.now().millisecondsSinceEpoch)}',
                  style: pw.TextStyle(
                      font: font, fontSize: 5, color: PdfColor(0, 0, 0, 0.4)))
            ]);
      }));

  // final output = await getTemporaryDirectory();
  // final file = File("${output.path}/example.pdf");
  // await file.writeAsBytes(await pdf.save());
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'Monthly Fall Statistics.pdf');
}
