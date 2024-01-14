import 'package:firebase_messaging/firebase_messaging.dart';

class pushNotificationsManager{
  pushNotificationsManager._();
  factory pushNotificationsManager() => _instance;
  static final pushNotificationsManager _instance =pushNotificationsManager._();
  final  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  bool initilized =false;
  Future<void> init() async{
    if(!initilized){
          await firebaseMessaging.requestPermission();

      String? token = await firebaseMessaging.getToken();
      print("token $token");
      initilized = true;
    }
  }


}