import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sdgs_frontend/print.dart';
import 'package:sdgs_frontend/susForm.dart';

class FormService extends ChangeNotifier {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  final String _baseUrl = 'http://localhost:5005';
  String result = "";

  Future<void> makePostRequest(sus, context) async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$_baseUrl/api/susai');
    final headers = {"Content-type": "application/json"};
    print(sus.companyName);
    final json =
        '{    "company_name": "${sus.companyName}",    "company_goals": "${sus.companyGoals}",    "company_mission": "${sus.companyMission}",    "product_name": "${sus.productName}",    "product_description": "${sus.productDescription}",    "product_features": "${sus.productFeatures}",    "qna": "${sus.questionEnv}: ${sus.answerEnv}"}';
    final response = await http.post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SusafTable(jsonData: response.body.toString())));
  }

  void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }

  // Future<String> postForm(SusForm susForm) async {
  //   final url = Uri.https(_baseUrl, '/api/susai');
  //   final resp = await http.post(url, body: susForm.toJson());
  //   final decodedData = json.decode(resp.body);

  //   result = decodedData['name'];

  //   print(result);

  //   return result;
  // }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}
