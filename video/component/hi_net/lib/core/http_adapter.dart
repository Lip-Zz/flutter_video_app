import 'dart:io';

import 'package:hi_net/core/hi_error.dart';
import 'package:hi_net/core/hi_net_adapter.dart';
import 'package:hi_net/request/hi_base_request.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class HttpAdapter extends HiNETAdapter {
  @override
  Future<HiNETResponse<T>> send<T>(HiBaseRequest request) async {
    http.Response? response;
    var error;
    var url = Uri.parse(request.url());

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await sslClient().get(url, headers: request.header);
          break;
        case HttpMethod.POST:
          response = await sslClient()
              .post(url, headers: request.header, body: request.params);
          break;
        case HttpMethod.DELETE:
          response = await sslClient()
              .delete(url, headers: request.header, body: request.params);
          break;
        case HttpMethod.PUT:
          response = await sslClient()
              .put(url, headers: request.header, body: request.params);
          break;
        default:
          break;
      }
    } catch (e) {
      error = e;
    }

    if (error != null) {
      throw HiNETError(response?.statusCode ?? -1, error.toString(),
          data: _buildResponse(response, request));
    }

    return _buildResponse(response, request);
  }

  /// 忽略证书
  http.Client sslClient() {
    var ioClient = HttpClient()
      ..badCertificateCallback = (cert, host, port) => true;
    http.Client _client = IOClient(ioClient);
    return _client;
  }

  _buildResponse(http.Response? response, HiBaseRequest request) {
    return HiNETResponse(
      statucode: response?.statusCode ?? -1,
      request: request,
      data: response?.body,
      statusMessage: response?.reasonPhrase,
      extra: response,
    );
  }
}
