import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:pointage_automatique/screens/attendance_dashboard_page.dart';
import 'package:pointage_automatique/screens/phone_sign_in_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF85addb),
        title: Text('Pointage'),
      ),
      backgroundColor: Color(0xFF85addb),
      body: Container(
        color: Color(0xFF85addb),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            TextButton(
              
              style: ButtonStyle(
                
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneSignInPage()),
                );
              },
              child: Text('PointeMoi'),

            //    Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => AttendanceDashboardPage()),
            //           );
            //         },
            //         child: Text('Tableau de bord'),
             ),
            
          ],
        ),
      ),
      )
    );
  }
}
