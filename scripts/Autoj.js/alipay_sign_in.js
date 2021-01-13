// 检查无障碍服务是否启动
auto.waitFor();
var utils = require("./utils.js");
var unlock = require("./unlock.js");

var alipay = new utils("com.eg.android.AlipayGphone");
alipay.before();
new unlock().unlock();
alipay.sleep(2);

// 先杀死已经打开的Alipay
app.openAppSetting("com.eg.android.AlipayGphone");
while (!click("强制停止"));

alipay.launch();
// alipay.kill();
alipay.sleep(1);
toastLog("测试");
// app.launchApp("支付宝");
// alipay.launchActivity("com.eg.android.AlipayGphone.AlipayLogin");
// app.startActivity("com.eg.android.AlipayGphone.AlipayLogin");

// 关闭更新弹窗
if (id("update_cancel_tv").exists()) {
    alipay.clickIdCenter("update_cancel_tv");
    alipay.sleep(2);
}

alipay.clickTextCenter("我的");
alipay.sleep(4);
alipay.clickTextCenter("支付宝会员");
alipay.sleep(4);
if (desc("弹屏").exists()) {
    // 关闭支付宝会员每日弹窗
    alipay.clickDescCenter("关闭");
    alipay.sleep(1);
}

// 点击「每次赚积分」
alipay.clickDescCenter("每日赚积分");
alipay.sleep(4);


alipay.kill();
alipay.after();