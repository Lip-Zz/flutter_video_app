import 'package:video/httpUtils/request/base_request.dart';

class RegisterRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/app/mock/290747/register";
  }
}
