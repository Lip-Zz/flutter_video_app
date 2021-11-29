class HiNETError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiNETError(this.code, this.message, {this.data});

  @override
  String toString() {
    return "${super.toString()},code:$code,message:$message,data:$data";
  }
}

/// 需要授权错误
class NeedAuth extends HiNETError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message, data: data);
}

/// 需要登录错误
class NeedLogin extends HiNETError {
  NeedLogin({int code: 401, String message: "请先登录"}) : super(code, message);
}
