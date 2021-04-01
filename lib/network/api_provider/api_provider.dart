import 'dart:convert';

import 'package:adam_company_consumer_app/common/api_url.dart';
import 'package:adam_company_consumer_app/network/model/get_main_category_model.dart';
import 'package:adam_company_consumer_app/network/model/get_quotation_details.dart';
import 'package:adam_company_consumer_app/network/model/get_technician_contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApiDataProvider with ChangeNotifier {
  Future<GetContactTechnicianModel> getContactTechnicianData(var userId) async {
    GetContactTechnicianModel getContactTechnicianModel;
    final response = await http
        .post(get_ongoing_technician, body: {"consumer_id": userId.toString()});
    // print("final data of get contact technician data : ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 200 || data['status'] == "200") {
        getContactTechnicianModel = GetContactTechnicianModel.fromJson(data);
      } else {
        getContactTechnicianModel = GetContactTechnicianModel(
            status: data['status'], message: data['message']);
      }
    } else {
      throw Exception("Can't load data");
    }
    notifyListeners();
    return getContactTechnicianModel;
  }

  Future<GetMainCategryModel> getMainCategory() async {
    GetMainCategryModel getMainCategryModel;
    final response = await http.get(get_main_service_category);
    // print("==============>>${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 200 || data['status'] == "200") {
        getMainCategryModel = GetMainCategryModel.fromJson(data);
      } else {
        getMainCategryModel = GetMainCategryModel(
            status: data['status'], message: data['message']);
      }
    } else {
      throw Exception("Can't load data");
    }
    notifyListeners();
    return getMainCategryModel;
  }

  Future<GetQuotationModel> getQuotationDetails(var serviceId) async {
    GetQuotationModel getQuotationModel;
    final responce = await http.get(quotation_detail + serviceId.toString());

    if (responce.statusCode == 200) {
      final data = json.decode(responce.body);
      if (data['status'] == 200 || data['status'] == "200") {
        print("==============>>${data}");
        getQuotationModel = GetQuotationModel.fromJson(data);
      } else {
        getQuotationModel =
            GetQuotationModel(status: data['status'], message: data['message']);
      }
    }
    notifyListeners();
    return getQuotationModel;
  }
}
