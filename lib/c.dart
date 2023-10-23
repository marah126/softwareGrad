import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class calender extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<calender> {
  List<CustomEvent> events = [];

  void addEvent(DateTime startTime, DateTime endTime, String eventName) {
    final newEvent = CustomEvent(eventName, startTime, endTime, Colors.blue);
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
        dataSource: _getCalendarAppointments(),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            // User tapped on a calendar cell (block)
            // Show a dialog or form to add a new event
            showEventInputDialog(details.date!);
          }
          else{
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
        subject: event.eventName,
        color: event.color,
      ));
    }
    return _DataSource(appointments);
  }

  void showEventInputDialog(DateTime selectedDate) {
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
                  addEvent(selectedDate, selectedDate.add(Duration(minutes: 40)), value);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomEvent {
  CustomEvent(this.eventName, this.from, this.to, this.color);

  String eventName;
  DateTime from;
  DateTime to;
  Color color;
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
