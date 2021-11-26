import 'package:hi_net/request/hi_base_request.dart';
import 'package:video/httpUtils/dao/login_dao.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    /// 为需要登录的接口设置token
    if (needLogin()) {
      addHeader(LoginDao.accessTOKEN, LoginDao.getAccessToken());
    }
    return super.url();
  }

  /// 请求头参数
  Map<String, String> header = {'1': '1'};
}
