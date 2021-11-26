import 'package:hi_net/core/hi_net_adapter.dart';
import 'package:hi_net/request/hi_base_request.dart';

class MockAdapter extends HiNETAdapter {
  @override
  Future<HiNETResponse<T>> send<T>(HiBaseRequest request) {
    return Future<HiNETResponse<T>>.delayed(const Duration(milliseconds: 3000),
        () {
      return HiNETResponse<T>(
          data: {'code': 1, 'message': 'success'} as T, statucode: 404);
    });
  }
}
