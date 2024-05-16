import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/patient.dart';

class PatientService {
  final String url = "http://51.107.16.89:5000";

  PatientService();

  Future<void> savePatientChanges(BuildContext context, Patient patient) async {
    final apiUrl =
        url + "/patients"; // API endpoint to update patient's information

    // Construct the updated patient data
    Map<String, dynamic> updatedPatientData = {
      'resourceType': patient.resourceType,
      'id': patient.id,
      'active': patient.active,
      'name': [
        {
          'use': patient.name[0].use,
          'family': patient.name[0].family,
          'given': patient.name[0].given,
        },
      ],
      'gender': patient.gender,
    };

    try {
      final response = await http.put(
        Uri.parse(
            '$apiUrl/${patient.oid}'), // Assuming the API uses the patient's ID in the URL
        body: jsonEncode(updatedPatientData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Update successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Patient name updated successfully.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Update failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Failed to update patient name. Please try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Error occurred
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<List<Patient>> fetchPatients() async {
    final apiUrl = url + "/patients";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonList = jsonDecode(response.body);
      List<Patient> patients = (jsonList['patients'] as List<dynamic>)
          .map((json) => Patient.fromJson(json))
          .toList();
      return patients;
    } else {
      throw Exception('Failed to load patients');
    }
  }
}
