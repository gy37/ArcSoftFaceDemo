# ArcSoftFaceDemo
### 虹软人脸识别demo

最近公司要在APP上添加一个人脸识别功能，在网上搜了一圈，发现虹软的人脸识别SDK挺好用的，而且还免费，所以就下载了他们的SDK研究了一下。总的来看功能挺好用的，只是demo上面部分功能不是很完善，所以就在官方demo的基础上改动了一些小的功能。

##### 新增功能：
1. 通过图片注册人脸
2. 增加列表页面可以查看和删除人脸信息
3. video检测页面添加按钮切换前后置摄像头

##### 官方demo功能：
1. 静态图片检测人脸
2. 两张图片进行人脸比对
3. 视频模式检测人脸
4. 视频模式人脸识别及比对
5. 视频模式注册人脸

##### 虹软官方demo
从官网直接下载下来的demo运行报错，需要在Targets->Build Phases->Link Binary With Libraries里面添加对应的Framework。

[虹软官网链接](http://www.arcsoft.com.cn?_blank)

