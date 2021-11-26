import 'package:hi_net/hi_net.dart';
import 'package:video/httpUtils/request/home_request.dart';
import 'package:video/model/homeModel.dart';

class HomeDao {
  static get(String categoryName, {int pageIndex = 1, int pageSize = 1}) async {
    HomeRequest request = HomeRequest();
    // request.pathParams = categoryName;
    request.add("pageIndex", pageIndex)..add("pageSize", pageSize);
    var result = await HiNET.getInstance().fire(request);
    return HomeModel.fromJson(result['data']);
  }
}
