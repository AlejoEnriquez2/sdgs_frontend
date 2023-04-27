import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:logger/logger.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

class SusafData {
  late String feature;
  late String effect;
  late String order;
  late String dimension;

  SusafData(
      {required this.feature,
      required this.effect,
      required this.order,
      required this.dimension});

  factory SusafData.fromJson(Map<String, dynamic> json) {
    return SusafData(
      feature: json['feature'],
      effect: json['effect'],
      order: json['order'],
      dimension: json['dimension'],
    );
  }
}

List<SusafData> susafdata = [];
late final companyName;

late final opportunities;
late final threats;
late final actions;

class SusafTable extends StatefulWidget {
  final String jsonData;

  SusafTable({required this.jsonData});

  @override
  _SusafTableState createState() => _SusafTableState();
}

class _SusafTableState extends State<SusafTable> {
  // List<SusafData> susafdata = [];

  // Add a TextEditingController for each cell to handle edits
  TextEditingController idController = TextEditingController();
  TextEditingController effectController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final parsedJson = json.decode(widget.jsonData);
    final productsJson = parsedJson['features'];
    companyName = parsedJson['company_name'];
    opportunities = parsedJson['opportunities'];
    threats = parsedJson['threats'];
    actions = parsedJson['actions'];
    for (var productJson in productsJson) {
      susafdata.add(SusafData.fromJson(productJson));
    }

    Logger logger = Logger();
    logger.d(opportunities);
  }

  // Define a function to show the edit popup window
  void _showEditPopup(SusafData data) {
    idController.text = data.feature.toString();
    effectController.text = data.effect;
    orderController.text = data.order.toString();
    dimensionController.text = data.dimension;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: "Feature"),
                ),
                TextField(
                  controller: effectController,
                  decoration: const InputDecoration(labelText: "Effect"),
                  maxLines: 5,
                ),
                TextField(
                  controller: orderController,
                  decoration: const InputDecoration(labelText: "Order"),
                ),
                TextField(
                  controller: dimensionController,
                  decoration: const InputDecoration(labelText: "Dimension"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  data.feature = idController.text;
                  data.effect = effectController.text;
                  data.order = orderController.text;
                  data.dimension = dimensionController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final logger = Logger();
    int maxLength = (threats.length > opportunities.length)
        ? threats.length
        : opportunities.length;

    // logger.d(susafdata.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add your desired functionality for back button here
          },
        ),
        title: const Text("SusAF Table"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              await printTable(); // Call the function to create and print the PDF
            },
          ),
        ],
      ),
      body: Container(
        // padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                companyName,
                style: const TextStyle(fontSize: 32),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: DataTable(
                  dataRowHeight: 50,
                  showCheckboxColumn: false,
                  horizontalMargin: 20,
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(label: Text("Feature")),
                    DataColumn(label: Text("Effect")),
                    DataColumn(label: Text("Order")),
                    DataColumn(label: Text("Dimension")),
                  ],
                  rows: susafdata.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(data.feature.toString()),
                        ),
                        DataCell(
                          Wrap(children: [
                            Text(
                              data.effect,
                              maxLines: 3,
                              overflow: TextOverflow.clip,
                            ),
                          ]),
                        ),
                        DataCell(
                          Text(data.order.toString()),
                        ),
                        DataCell(
                          Text(data.dimension),
                        ),
                      ],
                      onSelectChanged: (bool? isSelected) {
                        if (isSelected!) {
                          _showEditPopup(data); // Show the edit popup
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Opportunities',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      opportunities,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Threats',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      threats,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    //////
                    const Text(
                      'Actions',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      actions,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              )

              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: threats.length,
              //   itemBuilder: (context, index) {
              //     return Text(threats.);
              //   },
              // ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: actions.length,
              //   itemBuilder: (context, index) {
              //     return Text(actions[index]);
              //   },
              // )
              // DataTable(
              //   columns: [
              //     DataColumn(label: Text('Threats')),
              //     DataColumn(label: Text('Opportunities')),
              //   ],
              //   rows: List<DataRow>.generate(
              //     maxLength,
              //     (index) => DataRow(
              //       cells: [
              //         DataCell(
              //             Text(index < threats.length ? threats[index] : '')),
              //         DataCell(Text(index < opportunities.length
              //             ? opportunities[index]
              //             : '')),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> printTable() async {
  final libreBaskerville = await PdfGoogleFonts.libreBaskervilleRegular();
  final List<String> headerTitles = ['Feature', 'Effect', 'Order', 'Dimension'];
  final List<pw.TableRow> headerRows = headerTitles.map((title) {
    return pw.TableRow(
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }).toList();

  final List<List<pw.Widget>> header =
      headerRows.map((row) => row.children).toList();

  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Table.fromTextArray(
          headerDecoration: const pw.BoxDecoration(
            color: PdfColors.grey300,
          ),
          columnWidths: {
            // work out this part
            // 0: pw.IntrinsicColumnWidth(),
            // 1: pw.FixedColumnWidth(100),
            // 2: pw.FlexColumnWidth(),

            0: const pw.IntrinsicColumnWidth(),
            1: const pw.FixedColumnWidth(250),
            2: const pw.FixedColumnWidth(100),
            3: const pw.FixedColumnWidth(100),
          },
          headers: const ['Feature', 'Effect', 'Order', 'Dimension'],
          // headers: header,
          data: susafdata
              .map((data) => [
                    data.feature.toString(),
                    data.effect,
                    data.order.toString(),
                    data.dimension,
                  ])
              .toList(),
        ),
      ],
    ),
  );

  pdf.addPage(
    pdfWidgets.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pdfWidgets.Header(level: 0, text: 'Threats and Opportunities'),
        pdfWidgets.Paragraph(text: 'Threats: ${threats.join(", ")}'),
        pdfWidgets.Paragraph(
            text: 'Opportunities: ${opportunities.join(", ")}'),
        pdfWidgets.Paragraph(text: 'Actions: ${actions.join(", ")}'),
      ],
    ),
  );
  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}
