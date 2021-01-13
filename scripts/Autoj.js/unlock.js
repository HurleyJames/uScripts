function unlock() {
    this.unlock = function() {
        // 如果已经亮屏，则无需解锁
        if (device.isScreenOn()) {
            return;
        }

        // 唤醒屏幕
        device.wakeUp();
        sleep(1000);
        // 屏幕尺寸：1080x2340
        // 上滑屏幕到输入密码的界面;
        swipe(600, 1800, 600, 1000, 1000);
        sleep(1000);
        // 点击输入密码解锁
        click(540, 1620);
        sleep(500);
        click(860, 1620);
        sleep(500);
        click(540, 1350);
        sleep(500);
        click(250, 1150);
        sleep(500);
        click(850, 1750);
    };
}

module.exports = unlock;