var sh = new Shell(true);
//强制停止微信
sh.exec("am start -p com.tencent.mm");
sh.exit();