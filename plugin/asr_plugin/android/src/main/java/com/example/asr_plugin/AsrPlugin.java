package com.example.plugin.asr;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrPlugin implements MethodChannel.MethodCallHandler {
    private final static String TAG = "AsrPlugin";
    private final Activity activity; // 在实例化中初始值
    private ResultStateful resultStateful;
    private AsrManager asrManager;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        // 与dart端通信，registrar.messenger()接收发送过来的数据
        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr_plugin");
        AsrPlugin instance = new AsrPlugin(registrar);
    }

    // 实例化类的方法
    public AsrPlugin(PluginRegistry.Registrar registrar) {
        // 获取action
        this.activity = registrar.activity();
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        initPermission(); // 声请权限
        // 处理dart端发过来的指令
        switch (methodCall.method) {
        case "start":
            // 开启录音
            resultStateful = ResultStateful.of(result);
            start(methodCall, resultStateful);
            break;
        case "stop":
            // 停止录音
            stop(methodCall, result);
            break;
        case "cancel":
            // 取消录音
            cancel(methodCall, result);
            break;
        default:
            result.notImplemented(); // 如果调用未知方法，告诉dart端方法没有实现
        }
    }

    private void start(MethodCall methodCall, ResultStateful result) {
        if (activity == null) {
            Log.e(TAG, "Ignored start, current activity is null");
            result.error("Ignored start, current activity is null", null, null);
            return;
        }
        if (getAsrManager() != null) {
            // 传入的参数强制转换成map类型
            getAsrManager().start(methodCall.arguments instanceof Map ? (Map) methodCall.arguments : null);
        } else {
            Log.e(TAG, "Ignored start, current activity is null");
            result.error("Ignored start, current activity is null", null, null);
        }
    }

    private void stop(MethodCall call, MethodChannel.Result result) {
        if (asrManager != null) {
            asrManager.stop();
        }
    }

    private void cancel(MethodCall call, MethodChannel.Result result) {
        if (asrManager != null) {
            asrManager.cancel();
        }
    }

    @Nullable
    private AsrManager getAsrManager() {
        if (asrManager == null) {
            // activity有值时，并且没有被销毁时
            if (activity != null && !activity.isFinishing()) {
                // 传入上下文、listener实例对象
                asrManager = new AsrManager(activity, onAsrListener);
            }
        }
        return asrManager;
    }

    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String permissions[] = { Manifest.permission.RECORD_AUDIO, Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET, Manifest.permission.WRITE_EXTERNAL_STORAGE };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm : permissions) {
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                // 进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()) {
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }

    // onAsrListener类（以下实现百度语音的方法抽象类），具体用到哪个就实现哪个方法
    private OnAsrListener onAsrListener = new OnAsrListener() {
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        // 最终识别返回的结果
        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            if (resultStateful != null) {
                // 把语音返回的结果传入到统一管理的状态中， 只取结果的第一个元素即可
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        // 识别发生错误的时候
        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (resultStateful != null) {
                // errorCode强制转成字符串
                resultStateful.error(String.valueOf(errorCode), descMessage, recogResult);
            }
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };
}
