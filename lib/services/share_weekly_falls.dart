import 'dart:io';
import 'dart:typed_data';

import 'package:companera/services/db.dart';
import 'package:companera/utils/timestampFormatter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:collection/collection.dart';


import '../model/fall.dart';

shareWeeklyFalls(List<Fall> falls) async {
  final pdf = pw.Document();
  final font = await PdfGoogleFonts.montserratRegular();
  final fontMedium = await PdfGoogleFonts.montserratMedium();

  List<Fall> sundayFalls = falls
      .where((element) => element.timestamp.toDate().weekday == DateTime.sunday)
      .toList();
  List<Fall> mondayFalls = falls
      .where((element) => element.timestamp.toDate().weekday == DateTime.monday)
      .toList();
  List<Fall> tuesdayFalls = falls
      .where(
          (element) => element.timestamp.toDate().weekday == DateTime.tuesday)
      .toList();
  List<Fall> wednesdayFalls = falls
      .where(
          (element) => element.timestamp.toDate().weekday == DateTime.wednesday)
      .toList();
  List<Fall> thursdayFalls = falls
      .where(
          (element) => element.timestamp.toDate().weekday == DateTime.thursday)
      .toList();
  List<Fall> fridayFalls = falls
      .where((element) => element.timestamp.toDate().weekday == DateTime.friday)
      .toList();
  List<Fall> saturdayFalls = falls
      .where(
          (element) => element.timestamp.toDate().weekday == DateTime.saturday)
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
              pw.Text("${DB().signedInUser?.displayName}'s fall statistics for this week", style: pw.TextStyle(font: fontMedium)),
              pw.Text('Sunday',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: sundayFalls.length == 0
                      ? pw.Text('No falls recorded on Sunday',
                          style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                              pw.Text(
                                  'Total number of falls: ${sundayFalls.length}',
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
                                ...sundayFalls.mapIndexed(
                                  (index, fall) => pw.TableRow(
                                      children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              pw.Text('Monday',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: mondayFalls.length == 0
                      ? pw.Text('No falls recorded on Monday',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${mondayFalls.length}',
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
                              ...mondayFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              pw.Text('Tuesday',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: tuesdayFalls.length == 0
                      ? pw.Text('No falls recorded on Tuesday',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${tuesdayFalls.length}',
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
                              ...tuesdayFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              pw.Text('Wednesday',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: wednesdayFalls.length == 0
                      ? pw.Text('No falls recorded on Wednesday',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${wednesdayFalls.length}',
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
                              ...wednesdayFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              pw.Text('Thursday',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: thursdayFalls.length == 0
                      ? pw.Text('No falls recorded on Thursday',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${thursdayFalls.length}',
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
                              ...thursdayFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              pw.Text('Friday',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: fridayFalls.length == 0
                      ? pw.Text('No falls recorded on Friday',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${fridayFalls.length}',
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
                              ...fridayFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
              pw.Text('Saturday',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 10
                  )),
              pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: saturdayFalls.length == 0
                      ? pw.Text('No falls recorded on Saturday',
                      style: pw.TextStyle(font: font, fontSize: 8))
                      : pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            'Total number of falls: ${saturdayFalls.length}',
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
                              ...saturdayFalls.mapIndexed(
                                    (index, fall) => pw.TableRow(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'Weekly Fall Statistics.pdf');
}
