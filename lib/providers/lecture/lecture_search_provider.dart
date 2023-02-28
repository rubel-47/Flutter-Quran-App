import 'package:http/http.dart' as http;
import 'package:qrf/utils/constant.dart';

class LectureSearchProvider {
  Future<dynamic> getLectureByKeyword(String keyword) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_lecture_search_keyword}$keyword"),
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

  Future<dynamic> getLectureByTag(int tagId) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_lecture_search_tag}$tagId"),
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

  Future<dynamic> getLectureByCategory(int categoryId) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_lecture_search_category}$categoryId"),
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
