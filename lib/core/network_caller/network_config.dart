// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum RequestMethod { GET, POST, PUT, DELETE }

class NetworkConfig {
  Future ApiRequestHandler(RequestMethod method, url, json_body,
      {is_auth = false}) async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    if (await InternetConnectionChecker().hasConnection) {
      var header = <String, String>{"Content-type": "application/json"};
      if (is_auth == true) {
        //   header["Authorization"] = "${sh.getString("token")}";
        header["Authorization"] =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NTEzZmY3ZjI1NmFhNzQwZTllMzY2NyIsImVtYWlsIjoiaGlrYWYxMTAzOUBjYWxvcnBnLmNvbSIsInJvbGUiOiJVU0VSIiwiaXNBbGxvd2VkIjpmYWxzZSwiaWF0IjoxNzUwMTU1MzA5LCJleHAiOjE3NTI3NDczMDl9.gqT5CxQMpJccN1oix66nrhmZY5QA6UHMcL4hJzlc4E0";
      }

      if (method.name == RequestMethod.GET.name) {
        try {
          var req = await http.get(Uri.parse(url), headers: header);
          log("joybanlga  $url \n ${req.body} \n ${req.statusCode} ");

          print(req.statusCode);
          if (req.statusCode == 200 || req.statusCode == 201) {
            return json.decode(req.body);
          } else {
            throw Exception("Server Error");
          }
        } catch (e) {
          ShowError(e);
        }
      } else if (method.name == RequestMethod.POST.name) {
        try {
          var req =
              await http.post(Uri.parse(url), headers: header, body: json_body);

          print(req.body);
          if (req.statusCode == 200) {
            return json.decode(req.body);
          } else if (req.statusCode == 500) {
            throw Exception("Server Error");
          } else {
            throw Exception('try aging after some time');
          }
        } catch (e) {
          ShowError(e);
        }
      } else if (method.name == RequestMethod.PUT.name) {
        try {
          var req =
              await http.put(Uri.parse(url), headers: header, body: json_body);

          print("fdasdasfasdasdf $header");
          print(req.statusCode);
          if (req.statusCode == 200) {
            return json.decode(req.body);
          } else {
            return json.decode(req.body);

            //  throw Exception("Server Error");
          }
        } catch (e) {
          ShowError(e);
        }
      } else if (method.name == RequestMethod.DELETE.name) {
        try {
          var req = await http.delete(Uri.parse(url), headers: header);

          print(req.statusCode);
          print(req);
          if (req.statusCode == 200) {
            return json.decode(req.body);
          } else {
            throw Exception("Server Error");
          }
        } catch (e) {
          ShowError(e);
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Please Connect Internet");
    }
  }

  ShowError(msg) {
    Fluttertoast.showToast(
        msg: msg.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
