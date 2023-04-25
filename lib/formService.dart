import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdgs_frontend/susForm.dart';

class FormService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:5005';
  String result = "";

  Future<String> postForm(SusForm susForm) async {
    final url = Uri.https(_baseUrl, '/api/susai');
    final resp = await http.post(url, body: susForm.toJson());
    final decodedData = json.decode(resp.body);

    result = decodedData['name'];

    print(result);

    return result;
  }
}
