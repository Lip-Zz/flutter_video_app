# flutter_video_app
![Flutter](https://img.shields.io/badge/Flutter-2.5.3-green?style=flat-square)   ![Dart](https://img.shields.io/badge/Dart-2.14.4-green?style=flat-square)    ![Platform](https://img.shields.io/badge/Platforms-iOS&Android-green?style=flat-square)     ![Null safety](https://img.shields.io/badge/NullSafety-orange?style=flat-square) 

A flutter exercise project.
The login account and password are not verified, please fill in at will.

# Download:
* [Android](https://github.com/Zhao-Chuan/flutter_video_app/releases/download/1.0.0/app-release.apk)

# Attention
If you want to test the barrage function, you need to modify the address below to the corresponding websocket address. You can create your own websocket server with tools or languages ​​such as python.
```
static const String _url = "ws://192.168.50.238:2025";
```
Barrage data format
```Json
[{"content":"oooohhhhh!!!","vid":"-1","priority":0,"type":1},{"content":"amazing","vid":"-1","priority":0,"type":0},{"content":"xdxdxd","vid":"-1","priority":0,"type":0}]
```

# Requirements
* shared_preferences: ^2.0.7
* flutter_swiper_null_safety: ^1.0.0
* flutter_statusbar_manager:https://github.com/rafaelmaeuer/flutter_statusbar_manager.git
* flutter_staggered_grid_view:https://github.com/zliide/flutter_staggered_grid_view.git
* transparent_image: ^2.0.0
* chewie: ^1.2.2 
* video_player: ^2.2.7
* orientation: ^1.3.0
* url_launcher: ^6.0.13
* flutter_overlay: ^1.0.0
* provider: ^5.0.0
* flutter_nested: ^1.0.0
