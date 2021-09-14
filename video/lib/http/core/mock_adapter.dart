import 'package:video/http/core/hi_net_adapter.dart';
import 'package:video/http/request/base_request.dart';

class MockAdapter extends HiNETAdapter {
  @override
  Future<HiNETResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNETResponse<T>>.delayed(Duration(milliseconds: 3000), () {
      return HiNETResponse<T>(
          data: {'code': 1, 'message': 'success'} as T, statucode: 404);
    });
  }
}
