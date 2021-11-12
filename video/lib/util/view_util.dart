import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 图片本地缓存
Widget cacheNetworkImage(String url, {double? height, double? width}) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    width: width,
    height: height,
    placeholder: (context, url) => Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Icon(
        Icons.local_dining,
        color: Colors.white,
        size: 10,
      ),
    ),
    errorWidget: (context, url, error) => Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Icon(
        Icons.error,
        color: Colors.white,
        size: 10,
      ),
    ),
  );
}
