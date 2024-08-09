import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pointage_automatique/screens/attendance_dashboard_page.dart';

class PhoneSignInPage extends StatefulWidget {
  @override
  _PhoneSignInPageState createState() => _PhoneSignInPageState();
}

class _PhoneSignInPageState extends State<PhoneSignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isArrival = true; // État pour suivre si c'est une arrivée ou un départ

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phoneController.text;

      final url = _isArrival
          ? 'http://127.0.0.1:8000/api/arrival'
          : 'http://127.0.0.1:8000/api/departure';

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final message = _isArrival
            ? 'Arrivée enregistrée pour $phoneNumber'
            : 'Départ enregistré pour $phoneNumber';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );

        // Réinitialiser le formulaire après la soumission
        _phoneController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${response.body}')),
        );
      }
    }
  }

  void _selectArrival() {
    setState(() {
      _isArrival = true;
    });
  }

  void _selectDeparture() {
    setState(() {
      _isArrival = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pointage'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: _selectArrival,
                  child: Card(
                    color: _isArrival ? Colors.blue : Colors.white,
                    child: Container(
                      width: 150,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(
                        'Arrivée',
                        style: TextStyle(
                          fontSize: 24,
                          color: _isArrival ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _selectDeparture,
                  child: Card(
                    color: !_isArrival ? Colors.blue : Colors.white,
                    child: Container(
                      width: 150,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(
                        'Départ',
                        style: TextStyle(
                          fontSize: 24,
                          color: !_isArrival ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Numéro de Téléphone',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                        return 'Veuillez entrer un numéro de téléphone valide à 9 chiffres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Enregistrer le Pointage'),
                  ),
                  SizedBox(height: 40),
                  IconButton(
              icon: Icon(Icons.dashboard), // Utilisation de l'icône du tableau de bord
              iconSize: 50,
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceDashboardPage()),
                );
              },
            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
