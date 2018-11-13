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
 @header ArcSoftFaceEngineDefine.h
 @brief 结构体头文件
 */
#import "amcomdef.h"
#import "merror.h"

#ifndef ArcSoftFaceEngineDefine_h
#define ArcSoftFaceEngineDefine_h

#define ASF_NONE                    0x00000000
#define ASF_FACE_DETECT             0x00000001
#define ASF_FACERECOGNITION         0x00000004
#define ASF_AGE                     0x00000008
#define ASF_GENDER                  0x00000010
#define ASF_FACE3DANGLE             0x00000020

#define ASF_DETECT_MODE_VIDEO    0x00000000
#define ASF_DETECT_MODE_IMAGE    0xFFFFFFFF

#define ASVL_PAF_RGB24_B8G8R8        0x201
#define ASVL_PAF_NV12                0x801

typedef MInt32 ASF_OrientPriority;
/*!
 * @enum ArcSoftFace_OrientPriority
 * @brief 检测方向的优先级
 */
enum ArcSoftFace_OrientPriority {
    ASF_OP_0_ONLY            = 0x1,     // 仅检测0度
    ASF_OP_90_ONLY           = 0x2,     // 仅检测90度
    ASF_OP_270_ONLY          = 0x3,     // 仅检测270度
    ASF_OP_180_ONLY          = 0x4,     // 仅检测180度
    ASF_OP_0_HIGHER_EXT      = 0x5,     // 检测0、90、270、180全角度
};

typedef MInt32 ASF_OrientCode;
/*!
 @enum ArcSoftFace_OrientCode
 @brief 检测到的人脸角度（按逆时针方向）
 */
enum ArcSoftFace_OrientCode{
    ASF_OC_0         = 0x1,        // 0 degree
    ASF_OC_90        = 0x2,        // 90 degree
    ASF_OC_270       = 0x3,        // 270 degree
    ASF_OC_180       = 0x4,        // 180 degree
    ASF_OC_30        = 0x5,        // 30 degree
    ASF_OC_60        = 0x6,        // 60 degree
    ASF_OC_120       = 0x7,        // 120 degree
    ASF_OC_150       = 0x8,        // 150 degree
    ASF_OC_210       = 0x9,        // 210 degree
    ASF_OC_240       = 0xa,        // 240 degree
    ASF_OC_300       = 0xb,        // 300 degree
    ASF_OC_330       = 0xc         // 330 degree
};

/*!
 @typedef ASF_MultiFaceInfo
 @brief 多人脸信息
 */
typedef struct{
    MRECT*          faceRect;       // 人脸框数组
    MInt32*         faceOrient;     // 人脸角度数组
    MInt32          faceNum;        // 检测到的人脸个数
}ASF_MultiFaceInfo, *LPASF_MultiFaceInfo;

/*!
 @typedef ASF_SingleFaceInfo
 @brief 单人脸信息
 */
typedef struct{
    MRECT       rcFace;             //人脸框
    MInt32      orient;             //人脸角度
} ASF_SingleFaceInfo, *LPASF_SingleFaceInfo;

/*!
 @typedef ASF_FaceFeature
 @brief 人脸特征
 */
typedef struct {
    MByte*        feature;          // 人脸特征
    MInt32        featureSize;      // 人脸特征长度
}ASF_FaceFeature, *LPASF_FaceFeature;

/*!
 @typedef ASF_AgeInfo
 @brief 年龄信息
 */
typedef struct
{
    MInt32*    ageArray;            // 0代表未知，大于0的数值代表检测出来的年龄结果
    MInt32     num;                 // 检测的人脸个数
}ASF_AgeInfo, *LPASF_AgeInfo;

/*!
 @typedef ASF_GenderInfo
 @brief 性别信息
 */
typedef struct
{
    MInt32*    genderArray;         // 1表示女性, 0表示男性, -1表示未知
    MInt32     num;                 // 检测的人脸个数
}ASF_GenderInfo, *LPASF_GenderInfo;

/*!
 @typedef ASF_Face3DAngle
 @brief 3D角度信息
 */
typedef struct
{
    MFloat* roll;         //横滚角
    MFloat* yaw;          //偏航角
    MFloat* pitch;        //俯仰角
    MInt32* status;       //0: 正常，其他数值：出错
    MInt32 num;           //检测的人脸个数
}ASF_Face3DAngle, *LPASF_Face3DAngle;

#endif 
