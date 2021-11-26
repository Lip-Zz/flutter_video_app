import 'dart:convert';

import 'package:hi_net/request/hi_base_request.dart';

class HiNETResponse<T> {
  T? data;
  HiBaseRequest? request;
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
  Future<HiNETResponse<T>> send<T>(HiBaseRequest request);
}
