import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/core/hi_net_adapter.dart';
import 'package:video/httpUtils/request/base_request.dart';

class DioAdapter extends HiNETAdapter {
  @override
  Future<HiNETResponse<T>> send<T>(BaseRequest request) async {
    var response;
    var options = Options(headers: request.header);
    var error;

    // Dio dio = Dio();
    /// 请求忽略证书
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback = (cert, host, port) {
    //     return true;
    //   };
    // };

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await Dio().get(request.url(), options: options);
          break;
        case HttpMethod.POST:
          response = await Dio()
              .post(request.url(), options: options, data: request.params);
          break;
        case HttpMethod.DELETE:
          response = await Dio()
              .delete(request.url(), options: options, data: request.params);
          break;
        case HttpMethod.PUT:
          response = await Dio()
              .put(request.url(), options: options, data: request.params);
          break;
        default:
          break;
      }
    } on DioError catch (e) {
      response = e.response;
      error = e;
    } catch (e) {
      error = e;
    }

    if (error != null) {
      throw HiNETError(response?.statusCode ?? -1, error.toString(),
          data: _buildResponse(response, request));
    }

    return _buildResponse(response, request);
  }

  /// 根据dio的response 生成hinetresponse
  _buildResponse(Response? response, BaseRequest request) {
    return HiNETResponse(
      statucode: response?.statusCode ?? -1,
      request: request,
      data: response?.data,
      statusMessage: response?.statusMessage,
      extra: response,
    );
  }
}
