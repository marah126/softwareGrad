// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:sanad_software_project/theme.dart';

class spDetailsPage extends StatefulWidget {
  final String name;

  spDetailsPage({required this.name});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<spDetailsPage> {
  // String id = "";

  List<String> vacation = [];
  late final List<dynamic> dataVacation;

  late String id;

  String name = "";
  DateTime startDate = DateTime.now();
  String phone = "";
  String sp = "";
  String idd = "";
  String add="";
  @override
  void initState() {
    super.initState();
    setState(() {
      id = widget.name;
    });
    print("id" + id);
    getEmployeeInfo();
  }

  Future<void> getEmpVacations() async {
    final EmpVacationsResponse =
        await http.get(Uri.parse(ip + "/sanad/vacations$id"));
    if (EmpVacationsResponse.statusCode == 200) {
      print("okkk");
      print(EmpVacationsResponse.body);
      dataVacation.clear();
      String reason;
      DateTime dateOfVavation = DateTime.now();
      String idd1;
      String count;

      dataVacation = jsonDecode(EmpVacationsResponse.body);
      for (int i = 0; i < dataVacation.length; i++) {
        reason = dataVacation![i]['reason'];
        dateOfVavation =
            DateTime.parse(dataVacation![i]['dateOfVavation']).toLocal();
        // idd1 = dateOfVavation![i]['idd'];
      }
      setState(() {
        // vacation.add(dataVacation);
      });
    } else {
      print("errrrrrrrror");
    }
  }

  Future<void> getEmployeeInfo() async {
    late final Map<String, dynamic>? data;
    final response = await http.get(
      Uri.parse(ip + '/sanad/getSPInfoByID?id=$id'),
    );

    if (response.statusCode == 200) {
      print("okkk");
      print(response.body);
      data = jsonDecode(response.body);
      setState(() {
        name = data!['firstName'] +
            " " +
            data!['secondName'] +
            " " +
            data!['thirdName'] +
            " " +
            data!['lastName'];
        startDate = DateTime.parse(data!['startDate']).toLocal();

        phone = data!['phone'];
        sp = data!['specialise'];
        idd = data!['idd'];
        add=data!['address'];
      });
      //    print(bd);
    } else {
      print(response.reasonPhrase);
      print("error");
    }
  }

  Future<void> _openFile() async {
    String filePath = 'files/exp2.pdf';
    OpenResult result = await OpenFile.open(filePath);
    if (result.type == ResultType.done) {
      // File opened successfully
      print('File opened successfully.');
    } else {
      // Handle error if the file can't be opened
      print('Error opening the file: ${result.message}');
    }
  }

  void _showDialog(BuildContext context, String s) {
    List<Map<String, String>> tableData = [
      {"date": "20/10/2018", "reason": "مـرضـية"},
      {"date": "16/03/2019", "reason": "مـرضـية"},
      {"date": "20/10/2018", "reason": "مـرضـية"},
      {"date": "16/03/2019", "reason": "مـرضـية"},
      {"date": "20/10/2018", "reason": "مـرضـية"},
      {"date": "16/03/2019", "reason": "مـرضـية"},
      {"date": "20/10/2018", "reason": "مـرضـية"},
      {"date": "16/03/2019", "reason": "مـرضـية"},
      // Add more rows as needed
    ];

    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        "  تـاريـخ الإجـازة",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        " سـبـب الإجـازة",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                  rows: [
                    for (var i = 0; i < tableData.length; i++)
                      DataRow(
                        cells: [
                          DataCell(
                            Text(tableData[i]["date"]!,
                                style: TextStyle(fontSize: 15)),
                          ),
                          DataCell(
                            Text(tableData[i]["reason"]!,
                                style: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 50),
                Card(
                  child: Row(
                    children: <Widget>[
                      Text(" 5",
                          style: TextStyle(
                              fontFamily: 'myfont',
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      SizedBox(width: 90),
                      Text(" عـدد الإجـازات الـكـلـي  ",
                          style: TextStyle(
                              fontFamily: 'myfont',
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Add more Card widgets as needed
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'موافق',
              style: TextStyle(
                  color: Color(0xFF6F35A5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
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
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text(
          'تـفــاصـيـل $name',
          style: TextStyle(fontFamily: 'myfont'),
        ),
      ),
      body: Container(
        width: size.width,
        //height: size.height,
        child: Stack(
          children: <Widget>[
            
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                alignment: Alignment.topLeft,
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child:
                        Image.asset(
                          'assets/images/person4.png',
                          width: 200,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Positioned(
                            top: 50,
                            right: 20,
                            child: Card(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(name,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(width: 5),
                                  Icon(Icons.person, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Card(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(sp,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'myfont',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(width: 5),
                                Icon(Icons.category, color: Colors.white),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Card(
                            color: Color(0x8B19AB),
                            // color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(phone,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'myfont',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(width: 10),
                                Icon(Icons.phone, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 350,
                right: 0,
                child: 
            // Container(
            //       width: size.width,
            //       height: size.height,
            //       child: 
            SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('sarahhinno@gmail.com',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 15),
                              Text('  الـبـريـد الالـكـتـرونـي',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 15),
                              Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 111, 53, 165),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(idd,
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 150),
                              Text('رقــم الــهـويـة',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 10),
                              Icon(
                                Icons.sd_card,
                                color: Color.fromARGB(255, 111, 53, 165),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(add,
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 100),
                              Text('عــنـوان الـسـكــن',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 10),
                              Icon(
                                Icons.sd_card,
                                color: Color.fromARGB(255, 111, 53, 165),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(DateFormat('yyyy/MM/dd').format(startDate),
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 110),
                              Text('تـاريـخ بـدايـة الـعـمـل',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 10),
                              Icon(
                                Icons.date_range,
                                color: Color.fromARGB(255, 111, 53, 165),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  print('okkkkkk');
                                  _showDialog(context, 'ساره حنو');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Color(0xFFF1E6FF)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(29.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "   تـفـاصـيـل الإجـازات",
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              SizedBox(width: 110),
                              Text('الإجـازات',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 10),
                              Icon(
                                Icons.numbers,
                                color: Color.fromARGB(255, 111, 53, 165),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  _openFile();
                                  print('okkkkkk');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Color(0xFFF1E6FF)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(29.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "  فـتـح الـمـلـف",
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              SizedBox(width: 110),
                              Text('  الـسـيـرة الـذاتـيـة',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(width: 10),
                              Icon(
                                Icons.attach_file,
                                color: Color.fromARGB(255, 111, 53, 165),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                //)
                )
          ],
        ),
      ),
    );
  }
}