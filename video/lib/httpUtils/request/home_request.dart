import 'package:hi_net/request/hi_base_request.dart';
import 'package:video/httpUtils/request/base_request.dart';

class HomeRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "/app/mock/290747/home";
  }
}
