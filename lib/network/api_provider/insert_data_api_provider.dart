import 'dart:convert';
import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/contact_technician_model.dart';
import 'package:adam_company_consumer_app/network/model/user_insert_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddDataApiProvider with ChangeNotifier {
  Future<ContactTechnicianModel> sendMessage(UserInsert userInsert) async {
    Dio dio = new Dio();
    ContactTechnicianModel contactTechnicianModel;

    // print("=========Image:${userInsert.image}");
    FormData formData = FormData.fromMap({
      "service_id": userInsert.service_id.toString(),
      "consumer_id": userInsert.consumer_id.toString(),
      "technician_id": userInsert.technician_id.toString(),
      "message": userInsert.message.toString(),
      "image": userInsert.image == null ? "" : await MultipartFile.fromFile(
        userInsert.image.path,
        filename: userInsert.image.path.split('/').last,
      ),
    });

    // final responce = await http.post(contact_technician, body: {
    //   "service_id": userInsert.service_id.toString(),
    //   "consumer_id": userInsert.consumer_id.toString(),
    //   "technician_id": userInsert.technician_id.toString(),
    //   "message": userInsert.message.toString(),
    // });
    // print("send data = ${responce.body}");
    // final data = json.decode(responce.body);
    // if (responce.statusCode == 200 || responce.statusCode == "200") {
    //   contactTechnicianModel = ContactTechnicianModel.fromJson(data);
    // } else {
    //   contactTechnicianModel = ContactTechnicianModel.fromJson(data);
    // }

    await dio.post(contact_technician, data: formData).then((value) {
      // print("send data = ${value.data}");
      // print("send data = ${value.statusCode}");
      if (value.statusCode == 200 || value.statusCode == "200") {
        contactTechnicianModel = ContactTechnicianModel.fromJson(value.data);
      } else {
        contactTechnicianModel = ContactTechnicianModel.fromJson(value.data);
      }
    }).catchError((e) {
      ValidationData.customToast(
          e.toString(), Colors.red, Colors.white, ToastGravity.CENTER_RIGHT);
    });
    notifyListeners();
    return contactTechnicianModel;
  }
}
