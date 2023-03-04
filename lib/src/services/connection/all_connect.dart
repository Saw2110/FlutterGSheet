import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:passmanager/src/model/model.dart';

import 'connection_credentials.dart';
import 'get_worksheet.dart';

class GSheetConnection {
  static final hidePass = GSheets(ConnectCredential.credentials);
  static Worksheet? userDetailSheet, passManagerSheet;
  static Future init() async {
    final spreadsheet =
        await hidePass.spreadsheet(ConnectCredential.hidePassID);

    /// Default UserDetail Column updated on Start
    final userDetailFirstRow = UserRegisterModel.getFields();
    userDetailSheet =
        await GetWorkSheet.getWorkSheet(spreadsheet, title: 'UserDetails');
    userDetailSheet!.values.insertRow(1, userDetailFirstRow);

    /// Default PassManager Column updated on Start
    final passManagerFirstRow = PassRegisterModel.getFields();
    passManagerSheet =
        await GetWorkSheet.getWorkSheet(spreadsheet, title: 'PassManager');
    passManagerSheet!.values.insertRow(1, passManagerFirstRow);
  }

  static Future insertToUserDetails(List<Map<String, dynamic>> rowData) async {
    if (userDetailSheet == null) return;
    userDetailSheet!.values.map.appendRows(rowData);
  }

  static Future insertToPassManager(List<Map<String, dynamic>> rowData) async {
    if (passManagerSheet == null) return;
    passManagerSheet!.values.map.appendRows(rowData);
  }

  static Future<List<UserResponseModel>> getUserByContactNumber(
      {required String phoneNumber, required String password}) async {
    //
    if (userDetailSheet == null) return [];

    List<UserResponseModel> userList = await getAllUsersList();
    List<UserResponseModel> filterData = userList
        .where((i) => (i.contact == phoneNumber && i.password == password))
        .toList();
    //
    return filterData.isEmpty ? [] : filterData;
  }

  ///
  static Future<List<UserResponseModel>> getAllUsersList() async {
    ///
    if (userDetailSheet == null) return <UserResponseModel>[];
    //
    final userJson = await userDetailSheet!.values.map.allRows();

    List<UserResponseModel> result = (userJson != null)
        ? userJson.map(UserResponseModel.fromJson).toList()
        : [];

    debugPrint("Response Data => ${jsonEncode(result)}");

    return result;
  }

  static Future<List<PassResponseModel>> getPasswordByContactNumber(
      {required String phoneNumber}) async {
    //
    if (passManagerSheet == null) return [];

    List<PassResponseModel> userList = await getAllPassword();
    List<PassResponseModel> filterData =
        userList.where((i) => (i.contact == phoneNumber)).toList();
    //
    return filterData.isEmpty ? [] : filterData;
  }

  ///
  static Future<List<PassResponseModel>> getAllPassword() async {
    ///
    if (passManagerSheet == null) return <PassResponseModel>[];
    //
    final userJson = await passManagerSheet!.values.map.allRows();

    List<PassResponseModel> result = (userJson != null)
        ? userJson.map(PassResponseModel.fromJson).toList()
        : [];

    debugPrint("Response Data => ${jsonEncode(result)}");

    return result;
  }
}

class NetworkError extends Error {}
