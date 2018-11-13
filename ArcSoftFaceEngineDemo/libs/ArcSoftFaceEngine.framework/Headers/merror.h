/*******************************************************************************
 Copyright(c) ArcSoft, All right reserved.
 
 This file is ArcSoft's property. It contains ArcSoft's trade secret, proprietary
 and confidential information.
 
 The information and code contained in this file is only for authorized ArcSoft
 employees to design, create, modify, or review.
 
 DO NOT DISTRIBUTE, DO NOT DUPLICATE OR TRANSMIT IN ANY FORM WITHOUT PROPER
 AUTHORIZATION.
 
 If you are not an intended recipient of this file, you must not copy,
 distribute, modify, or take any action in reliance on it.
 
 If you have received this file in error, please immediately notify ArcSoft and
 permanently delete the original and any copy of any file and any printout thereof.
 *******************************************************************************/

#ifndef merror_h
#define merror_h

#define ASF_MOK                          (200)

#define MERR_BASIC_BASE                 0X0001                             //通用错误类型
#define MERR_UNKNOWN                    MERR_BASIC_BASE                    //错误原因不明
#define MERR_INVALID_PARAM              (MERR_BASIC_BASE+1)                //无效的参数
#define MERR_UNSUPPORTED                (MERR_BASIC_BASE+2)                //引擎不支持
#define MERR_NO_MEMORY                  (MERR_BASIC_BASE+3)                //内存不足
#define MERR_BAD_STATE                  (MERR_BASIC_BASE+4)                //状态错误
#define MERR_USER_CANCEL                (MERR_BASIC_BASE+5)                //用户取消相关操作
#define MERR_EXPIRED                    (MERR_BASIC_BASE+6)                //操作时间过期
#define MERR_USER_PAUSE                 (MERR_BASIC_BASE+7)                //用户暂停操作
#define MERR_BUFFER_OVERFLOW            (MERR_BASIC_BASE+8)                //缓冲上溢
#define MERR_BUFFER_UNDERFLOW           (MERR_BASIC_BASE+9)                //缓冲下溢
#define MERR_NO_DISKSPACE               (MERR_BASIC_BASE+10)               //存贮空间不足
#define MERR_COMPONENT_NOT_EXIST        (MERR_BASIC_BASE+11)               //组件不存在
#define MERR_GLOBAL_DATA_NOT_EXIST      (MERR_BASIC_BASE+12)               //全局数据不存在

#define MERR_ASF_SDK_BASE                          0X7000                         //Free SDK通用错误类型
#define MERR_ASF_SDK_INVALID_APP_ID                (MERR_ASF_SDK_BASE + 1)        //无效的App Id
#define MERR_ASF_SDK_INVALID_SDK_ID                (MERR_ASF_SDK_BASE + 2)        //无效的SDK key
#define MERR_ASF_SDK_INVALID_ID_PAIR               (MERR_ASF_SDK_BASE + 3)        //AppId和SDKKey不匹配
#define MERR_ASF_SDK_MISMATCH_ID_AND_SDK           (MERR_ASF_SDK_BASE + 4)        //SDKKey和使用的SDK不匹配
#define MERR_ASF_SDK_SYSTEM_VERSION_UNSUPPORTED    (MERR_ASF_SDK_BASE + 5)        //系统版本不被当前SDK所支持
#define MERR_ASF_SDK_LICENCE_EXPIRED               (MERR_ASF_SDK_BASE + 6)        //SDK有效期过期，需要重新下载更新

#define MERR_ASF_SDK_FR_ERROR_BASE                 0x12000                               //Face Recognition错误类型
#define MERR_ASF_SDK_FR_INVALID_MEMORY_INFO        (MERR_ASF_SDK_FR_ERROR_BASE+1)        //无效的输入内存
#define MERR_ASF_SDK_FR_INVALID_IMAGE_INFO         (MERR_ASF_SDK_FR_ERROR_BASE+2)        //无效的输入图像参数
#define MERR_ASF_SDK_FR_INVALID_FACE_INFO          (MERR_ASF_SDK_FR_ERROR_BASE+3)        //无效的脸部信息
#define MERR_ASF_SDK_FR_NO_GPU_AVAILABLE           (MERR_ASF_SDK_FR_ERROR_BASE+4)        //当前设备无GPU可用
#define MERR_ASF_SDK_FR_MISMATCHED_FEATURE_LEVEL   (MERR_ASF_SDK_FR_ERROR_BASE+5)        //待比较的两个人脸特征的版本不一致

#define MERR_ASF_SDK_FACEFEATURE_ERROR_BASE            0x14000                                   //人脸特征检测错误类型
#define MERR_ASF_SDK_FACEFEATURE_UNKNOWN               (MERR_ASF_SDK_FACEFEATURE_ERROR_BASE+1)    //人脸特征检测错误未知
#define MERR_ASF_SDK_FACEFEATURE_MEMORY                (MERR_ASF_SDK_FACEFEATURE_ERROR_BASE+2)    //人脸特征检测内存错误
#define MERR_ASF_SDK_FACEFEATURE_INVALID_FORMAT        (MERR_ASF_SDK_FACEFEATURE_ERROR_BASE+3)    //人脸特征检测格式错误
#define MERR_ASF_SDK_FACEFEATURE_INVALID_PARAM         (MERR_ASF_SDK_FACEFEATURE_ERROR_BASE+4)    //人脸特征检测参数错误
#define MERR_ASF_SDK_FACEFEATURE_LOW_CONFIDENCE_LEVEL  (MERR_ASF_SDK_FACEFEATURE_ERROR_BASE+5)    //人脸特征检测结果置信度低

#define MERR_ASF_EX_BASE                                     0x15000              //ArcFace2.0 错误类型
#define MERR_ASF_EX_FEATURE_UNSUPPORTED_ON_INIT         (MERR_ASF_EX_BASE+1)      //Engine不支持的检测属性
#define MERR_ASF_EX_FEATURE_UNINITED                    (MERR_ASF_EX_BASE+2)      //需要检测的属性未初始化
#define MERR_ASF_EX_FEATURE_UNPROCESSED                 (MERR_ASF_EX_BASE+3)      //待获取的属性未在process中处理过
#define MERR_ASF_EX_FEATURE_UNSUPPORTED_ON_PROCESS      (MERR_ASF_EX_BASE+4)      //PROCESS不支持的检测属性
#define MERR_ASF_EX_INVALID_IMAGE_INFO                  (MERR_ASF_EX_BASE+5)      //无效的输入图像
#define MERR_ASF_EX_INVALID_FACE_INFO                   (MERR_ASF_EX_BASE+6)      //无效的脸部信息

#define MERR_ASF_BASE                                       0x16000                   //人脸比对基础错误类型
#define MERR_ASF_ACTIVATION_FAIL                       (MERR_ASF_BASE+1)              //人脸比对SDK激活失败,请打开读写权限
#define MERR_ASF_ALREADY_ACTIVATED                     (MERR_ASF_BASE+2)              //人脸比对SDK已激活
#define MERR_ASF_NOT_ACTIVATED                         (MERR_ASF_BASE+3)              //人脸比对SDK未激活
#define MERR_ASF_SCALE_NOT_SUPPORT                     (MERR_ASF_BASE+4)              //detectFaceScaleVal不支持
#define MERR_ASF_VERION_MISMATCH                       (MERR_ASF_BASE+5)              //SDK版本不匹配
#define MERR_ASF_DEVICE_MISMATCH                       (MERR_ASF_BASE+6)              //设备不匹配
#define MERR_ASF_UNIQUE_IDENTIFIER_MISMATCH            (MERR_ASF_BASE+7)              //唯一标识不匹配
#define MERR_ASF_PARAM_NULL                            (MERR_ASF_BASE+8)              //参数为空
#define MERR_ASF_SDK_EXPIRED                           (MERR_ASF_BASE+9)              //SDK已过期
#define MERR_ASF_VERSION_NOT_SUPPORT                   (MERR_ASF_BASE+10)             //版本不支持
#define MERR_ASF_SIGN_ERROR                            (MERR_ASF_BASE+11)             //签名错误
#define MERR_ASF_DATABASE_ERROR                        (MERR_ASF_BASE+12)             //数据库插入错误
#define MERR_ASF_UNIQUE_CHECKOUT_FAIL                  (MERR_ASF_BASE+13)             //唯一标识符校验失败
#define MERR_ASF_COLOR_SPACE_NOT_SUPPORT               (MERR_ASF_BASE+14)             //输入的颜色空间不支持
#define MERR_ASF_IMAGE_WIDTH_HEIGHT_NOT_SUPPORT        (MERR_ASF_BASE+15)             //图片宽高不支持（宽度需被4整除，宽高需大于0）

#define MERR_ASF_NETWORK_BASE                               0x17000                          //网络错误类型
#define MERR_ASF_NETWORK_SERVER_EXCEPTION              (MERR_ASF_NETWORK_BASE+1)        //服务器异常
#define MERR_ASF_NETWORK_CONNECT_TIMEOUT               (MERR_ASF_NETWORK_BASE+2)        //网络请求超时
#define MERR_ASF_NETWORK_NONSUPPORTED_URL              (MERR_ASF_NETWORK_BASE+3)        //不支持的URL
#define MERR_ASF_NETWORK_COULDNT_RESOLVE_HOST          (MERR_ASF_NETWORK_BASE+4)        //未能找到指定的服务器
#define MERR_ASF_NETWORK_CONNECT_FAILURE               (MERR_ASF_NETWORK_BASE+5)        //服务器连接失败
#define MERR_ASF_NETWORK_CONNECT_LOSS                  (MERR_ASF_NETWORK_BASE+6)        //连接丢失
#define MERR_ASF_NETWORK_NOT_CONNECTED                 (MERR_ASF_NETWORK_BASE+7)        //连接中断
#define MERR_ASF_NETWORK_OPERATION_NOT_COMPLETED       (MERR_ASF_NETWORK_BASE+8)        //操作无法完成
#define MERR_ASF_NETWORK_UNKNOWN_ERROR                 (MERR_ASF_NETWORK_BASE+9)        //未知错误

#endif /* merror_h */
