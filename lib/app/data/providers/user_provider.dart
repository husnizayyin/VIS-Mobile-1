import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vis_mobile/app/core/utils/api_url.dart';

class UserProvider {
  final url = Uri.parse(ApiUrl.baseUrl + EndPoint.profile);
  final urlDash = Uri.parse(ApiUrl.baseUrl + EndPoint.dash);
  var token;

  _getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('access');
  }

  _setHeaders() => {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<http.Response> dash() async {
    await _getToken();
    return http.get(
      urlDash,
      headers: _setHeaders(),
    );
  }

  Future<http.Response> profile() async {
    await _getToken();
    return http.get(
      url,
      headers: _setHeaders(),
    );
  }
}
