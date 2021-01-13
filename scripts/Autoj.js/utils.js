function utils(packageName) {
    this.packageName = packageName;

    if (packageName && !app.getAppName(packageName)) {
        toast("找不到该应用");
        this.sleep(1000);
        exit();
    }

    // 点击中心
    this.clickCenter = function(widget) {
        if (!widget) {
            return false;
        }
        let rect = widget.bounds();
        return click(rect.centerX(), rect.centerY());
    };

    // 点击选择器的中心
    this.clickSelectorCenter = function(selector) {
        if (!selector) {
            return false;
        }
        let widget = selector.findOne(2000);
        return this.clickCenter(widget);
    }

    // 点击ID控件的中心
    this.clickIdCenter = function(idStr) {
        if (!idStr) {
            return false;
        }
        return this.clickSelectorCenter(id(idStr));
    };

    // 点击文本的中心
    this.clickTextCenter = function(str) {
        if (!str)
            return false;
        return this.clickSelectorCenter(text(str));
    };

    // 点击描述的中心
    this.clickDescCenter = function(str) {
        if (!str) {
            return false;
        }
        return this.clickSelectorCenter(desc(str));
    };

    this.shell = function(command) {
        shell(command, true);
    }

    // 启动应用
    this.launch = function() {
        app.launch(this.packageName);
    }

    // 等待某个活动执行
    this.wairForActivity = function(activityName) {
        waitForActivity(activityName, 200);
    }

    // 启动某个活动
    this.launchActivity = function(activityName) {
        shell("am start -n " + this.packageName + "/" + activityName, true);
        waitForActivity(activityName);
    }

    // 使该应用进入睡眠
    this.sleep = (second) => {
        sleep(second * 1000);
    }

    // 杀死该应用进程
    this.kill = function() {
        shell("am force-stop " + this.packageName, true);
    }

    // 执行脚本前
    this.before = function(ignoreSleep) {
        // let source = engines.myEngine().source.toString();
        // source = source.replace("/storage/emulated/0/脚本/", "");
        // toast("开始执行[" + source + "]...");

        // 宽高中，短的作为宽
        const width = Math.min(device.width, device.height);
        // 宽高中，长的作为高
        const height = Math.max(device.width, device.height);
        setScreenMetrics(width, height);
        if (!ignoreSleep) {
            // 随机睡眠[0-10]秒，使签到的时间不固定
            sleep(random() * 10);
        }
    }

    // 执行脚本后
    this.after = function() {
        // let source = engines.myEngine().source.toString();
        // source = source.replace("/storage/emulated/0/脚本", "");
        // toast("结束执行[" + source + "]...");
        exit();
    }
}

module.exports = utils;