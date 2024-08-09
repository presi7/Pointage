import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceDashboardPage extends StatefulWidget {
  @override
  _AttendanceDashboardPageState createState() => _AttendanceDashboardPageState();
}

class _AttendanceDashboardPageState extends State<AttendanceDashboardPage> {
  List<dynamic> _attendances = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendances();
  }

  Future<void> _fetchAttendances() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/attendances'));
    
    if (response.statusCode == 200) {
      setState(() {
        _attendances = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord des pointages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _attendances.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
  itemCount: _attendances.length,
  itemBuilder: (context, index) {
    final attendance = _attendances[index];
    final employeeName = attendance['employee'] != null ? attendance['employee']['name'] : 'Non disponible';
    final phoneNumber = attendance['phone_number'] ?? 'Non disponible';
    final arrivalTime = attendance['arrival_time'] ?? 'Non encore enregistré';
    final departureTime = attendance['departure_time'] ?? 'Non encore enregistré';

    return Card(
      child: ListTile(
        title: Text('Nom: $employeeName'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Numéro de téléphone: $phoneNumber'),
            Text('Heure d\'arrivée: $arrivalTime'),
            Text('Heure de départ: $departureTime'),
          ],
        ),
      ),
    );
  },
),

      ),
    );
  }
}
