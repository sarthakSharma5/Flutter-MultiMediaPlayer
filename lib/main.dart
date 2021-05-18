import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multimediaplayer/audio/audio.dart';
import 'package:multimediaplayer/menu.dart';
import 'package:multimediaplayer/video/video.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-MediaPlayer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => MediaApp(),
        "/": (context) => MenuHome(),
        "/audio": (context) => AudioView(),
        "/video": (context) => VideoView(),
      },
    );
  }
}

class MediaApp extends StatefulWidget {
  @override
  _MediaAppState createState() => _MediaAppState();
}

class _MediaAppState extends State<MediaApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: MenuHome(),
      title: Text(
        'Multi-Media Player',
        style: GoogleFonts.yatraOne(
          fontWeight: FontWeight.bold,
          fontSize: 32.0,
          color: Colors.blue.shade900,
          fontStyle: FontStyle.italic,
        ),
      ),
      image: Image.asset(
        'assets/images/drawer.jpg',
        fit: BoxFit.cover,
      ),
      loadingText: Text('Just a few seconds'),
      photoSize: MediaQuery.of(context).size.width * 0.4,
      backgroundColor: Colors.white,
      loaderColor: Colors.deepPurple.shade800,
    );
  }
}
