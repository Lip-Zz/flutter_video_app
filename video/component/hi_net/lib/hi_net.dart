library hi_net;

import 'package:hi_net/core/dio_adapter.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_net/core/hi_interceptor.dart';
import 'package:hi_net/core/hi_net_adapter.dart';
import 'package:hi_net/request/hi_base_request.dart';

class HiNET {
  HiNET._();
  static HiNET? _instance;
  static HiNET getInstance() {
    if (_instance == null) {
      _instance = HiNET._();
    }
    return _instance!;
  }

  HiErrorInterceptor? _hiErrorInterceptor;

  // factory HiNET() {
  //   if (_instance == null) {
  //     _instance = HiNET._();
  //   }
  //   return _instance!;
  // }

  Future<HiNETResponse<T>> _send<T>(HiBaseRequest request) async {
    printLog("请求地址(url):${request.url()}");
    printLog("请求类型(method):${request.httpMethod()}");
    printLog("请求头(header):${request.header}");
    printLog("请求参数(params):${request.params}");
    // HiNETAdapter adpter = MockAdapter();
    // return adpter.send(request);

    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  /// 发送请求
  Future fire(HiBaseRequest request) async {
    HiNETResponse? response;
    var error;

    try {
      response = await _send(request);
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
    var hiError;
    switch (statusCode) {
      case 200:
        printLog("请求结果:$result");
        return result;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
        hiError = HiNETError(statusCode, result.toString(), data: result);
        break;
    }

    //交给拦截器处理错误
    if (_hiErrorInterceptor != null) {
      _hiErrorInterceptor!(hiError);
    }
  }

  void setErrorInterceptor(HiErrorInterceptor interceptor) {
    this._hiErrorInterceptor = interceptor;
  }

  printLog(log) {
    print("HiNET-$log");
  }
}
