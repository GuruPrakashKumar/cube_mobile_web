import 'dart:io';
import 'dart:html' as html;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:shopos/src/models/input/order.dart';
import 'package:shopos/src/models/user.dart';

class PdfKotUI {
  static Future<void> generate57mmKot({
    required User user,
    required Order order,
    required List<String> headers,
    required DateTime date,
    required String invoiceNum,
  }) async {
    final pdf = pw.Document();
    final roll57 = PdfPageFormat.roll57;

    final font = await rootBundle.load('assets/OpenSans-Regular.ttf');
    final ttf = await Font.ttf(font);

    String dateFormat() => DateFormat('MMM d, y hh:mm:ss a').format(date);

    List<pw.TableRow> itemRows() => List.generate(
          (order.orderItems ?? []).length,
          (index) {
            final orderItem = order.orderItems![index];

            return pw.TableRow(children: [
              pw.Text(
                '${orderItem.product!.name}',
                style: TextStyle(font: ttf, fontSize: 8),
              ),
              pw.SizedBox(width: 30),
              pw.Text('${orderItem.quantity}',
                  style: TextStyle(font: ttf, fontSize: 8))
            ]);
          },
        );

    pdf.addPage(pw.Page(
      pageFormat: roll57,
      build: (pw.Context context) {
        return pw.Container(
          margin: pw.EdgeInsets.all(10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('KOT', style: pw.TextStyle(fontSize: 11, font: ttf)),
              pw.Text('${dateFormat()}',
                  style: pw.TextStyle(fontSize: 9, font: ttf)),
              // pw.SizedBox(height: 10),
              pw.Text('Table', style: pw.TextStyle(fontSize: 9, font: ttf)),
              pw.Text('Name : ${(order.subUserName == '' ||  order.subUserName == null ? (order.userName == null || order.userName == "" ? order.user!.businessName : order.userName) : order.subUserName)}', style: pw.TextStyle(fontSize: 9, font: ttf)),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(headers[0],
                        style: TextStyle(font: ttf, fontSize: 8)),
                    pw.Text(
                      headers[1],
                      style: TextStyle(font: ttf, fontSize: 8),
                    ),
                  ]),
              pw.Table(children: itemRows()),
            ],
          ),
        );
      },
    ));

    if(kDebugMode)print('running');

    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();

    if(kDebugMode)print('saved');
    if(kDebugMode)print('launching');
    // Get the directory for saving the PDF
    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = '${directory.path}/KOT.pdf';
    // final file = File(filePath);
    //
    // // Write the PDF to a file
    // await file.writeAsBytes(await pdf.save());

    // final bytes = File(file.path).readAsBytesSync();

    // return bytes;

    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => pdf.save());

    // try {
    //   if(kDebugMode)print('run');
    //   if(kDebugMode)print(file.path);
    //   if(kDebugMode)print(file.absolute.path);
    //   OpenFile.open(file.path);
    //   if(kDebugMode)print('done');
    // } catch (e) {
    //   if(kDebugMode)print(e);
    // }
  }

  static Future<void> generate80mmKot({
    required User user,
    required Order order,
    required List<String> headers,
    required DateTime date,
    required String invoiceNum,
  }) async {
    final pdf = pw.Document();
    final roll80 = PdfPageFormat.roll80;

    final font = await rootBundle.load('assets/OpenSans-Regular.ttf');
    final ttf = await Font.ttf(font);

    String dateFormat() => DateFormat('MMM d, y hh:mm:ss a').format(date);

    List<pw.TableRow> itemRows() => List.generate(
          (order.orderItems ?? []).length,
          (index) {
            final orderItem = order.orderItems![index];

            return pw.TableRow(children: [
              pw.Text(
                '${orderItem.product!.name}',
                style: TextStyle(font: ttf, fontSize: 8),
              ),
              pw.SizedBox(width: 30),
              pw.Text('${orderItem.quantity}',
                  style: TextStyle(font: ttf, fontSize: 8))
            ]);
          },
        );

    pdf.addPage(pw.Page(
      pageFormat: roll80,
      build: (context) {
        return pw.Container(
          margin: pw.EdgeInsets.all(10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('KOT', style: pw.TextStyle(fontSize: 11, font: ttf)),
              pw.Text('${dateFormat()}',
                  style: pw.TextStyle(fontSize: 9, font: ttf)),
              // pw.SizedBox(height: 10),
              pw.Text('Table', style: pw.TextStyle(fontSize: 9, font: ttf)),
              pw.Text('Name : ${(order.subUserName == '' ||  order.subUserName == null ? (order.userName == null || order.userName == "" ? order.user!.businessName : order.userName) : order.subUserName)}', style: pw.TextStyle(fontSize: 9, font: ttf)),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(headers[0],
                        style: TextStyle(font: ttf, fontSize: 8)),
                    pw.Text(
                      headers[1],
                      style: TextStyle(font: ttf, fontSize: 8),
                    ),
                  ]),
              pw.Table(children: itemRows()),
            ],
          ),
        );
      },
    ));

    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();

    if(kDebugMode)print('pdf save');
    if(kDebugMode)print('launching');
    // Get the directory for saving the PDF
    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = '${directory.path}/KOT.pdf';
    // final file = File(filePath);
    //
    // // Write the PDF to a file
    // await file.writeAsBytes(await pdf.save());

    // final bytes = File(file.path).readAsBytesSync();

    // return bytes;

    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => pdf.save());

    // try {
    //   if(kDebugMode)print('run');
    //   if(kDebugMode)print(file.path);
    //   if(kDebugMode)print(file.absolute.path);
    //   OpenFile.open(file.path);
    //   if(kDebugMode)print('done');
    // } catch (e) {
    //   if(kDebugMode)print(e);
    // }
  }
}
