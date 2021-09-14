import 'dart:convert';
import 'package:video/http/request/base_request.dart';

class HiNETResponse<T> {
  T? data;
  BaseRequest? request;
  int? statucode;
  String? statusMessage;
  dynamic extra;

  HiNETResponse(
      {this.data,
      this.request,
      this.statucode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return jsonEncode(data);
    }

    return data.toString();
  }
}

abstract class HiNETAdapter {
  Future<HiNETResponse<T>> send<T>(BaseRequest request);
}
