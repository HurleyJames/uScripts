/// ---- App ----

// toastLog(app.versionCode);
// toastLog(app.versionName);
// app.launchApp("Share");
// 打开微信（应用包名）
// app.launch("com.tencent.mm");
// 根据应用名称获得包名
// var name = app.getPackageName("QQ");

/// ---- Device ----

// toastLog(device.width);
// toastLog(device.height);
// 修订版本号
// toastLog(device.buildId);
// 厂商品牌，OnePlus
// toastLog(device.brand);
// 设备名称，OnePlus6T
// toastLog(device.device);
// 设备型号，ONEPLUS A6010
// toastLog(device.model);
// 整个产品的名称，OnePlus6T
// toastLog(device.product);
// Android系统版本号
// toastLog(device.release);
// 获取IMEI号，可能会没有读取设备权限
// toastLog(device.getIMEI());

/// ---- Dialog ----
// alert("测试");

// var clear = confirm("要清除所有缓存吗？");
// if (clear) {
//     alert("清除成功！");
// }

// 回调形式
// confirm("要清除所有缓存吗？", function(clear) {
//     if (clear) {
//         alert("清除成功！");
//     }
// });

// Promise形式
// confirm("要清除所有缓存吗？").then(clear => {
//     if (clear) {
//         alert("清除成功！");
//     }
// })

// 显示或取消时会toast的信息
// dialogs.build({
//     title: "标题",
//     positive: "确定",
//     negative: "取消",
// }).on("show", (dialog) => {
//     toast("对话框显示了");
// }).on("cancel", (dialog) => {
//     toast("对话框取消了");
// }).show();

// 点击确定或者取消时会出现的信息
// dialogs.build({
//     title: "标题",
//     positive: "确定",
//     negative: "取消",
// }).on("positive", (dialog) => {
//     toast("对话框显示了");
// }).on("negative", (dialog) => {
//     toast("对话框取消了");
// }).show();