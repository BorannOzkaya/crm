import 'dart:convert';

import 'package:crm/screens/Home_Page/status_count_api.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class GenelRaporGrafigi extends StatefulWidget {
  const GenelRaporGrafigi({Key? key}) : super(key: key);

  @override
  _GenelRaporGrafigiState createState() => _GenelRaporGrafigiState();
}

class _GenelRaporGrafigiState extends State<GenelRaporGrafigi> {
  List<StatusDatum> statusCount = [];
  getStatusCountList() async {
    var url = Uri.parse(
        'https://crmsr.pen.com.tr/api/interview-status/getstatusescounts');
    var response = await http
        .post(url, body: {"id": "0"}, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      // print(response.body);
      var decode = jsonDecode(response.body);
      statusCount = statusDatumApiDatasFromJson(jsonEncode(decode["data"]));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getStatusCountList().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(color: Colors.blue, x: 'Olumlu', y: 3),
      ChartData(color: Colors.red, x: 'Olumsuz', y: 36.4),
      ChartData(color: Colors.orange, x: 'Nötr', y: 60.6),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: RichText(
            text: TextSpan(
                text: 'PEN ',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: 'CRM-SR', style: TextStyle(color: Colors.white))
                ]),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "Genel - Grafik",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: FutureBuilder(
                  future: Future.delayed(Duration(seconds: 1)),
                  builder: (c, s) => s.connectionState == ConnectionState.done
                      ? Column(
                          children: [
                            Container(
                                // color: Colors.red,
                                child: SfCircularChart(
                                    legend: Legend(isVisible: true),
                                    series: <CircularSeries>[
                                  PieSeries<StatusDatum, String>(
                                      enableTooltip: true,
                                      dataSource: (statusCount),
                                      xValueMapper: (StatusDatum data, _) =>
                                          data.statusId.toString(),
                                      yValueMapper: (StatusDatum data, _) =>
                                          data.count,
                                      radius: '100%',
                                      explode: true,
                                      explodeIndex: 1,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ])),
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
              ListTile(
                title: Text(
                  "1: Olumlu",
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
              ListTile(
                title: Text(
                  "2: Olumsuz",
                  style: TextStyle(color: Colors.purple[800]),
                ),
              ),
              ListTile(
                title: Text(
                  "3: Nötr",
                  style: TextStyle(color: Colors.red[300]),
                ),
              ),
              ListTile(
                title: Text(
                  "4: Açılmayan Aramalar",
                  style: TextStyle(color: Colors.yellow[800]),
                ),
              ),
              ListTile(
                title: Text(
                  "5: Dönülmeyen Aramalar",
                  style: TextStyle(color: Colors.green[800]),
                ),
              ),
            ],
          ),
        ));
  }
}

class ChartData {
  ChartData({required this.x, required this.y, required this.color});
  final String x;
  final double y;
  final Color color;
}


                                      // pointColorMapper: (StatusDatum data, _) =>
                                      //     data.colors.t,