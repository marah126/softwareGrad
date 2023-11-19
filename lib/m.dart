import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyImagePage(),
    );
  }
}

class MyImagePage extends StatefulWidget {
  @override
  _MyImagePageState createState() => _MyImagePageState();
}

class _MyImagePageState extends State<MyImagePage> {
  final String imageId = '1234567890'; // Replace with the actual image ID
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    // Fetch image URL when the widget is initialized
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final String serverUrl = ip+'/sanad/getImage/$imageId';

    try {
      final response = await http.get(Uri.parse(serverUrl));

      if (response.statusCode == 200) {
        setState(() {
          imageUrl = serverUrl;
        });
      } else {
        print('Failed to get image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display Example'),
      ),
      body: Center(
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                height: 200.0,
                width: 200.0,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
