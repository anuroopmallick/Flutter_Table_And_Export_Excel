import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table/model/mydata.dart';
import 'package:table/provider/myhomepageprovider.dart';

class TableData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Table Data Along With Create Excel Feature"),
        ),
        body: Row(
          children: <Widget>[
            Container(
              width: 100.0,
            ),
            ElevatedButton(onPressed: createExcel, child: Text("Create Excel")),
            Container(
              width: 100.0,
            ),
            ChangeNotifierProvider<MyHomePageProvider>(
              create: (context) => MyHomePageProvider(),
              child: Consumer<MyHomePageProvider>(
                builder: (context, provider, child) {
                  if (provider.data == null) {
                    provider.getData(context);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text('First Name'),
                              tooltip: 'represents if first name is verified,'),
                          DataColumn(
                              label: Text('Last Name'),
                              tooltip: 'represents if last name is verified,'),
                          DataColumn(
                              label: Text('Email'),
                              tooltip:
                                  'represents if email adress is verified,'),
                          DataColumn(
                              label: Text('Phone'),
                              tooltip:
                                  'represents if phone number is verified,')
                        ],
                        rows: provider.data!.results!
                            .map((data) => DataRow(cells: [
                                  DataCell(Text("${data.firstName}")),
                                  DataCell(Text("${data.lastName}")),
                                  DataCell(Text("${data.email}")),
                                  DataCell(Text("${data.phone}")),
                                ]))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Future<void> createExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];
    sheet!.setColWidth(2, 10);
    sheet.setColAutoFit(3);

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3)).value =
        'Name';

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 4)).value =
        'obi wan kanobi';

    excel.save();
  }
}
