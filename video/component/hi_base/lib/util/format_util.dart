/// 数字转万
String countFormat(int count) {
  String view = "";
  if (count > 9999) {
    view = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    view = count.toString();
  }
  return view;
}

/// 秒转分钟:秒
String durationTransform(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  return s < 10 ? "$m:0$s" : "$m:$s";
}
