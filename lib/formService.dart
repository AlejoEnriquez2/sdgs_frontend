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
//     String response = '''{
//   "company_name": "Elisa",
//   "company_goals": "Climate action, circular economy, responsible supply chain, Digital inclusion, Employee well-being.",
//   "company_mission": "Elisa's mission is to create sustainable digital life for their customers and society. They aim to achieve this mission by providing innovative and reliable services and solutions that are driven by customer needs and preferences, while at the same time ensuring sustainable and responsible business practices.",
//   "product_name": "Elisa Viihde",
//   "product_description": "Elisa Viihde is a TV and video streaming service offered by Elisa, a telecommunications and digital services company based in Finland. The service provides access to a wide range of TV channels, movies, and series, which can be watched on multiple platforms, including smart TVs, mobile devices, and web browsers.",
//   "features": [
//     {
//       "feature": "TV channels",
//       "effect": "Positive: Provides entertainment and information to users. Negative: Consumption of energy and resources in the production and distribution of TV channels.",
//       "order": "Immediate (first order)",
//       "dimension": "Social"
//     },
//     {
//       "feature": "Video-on-demand",
//       "effect": "Positive: Provides entertainment and convenience to users. Negative: Consumption of energy and resources in the production and distribution of movies and TV series.",
//       "order": "Immediate (first order)",
//       "dimension": "Social"
//     },
//     {
//       "feature": "Cloud recording",
//       "effect": "Positive: Provides convenience and flexibility to users. Negative: Consumption of energy and resources in the production and maintenance of cloud storage infrastructure.",
//       "order": "Immediate (first order), Enabling (second order)",
//       "dimension": "Technical"
//     },
//     {
//       "feature": "Personalized recommendations",
//       "effect": "Positive: Provides convenience and helps users discover new content. Negative: Consumption of energy and resources in the production and maintenance of recommendation algorithms.",
//       "order": "Immediate (first order), Enabling (second order)",
//       "dimension": "Individual"
//     }
//   ],
//   "threats": "The consumption of energy and resources in the production and distribution of content and infrastructure can have negative impacts on the environment and contribute to climate change.",
//   "opportunities": "Elisa can explore ways to reduce the environmental impact of their content production and distribution, such as using renewable energy sources and optimizing their infrastructure. They can also promote sustainable consumption habits among their users.",
//   "actions": "Elisa can conduct a sustainability assessment of their content production and distribution processes and identify areas for improvement. They can also communicate their sustainability efforts to their customers and stakeholders to raise awareness and promote sustainable practices."
// }''';

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
