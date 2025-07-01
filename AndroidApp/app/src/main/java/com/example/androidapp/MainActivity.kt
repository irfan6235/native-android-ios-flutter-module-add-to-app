// package com.example.androidapp

// import androidx.appcompat.app.AppCompatActivity
// import android.os.Bundle
// import android.widget.Button
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.embedding.engine.FlutterEngineCache
// import io.flutter.embedding.engine.dart.DartExecutor

// private const val FLUTTER_ENGINE_ID = "module_flutter_engine"

// class MainActivity : AppCompatActivity() {
//     lateinit var flutterEngine : FlutterEngine
//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)
//         setContentView(R.layout.activity_main)

//         // Instantiate a FlutterEngine
//         flutterEngine = FlutterEngine(this)

//         // Start executing Dart code to pre-warm the FlutterEngine
//         flutterEngine.dartExecutor.executeDartEntrypoint(
//             DartExecutor.DartEntrypoint.createDefault()
//         )

//         // Cache the FlutterEngine to be used by FlutterActivity
//         FlutterEngineCache
//             .getInstance()
//             .put(FLUTTER_ENGINE_ID, flutterEngine)

//         val myButton = findViewById<Button>(R.id.myButton)
//         myButton.setOnClickListener {
//             startActivity(
//                 FlutterActivity
//                     .withCachedEngine(FLUTTER_ENGINE_ID)
//                     .build(this)
//             )
//         }
//     }
// }


package com.example.androidapp

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

private const val FLUTTER_ENGINE_ID = "module_flutter_engine"
private const val CHANNEL = "jodetx/payment"

class MainActivity : AppCompatActivity() {
    private lateinit var flutterEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // 1. Setup FlutterEngine
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine)

        // 2. Receive callback via MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    .setMethodCallHandler { call, result ->
        if (call.method == "paymentResult") {
            val status = call.argument<String>("status") ?: "Unknown"
            val amount = call.argument<Double>("amount") ?: 0.0
            val message = "Payment $status for ₹$amount"

            // Show dialog
            runOnUiThread {
                AlertDialog.Builder(this)
                    .setTitle("Payment Result")
                    .setMessage(message)
                    .setPositiveButton("OK", null)
                    .show()
            }

            result.success(null)
        }
    }


        // 3. Launch Flutter Module on Button Click
        findViewById<Button>(R.id.myButton).setOnClickListener {
            val intent = FlutterActivity
                .withCachedEngine(FLUTTER_ENGINE_ID)
                .build(this)
            startActivity(intent)
        }
    }

    override fun onDestroy() {
        flutterEngine.destroy()
        super.onDestroy()
    }
}
