import 'package:http/http.dart' as http;

class Network {
  static const baseUrl = "https://manager.pcghana.org/";

  /// send some data to a url using the post method
  ///
  static Future<http.Response> postData(String url, Map<String, dynamic> data) {
    return http.post(Uri.parse(baseUrl + url),
        headers: <String, String>{}, body: data);
  }

  // static Future<http.Response> getData()

}
