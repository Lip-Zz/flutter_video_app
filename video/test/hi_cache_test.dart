import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/db/hi_cache.dart';

void main() {
  test('测试HiCache', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({});

    await HiCache.preInit();
    var key = "testHiCache";
    var value = "1212";
    HiCache.getInstance().setString(key, value);

    expect(HiCache.getInstance().get(key), value);
  });
}
