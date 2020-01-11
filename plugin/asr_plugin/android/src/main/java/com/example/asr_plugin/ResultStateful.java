package com.example.plugin.asr;

import android.nfc.Tag;

import androidx.annotation.Nullable;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;

// 统一管理dart端返回的状态结果
public class ResultStateful implements MethodChannel.Result {
    private final static String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private boolean called; // 标识，防止重复调用

    // 统一暴露方法，获取实例
    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    // 实例方法，定义必须传入的参数
    private ResultStateful(MethodChannel.Result result) {
        this.result = result; // 保存传入的状态，内部共享使用
    }

    // 调用成功后
    @Override
    public void success(@Nullable Object o) {
        if (called) {
            printError();
            return;
        }
        called = true;
        result.success(0);
    }

    @Override
    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
        if (called) {
            printError();
            return;
        }
        called = true;
        result.error(errorCode, errorMessage, errorDetails);
    }

    // 没有被实现封装的方法
    @Override
    public void notImplemented() {
        if (called) {
            printError();
            return;
        }
        called = true;
        result.notImplemented();
    }

    private void printError() {
        Log.e(TAG, "error: result called");
    }
}
