import 'package:video/db/hi_cache.dart';
import 'package:video/httpUtils/core/hi_net.dart';
import 'package:video/httpUtils/request/base_request.dart';
import 'package:video/httpUtils/request/login_request.dart';
import 'package:video/httpUtils/request/register_request.dart';

class LoginDao {
  static String ACCESS_TOKEN = "accessToken";
  static login(String username, String password) async {
    return _send(username, password);
  }

  static register(String username, String password, String id) async {
    return _send(username, password, id: id);
  }

  static _send(String username, String password, {String? id}) async {
    BaseRequest request;
    if (id == null) {
      request = LoginRequest();
    } else {
      request = RegisterRequest();
    }

    request
        .add("username", username)
        .add("password", password)
        .add("id", id ?? "");

    var result = await HiNET.getInstance().fire(request);

    //登录成功，保存登录token
    if (result['code'] == 0 && result['data'] != null) {
      HiCache.getInstance().setString(ACCESS_TOKEN, result['data']);
    }
    return result;
  }

  static String getAccessToken() {
    return HiCache.getInstance().get<String>(ACCESS_TOKEN) ?? "";
  }
}
