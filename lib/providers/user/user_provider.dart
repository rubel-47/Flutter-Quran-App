import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/utils/constant.dart';

class UserProvider {
  Future<dynamic> signup(String name, String email, String mobile,
      String password, String confirmPassword, String address) async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse("${BASE_URL + endpoint_signup}"),
        body: {
          "name": name,
          "mobile": mobile,
          "password": password,
          "confirm_password": confirmPassword,
          "email": email,
          "address": address,
        },
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var status = data['status'];
        if (status == 200) {
          return response.body;
        } else {
          toast(data['message']);
          return null;
        }
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }

  Future<dynamic> signin(String mobile, String password) async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse("${BASE_URL + endpoint_signin}"),
        body: {
          "mobile": mobile,
          "password": password,
        },
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );
      
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var status = data['status'];
        if (status == 200) {
          return response.body;
        } else {
          toast(data['message']);
          return null;
        }
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }
}
