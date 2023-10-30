// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class MyAppState extends StatelessWidget {
//   CalendarController _controller = CalendarController();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           body: SfCalendar(
//             view: CalendarView.day,
//             dataSource: _getCalendarDataSource(),
//             appointmentBuilder: (BuildContext context,
//                 CalendarAppointmentDetails details) {
//               final Appointment meeting =
//                   details.appointments.first;
//               final String image = _getImage();
//               if (_controller.view != CalendarView.month &&
//                   _controller.view != CalendarView.schedule) {
//                 return Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(3),
//                         height: 50,
//                         alignment: Alignment.topLeft,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(5),
//                               topRight: Radius.circular(5)),
//                           color: meeting.color,
//                         ),
//                         child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   meeting.subject,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   maxLines: 3,
//                                   softWrap: false,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 !kIsWeb
//                                     ? Container()
//                                     : Text(
//                                         'Time: ${DateFormat('hh:mm a').format(meeting.startTime)} - ' +
//                                             '${DateFormat('hh:mm a').format(meeting.endTime)}',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 10,
//                                         ),
//                                       )
//                               ],
//                         )),
//                       ),
//                       Container(
//                         height: details.bounds.height - 70,
//                         padding: EdgeInsets.fromLTRB(3, 5, 3, 2),
//                         color: meeting.color.withOpacity(0.8),
//                         alignment: Alignment.topLeft,
//                         child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     child: Image(
//                                         image:
//                                             ExactAssetImage('images/' + image + '.png'),
//                                         fit: BoxFit.contain,
//                                         width: details.bounds.width,
//                                         height: 60)),
//                                 Text(
//                                   meeting.notes!,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10,
//                                   ),
//                                 )
//                               ],
//                         )),
//                       ),
//                       Container(
//                         height: 20,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(5),
//                               bottomRight: Radius.circular(5)),
//                           color: meeting.color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return Container(
//                 child: Text(meeting.subject),
//               );
//             },
//       )),
//     );
//   }
// }