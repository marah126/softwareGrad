import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class calenderr extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<calenderr> {
  List<CustomEvent> events = [];

  void addEvent(DateTime startTime, DateTime endTime, String child,
      String specialest, String session) {
    final newEvent = CustomEvent(
        child, specialest, session, startTime, endTime, Colors.blue);
    events.add(newEvent);
    setState(() {
      // Refresh the calendar with the updated event data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Example'),
      ),
      body: SfCalendar(
        view: CalendarView.week,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeInterval: Duration(minutes: 40),
          timeFormat: 'h:mm',
          startHour: 8,
          endHour: 18,
          timeIntervalHeight: 100,
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
          if (details.targetElement == CalendarElement.calendarCell) {
            // User tapped on a calendar cell (block)
            // Show a dialog or form to add a new event
            showEventInputDialog(details.date!);
          } else {
            print("object");
          }
        },
      ),
    );
  }

  CalendarDataSource _getCalendarAppointments() {
    final List<Appointment> appointments = <Appointment>[];
    for (final CustomEvent event in events) {
      appointments.add(Appointment(
        startTime: event.from,
        endTime: event.to,
        subject: event.childe + event.specialest+ event.session,
        color: event.color,
      ));
    }
    return _DataSource(appointments);
  }

  void showEventInputDialog(DateTime selectedDate) {
    String child = "";
    String sp = "";
    String ss = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Date: ${selectedDate.toLocal()}'),
              TextField(
                decoration: InputDecoration(labelText: 'Event Name'),
                onSubmitted: (value) {
                  // Create the event and add it to the list
                  setState(() {
                    child = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Event Name'),
                onSubmitted: (value) {
                  // Create the event and add it to the list
                  setState(() {
                    sp = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Event Name'),
                onSubmitted: (value) {
                  // Create the event and add it to the list
                  setState(() {
                    ss = value;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    addEvent(selectedDate,selectedDate.add(Duration(minutes: 40)), child, sp, ss);
                    print(child);
                    print(sp);
                    print(ss);
                    Navigator.pop(context);
                  },
                  child: Text("ok"))
            ],
          ),
        );
      },
    );
  }
}

class CustomEvent {
  CustomEvent(this.childe, this.specialest, this.session, this.from, this.to,
      this.color);

  String childe;
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
