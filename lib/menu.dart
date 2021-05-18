import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuHome extends StatefulWidget {
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Media\nPlayer',
            style: GoogleFonts.oxanium(
                fontSize: MediaQuery.of(context).textScaleFactor * 40,
                fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        backgroundColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight:
                Radius.circular(MediaQuery.of(context).size.width * 0.7),
            topRight: Radius.circular(MediaQuery.of(context).size.width * 0.7),
          ),
        ),
        shadowColor: Colors.blue.shade900,
        elevation: 8.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              image: DecorationImage(
                image: AssetImage('assets/images/drawer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 50),
          GotoRoute(title: 'Music Player', route: '/audio'),
          GotoRoute(title: 'Video Player', route: '/video'),
        ],
      ),
    );
  }
}

class GotoRoute extends StatefulWidget {
  GotoRoute({Key key, this.title, this.route}) : super(key: key);
  final String title;
  final String route;

  @override
  _GotoRouteState createState() => _GotoRouteState();
}

class _GotoRouteState extends State<GotoRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(60, 40),
          topRight: Radius.elliptical(60, 40),
          bottomLeft: Radius.elliptical(30, 40),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.6, 0.9, 1],
          colors: <Color>[
            Colors.deepPurple.shade700,
            Colors.blue.shade700,
            Colors.purple.shade700,
            Colors.indigoAccent.shade700,
          ],
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 3.0, spreadRadius: 1.0, color: Colors.cyan.shade200),
          BoxShadow(blurRadius: 2.0, spreadRadius: 1.0, color: Colors.cyan),
        ],
      ),
      child: ListTile(
        onTap: () {
          try {
            Navigator.pushNamed(context, widget.route);
          } catch (e) {
            print('unable to push');
          }
        },
        title: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.title,
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.8,
                style: GoogleFonts.pollerOne(
                    color: Colors.white, fontStyle: FontStyle.italic)),
          ),
        ),
        // trailing: Icon(Icons.navigate_next_sharp, color: Colors.white),
      ),
    );
  }
}
