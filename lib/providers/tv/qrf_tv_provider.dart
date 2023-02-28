import 'package:http/http.dart' as http;
import 'package:qrf/utils/constant.dart';

class TvProvider {
  Future<dynamic> getAllQrfTv() async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_qrftv}"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }

  Future<dynamic> getQrvTvByKeyword(String keyword) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_qrftv_search}$keyword"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }

  Future<dynamic> getQrvTvByCategory(String categoryId) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_qrftv_category}$categoryId"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }

  Future<dynamic> getQrvTvByTag(String tagId) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_qrftv_tag}$tagId"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }
}
