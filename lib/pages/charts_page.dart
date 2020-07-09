import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:effors/constants/color.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:effors/models/record.dart';
import 'package:effors/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChartsPage extends StatefulWidget {
  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  List<charts.Series<Record, String>> _seriesLineData =
      List<charts.Series<Record, String>>();
  List<Record> myData = List<Record>();
  _generateData(myData) {
    _seriesLineData.add(charts.Series(
        data: myData,
        domainFn: (Record record, _) => record.date.toString(),
        measureFn: (Record record, _) => record.hold,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF4287f5)),
        id: 'Breath Hold Time'));
  }

  // void initState() {
  //   super.initState();
  //   _seriesLineData = List<charts.Series<Record, String>>();
  // }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 36.0,
                top: 24,
              ),
              child: Text('Breath Hold Time',
                  style:GoogleFonts.lato(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkBlue)),
            ),
          ),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('user')
          .document(user.uid)
          .collection('record')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Record> rec = List<Record>();
          rec = snapshot.data.documents
              .map((documentSnapshot) => Record.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, rec);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Record> rec) {
    myData = rec;
    _generateData(myData);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width - 50,
      child: charts.BarChart(
        _seriesLineData,
        animate: false,
        barGroupingType: charts.BarGroupingType.groupedStacked,
      ),
    );
  }
}
