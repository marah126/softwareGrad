import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCalendar(),
    );
  }
}

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  List<DateTime> visibleDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: Container(
        child: SfCalendar(
          view: CalendarView.week,
          dataSource: _getCalendarAppointments(),
          scheduleViewSettings: ScheduleViewSettings(
            hideEmptyScheduleWeek: true,
          ),
          
          appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
            return SingleChildScrollView(
              child: Column(
                children: details.appointments!.map((appointment) {
                  return Container(
                    width: details.bounds.width,
                    decoration: BoxDecoration(
                      color: appointment.color,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        _showAppointmentDetails(context, appointment);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Subject: ${appointment.subject}'),
                            Text('Start Time: ${appointment.startTime}'),
                            Text('End Time: ${appointment.endTime}'),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
          onTap: (CalendarTapDetails details) {
            if (details.targetElement == CalendarElement.appointment) {
              // Handle appointment tap
              Appointment tappedAppointment = details.appointments![0];
              _showAppointmentDetails(context, tappedAppointment);
            } else {
              print("No appointment tapped.");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use the visibleDates as needed
          print('Visible Dates: $visibleDates');
        },
        child: Icon(Icons.print),
      ),
    );
  }

  CalendarDataSource _getCalendarAppointments() {
    List<Appointment> appointments = <Appointment>[
      Appointment(
        startTime: DateTime(2023, 11, 14, 10, 0, 0),
        endTime: DateTime(2023, 11, 14, 11, 0, 0),
        subject: 'Meeting 1',
        color: Colors.blue,
      ),
      Appointment(
        startTime: DateTime(2023, 11, 14, 10, 0, 0),
        endTime: DateTime(2023, 11, 14, 11, 0, 0),
        subject: 'Meeting 2',
        color: Colors.green,
      ),
      // Add more appointments at the same time
      Appointment(
        startTime: DateTime(2023, 11, 14, 10, 0, 0),
        endTime: DateTime(2023, 11, 14, 11, 0, 0),
        subject: 'Meeting 3',
        color: Colors.red,
      ),
      // Add more appointments as needed
    ];

    return _DataSource(appointments);
  }

  void _showAppointmentDetails(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Subject: ${appointment.subject}'),
              Text('Start Time: ${appointment.startTime}'),
              Text('End Time: ${appointment.endTime}'),
              // Add more details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
