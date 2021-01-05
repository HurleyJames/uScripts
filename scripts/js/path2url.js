//本地路径转化为url形式打开
//前提安装好file-url
//npm install --save file-url
//node.js
var fileUrl = require('file-url');

console.log(fileUrl('/Users/hurley/Downloads/PRED-133.m3u8'))