import 'package:http/http.dart' as http;
import 'package:qrf/utils/constant.dart';

class PaperSearchProvider {
  Future<dynamic> getPaperByKeyword(String keyword) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_research_paper_search_keyword}$keyword"),
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

    Future<dynamic> getPaperByTag(String tag) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_research_paper_search_tag}$tag"),
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
