// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/components/rounded_textField.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class calenderr extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<calenderr> {

  CalendarController _calendarController=CalendarController();
  
  final TextEditingController textEditingController = TextEditingController();
  int autoID=0;
  TimeOfDay timeOfDay=TimeOfDay(hour: 8, minute: 0);
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
 Map<String, Color> colorMap = {
     'الـلغـة و نــطــق':primaryLightColor,
    'ســلــوكــي':Color(0xffb1a1b3),
    'وظــيــفــي':Color(0xfffff9e6),
    'تــربـيـة خـاصـة':Color(0xffe6f6ff),
    'عــلاج طــبـيـعي':Color(0xffEBFFE5)
  };
  static const List<String> children = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 11',
    'Item 21',
    'Item 31',
    'Item 41',
    'Item 51',
    'Item 12',
    'Item 22',
    'Item 32',
    'Item 42',
    'Item 52',
  ];
  static const List<String> specialests = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 11',
    'Item 21',
    'Item 31',
    'Item 41',
    'Item 51',
    'Item 12',
    'Item 22',
    'Item 32',
    'Item 42',
    'Item 52',
  ];

  static const List<String> sessions = [
    'الـلغـة و نــطــق',
    'ســلــوكــي',
    'وظــيــفــي',
    'تــربـيـة خـاصـة',
    'عــلاج طــبـيـعي',
  ];
  String selectedValue = children.first;
  String selectedValue2 = specialests.first;
  String selectedValue3 = sessions.first;
  String selectedDateweek="";

  List<CustomEvent> events = [];
  List<DateTime> visibleDates = [];
  List<String> visibleDatesString =[];

  void addEvent(int id, DateTime startTime, DateTime endTime, String child,String specialest, String session, Color c) {
      final newEvent = CustomEvent(id, child, specialest, session, startTime, endTime, c);
      events.add(newEvent);
      setState(() {
      // Refresh the calendar with the updated event data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [ FloatingActionButton(
            key: UniqueKey(),
        backgroundColor: primaryColor,
          onPressed: () {
            
            print('Floating Action Button Pressed!');
            
            selectedDateweek=visibleDatesString.first;
            for(int i=0;i<visibleDates.length;i++){
              print(visibleDates[i]);
              print(visibleDatesString[i]);
            }
            addMoreEvents(visibleDates);
          },
          child: Icon(Icons.add),),
          SizedBox(height: 10,),
        //    FloatingActionButton(
        //     key: UniqueKey(),
        // backgroundColor: primaryColor,
        //   onPressed: () {
        //     _switchCalendarView();
        //   }
        //    )
          ]),
      appBar: AppBar(
        title: Text('Calendar '),
        backgroundColor: primaryColor,
      ),
      body: SfCalendar(
        
        appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
         final Appointment appointment = details.appointments.elementAt(0);

          return Container(
            
            color: appointment.color,
            child: Text(
              appointment.subject,
              style: TextStyle(
                color: secondaryColor, 
                fontFamily: 'myFont'// Text color
                // Other text styles (font size, weight, etc.) can be customized here
              ),
              maxLines: 5, // Ensure text stays on a single line
              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
            ),
          );
        },
        controller: _calendarController,
        view: CalendarView.week,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeInterval: Duration(minutes: 40),
          timeFormat: 'h:mm',
          startHour: 8,
          endHour: 18,
          timeIntervalHeight: 100,
          //numberOfDaysInView:6
        ),
        cellBorderColor: Color(0xff9990b3),
        todayHighlightColor: primaryColor,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        showNavigationArrow: true, // اسهم التحرك من اسبوع لاسبوع
        showDatePickerButton: true,
        dataSource: _getCalendarAppointments(),
        firstDayOfWeek: 7,
        allowViewNavigation: true,
        viewHeaderStyle: ViewHeaderStyle(
          backgroundColor: primaryLightColor,
        ),
        headerStyle: CalendarHeaderStyle(backgroundColor: primaryLightColor),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            
            showdetailesDialog(details);
           // showEventInputDialog(details,false);
          } else {
            showEventInputDialog(details,false);
             //showdetailesDialog(details);
            // print(details.appointments!.length);
            // print(details.appointments![0].id);
            // print("object");
          }
        },
        onViewChanged: (ViewChangedDetails viewChangedDetails) {
            visibleDates = viewChangedDetails.visibleDates;
            visibleDatesString=[];
            String s="";
            for(int i=0; i<visibleDates.length;i++){
              s=(DateFormat('MM/dd').format(visibleDates[i]).toString());
              //s=visibleDates[i].toString();
              visibleDatesString.add(s);
            }
          },
      ),
    );
  }

  CalendarDataSource _getCalendarAppointments() {
    DateTime d=DateTime.now();
    d=d.add(const Duration(days: 10));
    final List<Appointment> appointments = <Appointment>[];
    
    for (final CustomEvent event in events) {
      appointments.add(Appointment(
        id:event.id,
        startTime: event.from,
        endTime: event.to,
        subject: event.child ,
        color: event.color,
        recurrenceRule: 'FREQ=DAILY;INTERVAL=7;UNTIL=$d'
        
      ));
    }
    return _DataSource(appointments);
  }
void _switchCalendarView() {
    // Toggle between 'week' and 'day' views
    if (_calendarController.view == CalendarView.week) {
      _calendarController.view = CalendarView.day;
    } else {
      _calendarController.view = CalendarView.week;
    }
  }
  void showEventInputDialog(CalendarTapDetails selectedDate,bool flag) {
    int id;
    if(flag==true){
      id=selectedDate.appointments![0].id;
      events.removeWhere((element) => element.id == id);
    }
    Color  color;
    Size size = MediaQuery.of(context).size;
    String ch = "";
    String sp = "";
    String ss = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'إضــافــة مــوعــد جــديــد',
              style: TextStyle(
                fontFamily: 'myFont',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
              textAlign: TextAlign.right,
            ),
            content: Container(
              color: Colors.white,
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: SingleChildScrollView(
                child: StatefulBuilder(builder: (context, setState) {
                  // Use StatefulBuilder here
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '        التــاريــخ: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDate.date!.toLocal())}',
                        style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("الــطــفــل",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: children
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                                ch = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryLightColor, // Change this color to your desired border color
                                        width:
                                            2.0, // Change this width if needed
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryColor, // Border color when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Text("الأخــصـــائــيــة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: specialests
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue2,
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!;
                                sp = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryLightColor, // Change this color to your desired border color
                                        width:
                                            2.0, // Change this width if needed
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryColor, // Border color when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Text("نــوع الجــلــســة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: sessions
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue3,
                            onChanged: (value) {
                              setState(() {
                                selectedValue3 = value!;
                                ss = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                           
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        text: "حــجــز",
                        press: () {
                          color = colorMap[ss.toLowerCase()]!;
                          if(flag==false) autoID++;
                          id=autoID;
                          addEvent(id,selectedDate.date!,selectedDate.date!.add(Duration(minutes: 40)),ch,sp, ss,color);
                          print(ch);
                          print(sp);
                          print(ss);
                          print(events.length);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                }),
              ),
            ));
      },
    );
  }

  void showdetailesDialog(CalendarTapDetails selectedDate ) {
    int id=selectedDate.appointments![0].id;
    print("insidee $id");
    CustomEvent e=events.firstWhere((element) => element.id==id);
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: primaryLightColor,
              content: Container(

                  color: primaryLightColor,
                  width: size.width * 0.5,
                  height: size.height * 0.5,
                  child: SingleChildScrollView(
                      child: StatefulBuilder(builder: (context, setState) {
                    // Use StatefulBuilder here
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        '        التــاريــخ: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDate.date!.toLocal())}',
                        style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("الطــفــل",style: TextStyle(fontSize:20.0,fontFamily: 'myFont',fontWeight: FontWeight.bold,color: secondaryColor)),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width*0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: primaryColor, // Change this color to your desired border color
                            width: 2.0, // Adjust the width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                        ),
                        child: Text( e.child,textAlign: TextAlign.right,
                          style: TextStyle(fontSize:18.0,fontFamily: 'myFont',color: secondaryColor), // Adjust the font size and other styles as needed
                        ),
                      ),SizedBox(height:10),
                      Text("الأخــصــائــيــة",style: TextStyle(fontSize:20.0,fontFamily: 'myFont',fontWeight: FontWeight.bold,color: secondaryColor)),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width*0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: primaryColor, // Change this color to your desired border color
                            width: 2.0, // Adjust the width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                        ),
                        child: Text( e.specialest,textAlign: TextAlign.right,
                          style: TextStyle(fontSize:18.0,fontFamily: 'myFont',color: secondaryColor), // Adjust the font size and other styles as needed
                        ),
                      ),SizedBox(height:10),
                      Text("نـوع الـجـلـسـة",style: TextStyle(fontSize:20.0,fontFamily: 'myFont',fontWeight: FontWeight.bold,color: secondaryColor)),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width*0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: primaryColor, // Change this color to your desired border color
                            width: 2.0, // Adjust the width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                        ),
                        child: Text( e.session,textAlign: TextAlign.right,
                          style: TextStyle(fontSize:18.0,fontFamily: 'myFont',color: secondaryColor), // Adjust the font size and other styles as needed
                        ),
                      ),SizedBox(height:17),
                      RoundedButton(text: "تــعــديــل", press: (){
                        
                        Navigator.pop(context);
                        showEventInputDialog(selectedDate,true);
                      }),
                    ]);
                  }))));
        });
  }

  void addMoreEvents(List<DateTime>vdates){
    int id;
    Color  color;
    Size size = MediaQuery.of(context).size;
    String ch = "";
    String sp = "";
    String ss = "";
    String h=timeOfDay.hour.toString();
    String m = timeOfDay.minute.toString();
    String dd=visibleDatesString.first;
    DateTime datedate;
    if (timeOfDay.hour > 12) {
      int hh = timeOfDay.hour;
      hh = hh - 12;
      setState(
        () => h = hh.toString(),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'إضــافــة مــوعــد جــديــد',
              style: TextStyle(
                fontFamily: 'myFont',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
              textAlign: TextAlign.right,
            ),
            content: Container(
              color: Colors.white,
              width: size.width * 0.5,
              height: size.height * 0.7,
              child: SingleChildScrollView(
                child: StatefulBuilder(builder: (context, setState) {
                  // Use StatefulBuilder here
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ' التــاريــخ:',
                        style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: visibleDatesString
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedDateweek,
                            onChanged: (value) {
                              setState(() {
                                selectedDateweek = value!;
                                dd = value! ;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("الــوقــــت",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                       SizedBox(
                        height: 5,
                      ), 
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 14, right: 14),
                        width: size.width * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: primaryColor, width: 2),
                            color: Colors.white),
                        child: GestureDetector(
                          child: Text(h+':'+m),
                          onTap: () async {
                            TimeOfDay?newtime= await showTimePicker(
                                context: context, initialTime: timeOfDay);
                            if(newtime ==null)return;
                            setState(() => timeOfDay=newtime,);
                            setState(() => m=timeOfDay.minute.toString(),);
                            setState(() => h=timeOfDay.hour.toString());
                            if(timeOfDay.hour>12){
                              int hh=timeOfDay.hour;
                              hh=hh-12;
                            setState(() => h=hh.toString(),);
                            }

                          },
                        ),
                      ),
                      SizedBox(height: 15,),  
                      Text("الــطــفــل",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: children
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                                ch = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryLightColor, // Change this color to your desired border color
                                        width:
                                            2.0, // Change this width if needed
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryColor, // Border color when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Text("الأخــصـــائــيــة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: specialests
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue2,
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!;
                                sp = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryLightColor, // Change this color to your desired border color
                                        width:
                                            2.0, // Change this width if needed
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryColor, // Border color when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Text("نــوع الجــلــســة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: sessions
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue3,
                            onChanged: (value) {
                              setState(() {
                                selectedValue3 = value!;
                                ss = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                  color: Colors.white),
                              elevation: 2,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        text: "حــجــز",
                        press: () {
                          color = colorMap[ss.toLowerCase()]!;
                          autoID++;
                          id=autoID;
                          int index=visibleDatesString.indexOf(dd);
                          datedate=visibleDates[index];
                          datedate=new DateTime(datedate.year,datedate.month,datedate.day,timeOfDay.hour,timeOfDay.minute);
                          addEvent(id,datedate,datedate.add(Duration(minutes: 40)),ch,sp,ss,color);
                          print(ch);
                          print(sp);
                          print(ss);
                          print(events.length);
                          print(datedate);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                }),
              ),
            ));
      },
    );
  }


}

class CustomEvent {
  CustomEvent(this.id, this.child, this.specialest, this.session, this.from,
      this.to, this.color);
  int id;
  String child;
  String specialest;
  String session;
  DateTime from;
  DateTime to;
  Color color;
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
