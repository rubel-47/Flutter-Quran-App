import 'package:http/http.dart' as http;
import 'package:qrf/utils/constant.dart';

class BookmarkNoteProvider {
  Future<dynamic> addBookmarkNote(
      String userId, String suraId, String ayatId, String type) async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse("${BASE_URL + endpoint_create_bookmark}"),
        body: {
          "user_id": userId,
          "sura_id": suraId,
          "ayat_id": ayatId,
          "type": type,
        },
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

  Future<dynamic> addNote(
      String userId, String suraId, String ayatId, String type,String message) async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse("${BASE_URL + endpoint_create_bookmark}"),
        body: {
          "user_id": userId,
          "sura_id": suraId,
          "ayat_id": ayatId,
          "type": type,
          "message":message
        },
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

  Future<dynamic> getBookmarkNote(String userId, String type) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_get_bookmark}")
            .replace(queryParameters: {"user_id": userId, "type": type}),
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

  Future<dynamic> deleteBookmarkNote(String bookmarkNoteId) async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_delete_bookmark_note}$bookmarkNoteId"),
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
