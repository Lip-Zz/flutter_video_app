package com.example.video

import android.graphics.Color
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.LOLLIPOP){
            activity.window.statusBarColor = Color.TRANSPARENT;
        }
    }
}
