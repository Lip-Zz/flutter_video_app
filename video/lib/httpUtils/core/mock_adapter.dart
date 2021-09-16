import 'package:video/httpUtils/core/hi_net_adapter.dart';
import 'package:video/httpUtils/request/base_request.dart';

class MockAdapter extends HiNETAdapter {
  @override
  Future<HiNETResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNETResponse<T>>.delayed(Duration(milliseconds: 3000), () {
      return HiNETResponse<T>(
          data: {'code': 1, 'message': 'success'} as T, statucode: 404);
    });
  }
}
