// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:sanad_software_project/components/roundedTextFeild2.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/components/rounded_textField.dart';
import 'package:sanad_software_project/theme.dart';


class newChild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _newChildState();
  }
}

class _newChildState extends State<newChild> {

  static const List<String> sessions = [
    'الـلغـة و نــطــق',
    'ســلــوكــي',
    'وظــيــفــي',
    'تــربـيـة خـاصـة',
    'عــلاج طــبـيـعي',
  ];
  String selectedSession = sessions.first;
  
  String birthDate="select Date";
  String enteryDate="select Date";
  String firstSessionDate="select Date";
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  DateTime selectedDate3 = DateTime.now();

  Future<void> _selectDate(BuildContext context, int pickerNumber) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: primaryColor, // Change this color as needed
            colorScheme: ColorScheme.light(primary: primaryColor), // Change this color as needed
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    
    );

    if (picked != null) {
      setState(() {
        switch (pickerNumber) {
          case 1:
            selectedDate1 = picked;
            birthDate=DateFormat('yyyy/MM/dd').format(selectedDate1.toLocal());
            break;
          case 2:
            selectedDate2 = picked;
            enteryDate=DateFormat('yyyy/MM/dd').format(selectedDate2.toLocal());
            break;
          case 3:
            selectedDate3 = picked;
            firstSessionDate=DateFormat('yyyy/MM/dd').format(selectedDate3.toLocal());
            break;
        }
      });
    }
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////
final TextEditingController fnameController = TextEditingController();
final TextEditingController secnameController = TextEditingController();
final TextEditingController thnameController = TextEditingController();
final TextEditingController lnameController = TextEditingController();
final TextEditingController idController = TextEditingController();
final TextEditingController fatherPhoneController = TextEditingController();
final TextEditingController motherPhoneController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController diagnosisController = TextEditingController();
final List<TextEditingController> sessionsController =
      List.generate(5, (index) => TextEditingController());

//////////////////////////////////////////////////////////////////////////////////////////////////
File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(pickedFile.path);
      });
    }
  }
File? _file;

  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    setState(() {
      if (result != null) {
        _file = File(result.files.single.path!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "إضــافــة طــفـل جــديــد",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: primaryLightColor,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Image.asset(
              "assets/images/down.png",
              width: size.width * 0.6,
              height: size.width * 0.5,
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: fnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الــطـفـل",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: secnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الــأب",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: thnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الـجـد",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: lnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الـعـائـلة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: idController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "رقــم الـهــويـة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.numbers,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        controller: fatherPhoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "هاتــف الأب",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.call,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        controller: motherPhoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "هاتــف الأم",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.call,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.right,
                        controller: addressController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "عنـوان الســكـن",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.add_location,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.right,
                        controller: diagnosisController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "الـتـشـخـيـص",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                    width: size.width*0.6,
                    child: GestureDetector(
                      child: TextField(
                        enabled: false,
                     decoration: InputDecoration(
                      hintText: birthDate,
                      hintStyle: TextStyle(color: Colors.black)
                     ),),
                      onTap: () => _selectDate(context,1),
                    ),
                  ),
                  SizedBox(height: 20),
                  Spacer(),
                  Text(
                    "تـاريـخ الـميــلاد",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                    width: size.width*0.6,
                    child: GestureDetector(
                      child: TextField(
                        enabled: false,
                     decoration: InputDecoration(
                      hintText: enteryDate,
                      hintStyle: TextStyle(color: Colors.black)
                     ),),
                      onTap: () => _selectDate(context,2),
                    ),
                  ),
                  SizedBox(height: 20),
                  Spacer(),
                  Text(
                    "تـاريـخ الـدخـول",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: primaryColor,
                  )
                ],
              ),
            ),Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                    width: size.width*0.6,
                    child: GestureDetector(
                      child: TextField(
                        enabled: false,
                     decoration: InputDecoration(
                      hintText: firstSessionDate,
                      hintStyle: TextStyle(color: Colors.black)
                     ),),
                      onTap: () => _selectDate(context,3),
                    ),
                  ),
                  SizedBox(height: 20),
                  Spacer(),
                  Text(
                    "تـاريـخ أول جـلـسـة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 250,
                    padding: EdgeInsets.only(bottom: 5),
                    child: RoundedButton(
                      color: primaryColor,
                      text: "إضـافـة جـلـسـات",
                      textColor: Colors.white,
                      press: () {
                        addSessionsDialog();
                      },
                    ),
                  ),
                  Spacer(),
                  Text(
                    "الـجــلـسـات",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            Card(
              color: primaryLightColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      ? Text('No image selected')
                      : Image.file(_image!, height: 50.0),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 250,
                        child: RoundedButton(
                          color: primaryColor,
                          text: "تــحــمــيـل",
                          textColor: Colors.white,
                          press: () {
                            _getImage();
                          },
                        ),
                      ),
                      Spacer(),
                      Text(
                        "صــورة الـهـويـة",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                      ),
                      Icon(
                        Icons.person,
                        color: primaryColor,
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 _file != null
                ? Text('Selected File: ${path.basename(_file!.path)}')
                : Text('No file selected'),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 250,
                        child: RoundedButton(
                          color: primaryColor,
                          text: "تــحــمــيـل",
                          textColor: Colors.white,
                          press: () {
                            _getFile();
                          },
                        ),
                      ),
                      Spacer(),
                      Text(
                        "تـقـرير طــبـي",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                      ),
                      Icon(
                        Icons.person,
                        color: primaryColor,
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }


  void addSessionsDialog(){
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: primaryLightColor,
            title: Text(
              'إضــافــة جـلـســات',
              style: TextStyle(
                fontFamily: 'myFont',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            content:Container(
              width: size.width*0.85,
              child: SingleChildScrollView(child: Column(children: [
                Row(children: [
                 Text("الـعدد بالإسـبـوع",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 22),),
                 Spacer(),
                 Text("الــجـــلــســة",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 22),),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                 RoundedTextField2(
                      width: size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: sessionsController[0],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                 Spacer(),
                 Text("ســلــوكــي",style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                 RoundedTextField2(
                      width: size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: sessionsController[1],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                 Spacer(),
                 Text("وظــيــفــي",style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                 RoundedTextField2(
                      width: size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: sessionsController[2],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                 Spacer(),
                 Text("تــربـيـة خـاصـة",style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                 RoundedTextField2(
                      width: size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: sessionsController[3],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                 Spacer(),
                 Text("عــلاج طــبـيـعي",style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                 RoundedTextField2(
                      width: size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: sessionsController[4],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                 Spacer(),
                 Text("الـلغـة و نــطــق",style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                ],),
                SizedBox(height: 10,),
                RoundedButton(text: "حــفــظ", press: (){
                  print(fnameController.text);
                  print(idController.text);
                  print(fatherPhoneController.text);
                  print(motherPhoneController.text);
                  print(addressController.text);
                  print(diagnosisController.text);
                  print(sessionsController[0].text);
                  print(sessionsController[1].text);
                  print(sessionsController[2].text);
                  print(sessionsController[3].text);
                  print(sessionsController[4].text);
                 Navigator.pop(context);
                    }),
                    SizedBox(height: 5,)
              ],)),

            )
        );
      }
    );
  }
}
