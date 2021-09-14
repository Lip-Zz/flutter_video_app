import 'package:video/http/core/hi_error.dart';
import 'package:video/http/core/hi_net_adapter.dart';
import 'package:video/http/core/mock_adapter.dart';
import 'package:video/http/request/base_request.dart';

class HiNET {
  HiNET._();
  static HiNET? _instance;
  static HiNET getInstance() {
    if (_instance == null) {
      _instance = HiNET._();
    }
    return _instance!;
  }

  // factory HiNET() {
  //   if (_instance == null) {
  //     _instance = HiNET._();
  //   }
  //   return _instance!;
  // }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog("请求地址(url):${request.url()}");
    printLog("请求类型(method):${request.httpMethod()}");
    printLog("请求头(header):${request.header}");
    printLog("请求参数(params):${request.params}");
    HiNETAdapter adpter = MockAdapter();
    return adpter.send(request);
  }

  /// 发送请求
  Future fire(BaseRequest request) async {
    HiNETResponse? response;
    var error;

    try {
      response = await send(request);
    } on HiNETError catch (e) {
      error = e;
      response = e.data;
      printLog("HiNETError:${e.message}");
    } catch (e) {
      error = e;
      printLog("其他错误:$e");
    }

    if (response == null) {
      printLog("请求结果为空:$error");
    }

    var statusCode = response?.statucode ?? 0;
    var result = response?.data;

    switch (statusCode) {
      case 200:
        printLog("请求结果:$result");
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNETError(statusCode, result.toString(), data: result);
    }
  }

  printLog(log) {
    print("HiNET-$log");
  }
}
