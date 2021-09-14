enum HttpMethod { GET, POST, DELETE, PUT }

abstract class BaseRequest {
  /// path 参数
  var pathParams;

  /// 是否使用https
  var useHttps = true;

  /// 域名
  String authority() {
    return "api.devio.org";
  }

  /// 请求类型
  HttpMethod httpMethod();

  /// api地址
  String path();

  /// 请求地址
  String url() {
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    return uri.toString();
  }

  /// 接口是否需要登录
  bool needLogin();

  /// 请求参数
  Map<String, String> params = Map();

  /// 添加参数
  BaseRequest add(String k, String v) {
    params[k] = v.toString();
    return this;
  }

  /// 请求头参数
  Map<String, String> header = Map();

  /// 添加请求头参数
  BaseRequest addHeader(String k, String v) {
    header[k] = v.toString();
    return this;
  }
}
