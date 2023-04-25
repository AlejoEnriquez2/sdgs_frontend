// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class SusForm {
  SusForm({
    this.companyName,
    this.companyMission,
    this.companyGoals,
    this.productName,
    this.productDescription,
    this.audience,
    this.productFeatures,
    this.questionEnv,
    this.questionSoc,
    this.questionInd,
    this.questionEco,
    this.questionTec,
    this.answerEnv,
    this.answerSoc,
    this.answerInd,
    this.answerEco,
    this.answerTec,
  });

  String? companyName;
  String? companyMission;
  String? companyGoals;
  String? productName;
  String? productDescription;
  String? audience;
  String? productFeatures;
  String? questionEnv;
  String? questionSoc;
  String? questionInd;
  String? questionEco;
  String? questionTec;
  String? answerEnv;
  String? answerSoc;
  String? answerInd;
  String? answerEco;
  String? answerTec;

  factory SusForm.fromRawJson(String str) => SusForm.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SusForm.fromJson(Map<String, dynamic> json) => SusForm(
        companyName: json["company_name"],
        companyMission: json["company_mission"],
        companyGoals: json["company_goals"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        audience: json["audience"],
        productFeatures: json["product_features"],
        questionEnv: json["question_env"],
        questionSoc: json["question_soc"],
        questionInd: json["question_ind"],
        questionEco: json["question_eco"],
        questionTec: json["question_tec"],
        answerEnv: json["answer_env"],
        answerSoc: json["answer_soc"],
        answerInd: json["answer_ind"],
        answerEco: json["answer_eco"],
        answerTec: json["answer_tec"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_goals": companyGoals,
        "company_mmission": companyMission,
        "product_name": productName,
        "product_description": productDescription,
        "audience": audience,
        "product_features": productFeatures,
        "question_env": questionEnv,
        "question_soc": questionSoc,
        "question_ind": questionInd,
        "question_eco": questionEco,
        "question_tec": questionTec,
        "answer_env": answerEnv,
        "answer_soc": answerSoc,
        "answer_ind": answerInd,
        "answer_eco": answerEco,
        "answer_tec": answerTec,
      };
}
