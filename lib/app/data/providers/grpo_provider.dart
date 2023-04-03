import 'package:shared_preferences/shared_preferences.dart';
import 'package:vis_mobile/app/core/utils/api_url.dart';
import 'package:http/http.dart' as http;

class GrpoProvider {
  var url = Uri.parse(ApiUrl.baseUrl + EndPoint.grpo);
  var token;

  _getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('access');
  }

  _setHeaders() => {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<http.Response> fetchGrpo() async {
    await _getToken();
    return http.get(
      url,
      headers: _setHeaders(),
    );
  }
}
