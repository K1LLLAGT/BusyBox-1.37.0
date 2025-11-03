package com.greg.busyboxwrapper

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.Environment
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import java.io.File
import java.io.FileOutputStream
import java.util.*

class MainActivity : AppCompatActivity() {

    private val busyboxAsset = "busybox"
    private lateinit var targetPath: File
    private lateinit var outputView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        outputView = findViewById(R.id.outputView)
        val installButton = findViewById<Button>(R.id.installButton)

        targetPath = File(filesDir, busyboxAsset)

        installButton.setOnClickListener {
            installBusyBox()
        }

        ActivityCompat.requestPermissions(this,
            arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
            1)
    }

    private fun installBusyBox() {
        try {
            val input = assets.open(busyboxAsset)
            val output = FileOutputStream(targetPath)
            input.copyTo(output)
            input.close()
            output.close()
            targetPath.setExecutable(true)

            val version = Runtime.getRuntime().exec(targetPath.absolutePath)
                .inputStream.bufferedReader().readLine()

            val appletCount = Runtime.getRuntime().exec("${targetPath.absolutePath} --list")
                .inputStream.bufferedReader().readLines().size

            val dashboard = """
                BusyBox Wrapper Report
                ----------------------
                Version: $version
                Applets: $appletCount
                Installed at: ${targetPath.absolutePath}
                Timestamp: ${Date()}
            """.trimIndent()

            val dashboardFile = File(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
                "busybox-wrapper-report.txt"
            )
            dashboardFile.writeText(dashboard)

            outputView.text = "✓ BusyBox installed\n✓ Dashboard exported to Downloads"
        } catch (e: Exception) {
            outputView.text = "❌ Installation failed: ${e.message}"
        }
    }
}
