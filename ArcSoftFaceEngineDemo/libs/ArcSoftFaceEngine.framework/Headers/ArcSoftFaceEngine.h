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

/*!
 @header ArcSoftFaceEngine.h
 @brief 人脸引擎
 */
#import <Foundation/Foundation.h>
#import "ArcSoftFaceEngineDefine.h"

@interface ArcSoftFaceEngine : NSObject

    /*!
     * @brief 引擎激活
     * @param appId         官网获取的APPID
     * @param sdkkey        官网获取的SDKKEY
     * @return              成功返回ASF_MOK或MERR_ASF_ALREADY_ACTIVATED，否则返回失败code
     */
    - (MRESULT)activeWithAppId:(NSString *)appId
                        SDKKey:(NSString *)sdkkey;

    /*!
     * @brief 引擎初始化
     * @param detectMode                    检测模式（ASF_DETECT_MODE_VIDEO或ASF_DETECT_MODE_IMAGE模式）
     * @param detectFaceOrientPriority      检测脸部的角度优先值，推荐仅检测单一角度，效果更优
     * @param detectFaceScaleVal            用于数值化表示的最小人脸尺寸，该尺寸代表人脸尺寸相对于图片边长的对比；
                                            video模式有效范围[2,16]，image模式有效范围[2,32]，推荐值为16
     * @param detectFaceMaxNum              最大需要检测的人脸个数[1,50]
     * @param combinedMask                  用户选择需要检测的功能组合，可单个或多个
     * @return                              成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)initFaceEngineWithDetectMode:(MLong)detectMode
                        orientPriority:(ASF_OrientPriority)detectFaceOrientPriority
                                 scale:(MInt32)detectFaceScaleVal
                            maxFaceNum:(MInt32)detectFaceMaxNum
                          combinedMask:(MInt32)combinedMask;


    /*!
     * @brief   销毁引擎
     * @return  成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)unInitFaceEngine;

    /*!
     * @brief                   人脸检测
     * @param width             图像数据宽度，为4的倍数且大于0
     * @param height            图像数据高度，NV12格式的图片高度为2的倍数，BGR24格式的图片高度不限制
     * @param data              图像数据
     * @param format            颜色空间格式
     * @param detectedFaces     检测到的人脸信息
     * @return                  成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)detectFacesWithWidth:(MInt32)width
                             height:(MInt32)height
                               data:(MUInt8*)data
                             format:(MInt32)format
                            faceRes:(LPASF_MultiFaceInfo)detectedFaces;

    /*!
     * @brief                   人脸信息检测（年龄/性别/人脸3D角度），最多支持4张人脸信息检测，超过部分返回未知
     * @param width             图像数据宽度，为4的倍数且大于0
     * @param height            图像数据高度，NV12格式的图片高度为2的倍数，BGR24格式的图片高度不限制
     * @param data              图像数据
     * @param format            颜色空间格式
     * @param detectedFaces     检测到的人脸信息
     * @param combinedMask      初始化中参数combinedMask与ASF_AGE|ASF_GENDER|ASF_FACE3DANGLE的交集的子集
     * @return                  成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)processWithWidth:(MInt32)width
                         height:(MInt32)height
                           data:(MUInt8*)data
                         format:(MInt32)format
                        faceRes:(LPASF_MultiFaceInfo)detectedFaces
                           mask:(MInt32)combinedMask;

    /*!
     * @brief   获取版本信息
     * @return  成功返回版本信息，否则返回MNull
     */
    - (NSString*)getVersion;

@end

@interface ArcSoftFaceEngine(FaceRecoginition)

    /*!
     * @brief           单人脸特征提取
     * @param width     图像数据宽度，为4的倍数且大于0
     * @param height    图像数据高度，NV12格式的图片高度为2的倍数，BGR24格式的图片高度不限制
     * @param data      图像数据
     * @param format    颜色空间格式
     * @param faceInfo  单张人脸位置和角度信息
     * @param feature   人脸特征
     * @return          成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)extractFaceFeatureWithWidth:(MInt32)width
                                    height:(MInt32)height
                                      data:(MUInt8*)data
                                    format:(MInt32)format
                                  faceInfo:(LPASF_SingleFaceInfo)faceInfo
                                   feature:(LPASF_FaceFeature)feature;

    /*!
     * @brief 人脸特征比对
     * @param feature1          待比对的人脸特征
     * @param feature2          待比对的人脸特征
     * @param confidenceLevel   比较结果，置信度数值
     * @return                  成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)compareFaceWithFeature:(LPASF_FaceFeature)feature1
                             feature2:(LPASF_FaceFeature)feature2
                               confidenceLevel:(MFloat*)confidenceLevel;

@end

@interface ArcSoftFaceEngine(Face3DAngle)

    /*!
     * @brief               获取3D角度信息
     * @param face3DAngle   检测到的脸部3D角度信息
     * @return              成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)getFace3DAngle:(LPASF_Face3DAngle)face3DAngle;
@end

@interface ArcSoftFaceEngine(AgeEstimation)

    /*!
     * @brief           获取年龄信息
     * @param ageInfo   检测到的年龄信息
     * @return          成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)getAge:(LPASF_AgeInfo)ageInfo;
@end

@interface ArcSoftFaceEngine(GenderEstimation)

    /*!
     * @brief               获取性别信息
     * @param genderInfo    检测到的性别信息
     * @return              成功返回ASF_MOK，否则返回失败code
     */
    - (MRESULT)getGender:(LPASF_GenderInfo)genderInfo;
@end
