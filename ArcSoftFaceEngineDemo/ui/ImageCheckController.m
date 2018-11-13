//
//  ImageCheckController.m
//  ArcSoftFaceEngineDemo
//
//  Created by noit on 2018/9/5.
//  Copyright © 2018年 ArcSoft. All rights reserved.
//

#import "ImageCheckController.h"
#import <ArcSoftFaceEngine/ArcSoftFaceEngine.h>
#import "ColorFormatUtil.h"
#import "Utility.h"
#import "ImageChooseControl.h"
#import "ASFRManager.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ImageCheckController () <ImageChooseControlDelegate> {
    ArcSoftFaceEngine *_engine;
    UIImageView *_resualtImgView;
    UIImage *_selectImage;
    UIButton *_btStartCheck;
    UILabel *_tvCheckTip;
    UIScrollView *_scrollView;
    UILabel *_labelFD;
    UILabel *_labelAge;
    UILabel *_labelGender;
    UILabel *_labelAngle;
    UILabel *_labelFR1;
    UILabel *_labelFM;
    UIButton *_registButton;
    LPASF_FaceFeature _faceFacture;
}
@property (nonatomic, strong) ASFRManager*       frManager;
@end

@implementation ImageCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *appid = @"";
    NSString *sdkkey = @"";
    _engine = [[ArcSoftFaceEngine alloc] init];
    MRESULT mr = [_engine initFaceEngineWithDetectMode:ASF_DETECT_MODE_IMAGE
                                  orientPriority:ASF_OP_0_HIGHER_EXT
                                           scale:16
                                      maxFaceNum:10
                                    combinedMask:ASF_FACE_DETECT | ASF_FACERECOGNITION | ASF_AGE | ASF_GENDER | ASF_FACE3DANGLE];
    
    NSLog(@"初始化结果为：%ld", mr);
    self.frManager = [[ASFRManager alloc] init];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2)];
    _scrollView.scrollEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
    UIButton* btCancel = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 45, 20)];
    [btCancel setTitle:@"返回" forState:UIControlStateNormal];
    [btCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btCancel addTarget:self action:@selector(cancel:)
       forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btCancel];
    
    UILabel* tvImage1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 20)];
    tvImage1.text = @"图1：";
    tvImage1.textColor = [UIColor blackColor];
    [_scrollView addSubview:tvImage1];
    
    UIImageView* imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 80, 160, 160)];
    UIImage* imgSrc1 = [UIImage imageNamed:@"1"];
    [imageView1 setImage:imgSrc1];
    [_scrollView addSubview:imageView1];
    
    _resualtImgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 260, 160, 160)];
    _resualtImgView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:_resualtImgView];
    
    ImageChooseControl * imgChooseControl = [[ImageChooseControl alloc]
                                             initWithFrame:CGRectMake(20, 450, 100, 40)];
    imgChooseControl.pickerTitle         = @"选择图片2";
    imgChooseControl.superViewController = self;
    imgChooseControl.delegate            = self;
    [_scrollView addSubview:imgChooseControl];
    
    _btStartCheck = [[UIButton alloc] initWithFrame:CGRectMake(140, 450, 100, 40)];
    [_btStartCheck setTitle:@"开始检测" forState:UIControlStateNormal];
    [_btStartCheck setBackgroundColor:[UIColor grayColor]];
    [_btStartCheck addTarget:self action:@selector(startCheck:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_btStartCheck];
    
    _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registButton.frame = CGRectMake(260, 450, 100, 40);
    [_registButton setTitle:@"注册人脸" forState:UIControlStateNormal];
    _registButton.backgroundColor = [UIColor grayColor];
    [_registButton addTarget:self action:@selector(registerFace:) forControlEvents:UIControlEventTouchUpInside];
    _registButton.enabled = NO;
    [_scrollView addSubview:_registButton];
    
    _tvCheckTip = [[UILabel alloc] initWithFrame:CGRectMake(5, 520, 300, 50)];
    _tvCheckTip.numberOfLines = 2;
    _tvCheckTip.text = @"检测结果(以图2为准，若检测到多人脸，下面只输出第一个人脸的数据):";
    [_scrollView addSubview:_tvCheckTip];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageChooseControl:(ImageChooseControl *)control didChooseFinished:(UIImage *)image {
    [_resualtImgView setImage:image];
    _selectImage = image;
    [self clearChildView];
}

- (void)imageChooseControl:(ImageChooseControl *)control didClearImage:(UIImage *)image {
    [self clearChildView];
    [_resualtImgView setImage:image];
    _selectImage = nil;
}

- (void)clearChildView {
    [_labelFD removeFromSuperview];
    [_labelAge removeFromSuperview];
    [_labelGender removeFromSuperview];
    [_labelAngle removeFromSuperview];
    [_labelFR1 removeFromSuperview];
    [_labelFM removeFromSuperview];
}

- (IBAction)startCheck:(UIButton *)sender {
    [self clearChildView];
    //对图片宽高进行对齐处理
    int imageWidth = _selectImage.size.width;
    int imageHeight = _selectImage.size.width;
    if (imageWidth % 4 != 0) {
        imageWidth = imageWidth - (imageWidth % 4);
    }
    if (imageHeight % 2 != 0) {
        imageHeight = imageHeight - (imageHeight % 2);
    }
    CGRect rect = CGRectMake(0, 0, imageWidth, imageHeight);
    _selectImage = [Utility clipWithImageRect:rect clipImage:_selectImage];
    
    unsigned char* pRGBA = [ColorFormatUtil bitmapFromImage:_selectImage];
    MInt32 dataWidth = _selectImage.size.width;
    MInt32 dataHeight = _selectImage.size.height;
    MUInt32 format = ASVL_PAF_NV12;
    MInt32 pitch0 = dataWidth;
    MInt32 pitch1 = dataWidth;
    MUInt8* plane0 = (MUInt8*)malloc(dataHeight * dataWidth * 3/2);
    MUInt8* plane1 = plane0 + dataWidth * dataHeight;
    unsigned char* pBGR = (unsigned char*)malloc(dataHeight * LINE_BYTES(dataWidth, 24));
    RGBA8888ToBGR(pRGBA, dataWidth, dataHeight, dataWidth * 4, pBGR);
    BGRToNV12(pBGR, dataWidth, dataHeight, plane0, pitch0, plane1, pitch1);
    
    ASF_MultiFaceInfo* fdResult = (ASF_MultiFaceInfo*)malloc(sizeof(ASF_MultiFaceInfo));
    fdResult->faceRect = (MRECT*)malloc(sizeof(fdResult->faceRect));
    fdResult->faceOrient = (MInt32*)malloc(sizeof(fdResult->faceOrient));
    
    //FD
    MRESULT mr = [_engine detectFacesWithWidth:dataWidth
                                       height:dataHeight
                                         data:plane0
                                       format:format
                                      faceRes:fdResult];
    
    CGRect tvCheckTipFrame = _tvCheckTip.frame;
    CGFloat checkTipY = (int)tvCheckTipFrame.origin.y;
    _labelFD = [[UILabel alloc] init];
    [_labelFD setFrame:CGRectMake(5, checkTipY + 40, 300, 55)];
    [_labelFD setNumberOfLines:2];
    NSString* fdResultStr = @"";
    if (mr == ASF_MOK) {
        if (fdResult->faceNum == 0) {
            fdResultStr = @"未检测到人脸";
        } else {
            fdResultStr = [NSString stringWithFormat:@"detectFaces检测成功,人脸框：rect[%d,%d,%d,%d]",
                           fdResult->faceRect->left, fdResult->faceRect->top,
                           fdResult->faceRect->right, fdResult->faceRect->bottom];
            _registButton.enabled = YES;
        }
    } else {
        fdResultStr = [NSString stringWithFormat:@"detectFaces检测失败：%ld，请重新选择", mr];
    }
    [_labelFD setText:fdResultStr];
    [_labelFD setTextColor:[UIColor redColor]];
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGSize targetSize = CGSizeMake(_selectImage.size.width, _selectImage.size.height);
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, targetSize.width, targetSize.height,
                                                       8, targetSize.width * 4, rgb,
                                                       kCGImageAlphaPremultipliedFirst);
    CGRect imageRect;
    imageRect.origin = CGPointMake(0, 0);
    imageRect.size = targetSize;
    CGContextDrawImage(bitmapContext, imageRect, _selectImage.CGImage);
    for (int i = 0; i < fdResult->faceNum; i ++) {
        MRECT rect = fdResult->faceRect[i];
        CGRect cgRect = CGRectMake(rect.left, targetSize.height - rect.bottom, rect.right - rect.left, rect.bottom - rect.top);
        CGContextAddRect(bitmapContext, cgRect);
    }
    CGContextSetRGBStrokeColor(bitmapContext, 255, 0, 0, 1);
    CGContextSetLineWidth(bitmapContext, 4.0);
    CGContextStrokePath(bitmapContext);
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage * image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(rgb);
    [_resualtImgView setImage:image];
    
    [_scrollView addSubview:_labelFD];
    
    if (mr == ASF_MOK) {
        NSTimeInterval begin = [[NSDate date] timeIntervalSince1970];
        mr = [_engine processWithWidth:dataWidth
                               height:dataHeight
                                 data:plane0
                               format:format
                              faceRes:fdResult
                                 mask:ASF_AGE | ASF_GENDER | ASF_FACE3DANGLE];
        NSTimeInterval cost = [[NSDate date] timeIntervalSince1970] - begin;
        NSLog(@"processTime=%d", (int)(cost * 1000));
        NSLog(@"process:%ld", mr);
        if (mr == ASF_MOK) {
            //age
            ASF_AgeInfo ageInfo = {0};
            mr = [_engine getAge:&ageInfo];
            if (mr == ASF_MOK) {
                NSLog(@"age:%d", (int)ageInfo.ageArray[0]);
                _labelAge = [[UILabel alloc] init];
                [_labelAge setFrame:CGRectMake(5, checkTipY + 80, 200, 45)];
                NSString *strFD = [NSString stringWithFormat:@"年龄为：%d", (int)ageInfo.ageArray[0]];
                [_labelAge setText:strFD];
                [_labelAge setTextColor:[UIColor redColor]];
                [_scrollView addSubview:_labelAge];
            }
            
            //gender
            ASF_GenderInfo genderInfo = {0};
            mr = [_engine getGender:&genderInfo];
            if (mr == ASF_MOK) {
                _labelGender = [[UILabel alloc] init];
                [_labelGender setFrame:CGRectMake(5, checkTipY + 105, 200, 45)];
                NSString *strGender = [NSString stringWithFormat:@"性别为：%@", genderInfo.genderArray[0] == 1 ? @"女" : @"男"];
                [_labelGender setText:strGender];
                [_labelGender setTextColor:[UIColor redColor]];
                [_scrollView addSubview:_labelGender];
            }
            
            //3DAngle
            ASF_Face3DAngle angleInfo = {0};
            mr = [_engine getFace3DAngle:&angleInfo];
            if (mr == ASF_MOK) {
                _labelAngle = [[UILabel alloc] init];
                [_labelAngle setNumberOfLines:3];
                [_labelAngle setFrame:CGRectMake(5, checkTipY + 130, 300, 95)];
                NSString *strAngle = [NSString stringWithFormat:@"3DAngle:[yaw:%f,roll:%f,pitch:%f]", angleInfo.yaw[0], angleInfo.roll[0], angleInfo.pitch[0]];
                [_labelAngle setText:strAngle];
                [_labelAngle setTextColor:[UIColor redColor]];
                [_scrollView addSubview:_labelAngle];
            }
            
            //FR
            ASF_SingleFaceInfo frInputFace = {0};
            frInputFace.rcFace.left = fdResult->faceRect[0].left;
            frInputFace.rcFace.top = fdResult->faceRect[0].top;
            frInputFace.rcFace.right = fdResult->faceRect[0].right;
            frInputFace.rcFace.bottom = fdResult->faceRect[0].bottom;
            frInputFace.orient = fdResult->faceOrient[0];
            ASF_FaceFeature feature1 = {0};
            NSTimeInterval begin = [[NSDate date] timeIntervalSince1970];
            mr = [_engine extractFaceFeatureWithWidth:dataWidth
                                              height:dataHeight
                                                data:plane0
                                              format:format
                                            faceInfo:&frInputFace
                                             feature:&feature1];
            NSTimeInterval cost = [[NSDate date] timeIntervalSince1970] - begin;
            if (mr == ASF_MOK) {
                NSLog(@"FRTime:%dms, feature1:%d", (int)(cost * 1000), feature1.featureSize);
                _labelFR1 = [[UILabel alloc] init];
                [_labelFR1 setNumberOfLines:1];
                [_labelFR1 setFrame:CGRectMake(5, checkTipY + 205, 320, 45)];
                NSString *strFR1 = [NSString stringWithFormat:@"人脸特征长度为:%d", feature1.featureSize];
                [_labelFR1 setText:strFR1];
                [_labelFR1 setTextColor:[UIColor redColor]];
                [_scrollView addSubview:_labelFR1];
            }
            
            LPASF_FaceFeature copyFeature1 = (LPASF_FaceFeature)malloc(sizeof(ASF_FaceFeature));
            copyFeature1->featureSize = feature1.featureSize;
            copyFeature1->feature = (MByte*)malloc(feature1.featureSize);
            memcpy(copyFeature1->feature, feature1.feature, copyFeature1->featureSize);
            _faceFacture = copyFeature1;
            
            UIImage* imgSrc2 = [UIImage imageNamed:@"1"];
            unsigned char* pRGBA2 = [ColorFormatUtil bitmapFromImage:imgSrc2];
            MInt32 picWidth2 = imgSrc2.size.width;
            MInt32 picHeight2 = imgSrc2.size.height;
            NSLog(@"width2:%d height2:%d", picWidth2, picHeight2);
            MInt32 format2 = ASVL_PAF_NV12;
            MInt32 pi32Pitch20 = picWidth2;
            MInt32 pi32Pitch21 = picWidth2;
            MUInt8* ppu8Plane20 = (MUInt8*)malloc(picHeight2 * picWidth2 * 3/2);
            MUInt8* ppu8Plane21 = ppu8Plane20 + pi32Pitch20 * picHeight2;
            unsigned char* pBGR2 = (unsigned char*)malloc(picHeight2 * LINE_BYTES(picWidth2, 24));
            RGBA8888ToBGR(pRGBA2, picWidth2, picHeight2, picWidth2 * 4, pBGR2);
            BGRToNV12(pBGR2, picWidth2, picHeight2, ppu8Plane20, pi32Pitch20, ppu8Plane21, pi32Pitch21);
            
            ASF_MultiFaceInfo fdResult2 = {0};
            
            mr = [_engine detectFacesWithWidth:picWidth2
                                       height:picHeight2
                                         data:ppu8Plane20
                                       format:format2
                                      faceRes:&fdResult2];
            ASF_SingleFaceInfo frInputFace2 = {0};
            frInputFace2.rcFace.left = fdResult2.faceRect[0].left;
            frInputFace2.rcFace.top = fdResult2.faceRect[0].top;
            frInputFace2.rcFace.right = fdResult2.faceRect[0].right;
            frInputFace2.rcFace.bottom = fdResult2.faceRect[0].bottom;
            frInputFace2.orient = fdResult2.faceOrient[0];
            ASF_FaceFeature feature2 = {0};
            mr = [_engine extractFaceFeatureWithWidth:picWidth2
                                              height:picHeight2
                                                data:ppu8Plane20
                                              format:format2
                                            faceInfo:&frInputFace2
                                             feature:&feature2];
            
            
            
            //FM
            MFloat confidence = 0.0;
            mr = [_engine compareFaceWithFeature:copyFeature1
                                       feature2:&feature2
                                         confidenceLevel:&confidence];
            if (mr == ASF_MOK) {
                NSLog(@"FM比对结果为：%f", confidence);
                _labelFM = [[UILabel alloc] init];
                [_labelFM setNumberOfLines:1];
                [_labelFM setFrame:CGRectMake(5, checkTipY + 255, 320, 45)];
                NSString *strFM = [NSString stringWithFormat:@"图1和图2比对结果：%f", confidence];
                [_labelFM setText:strFM];
                [_labelFM setTextColor:[UIColor redColor]];
                [_scrollView addSubview:_labelFM];
                
                _scrollView.contentSize = CGSizeMake(kScreenWidth + 50, kScreenHeight * 2.5);
            } else {
                NSLog(@"FM失败为：%ld", mr);
            }
        }
    }
    SafeArrayFree(pBGR);
    SafeArrayFree(pRGBA);
}

- (void)registerFace:(UIButton *)button {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"注册人脸" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField* nameText = alertController.textFields.firstObject;
        NSString* name = nameText.text;
        if (name != NULL && name.length > 0) {
            if([self registerPerson:name])
            {
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertController animated:YES completion:nil];
                NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerHideAlertViewController:) userInfo:alertController repeats:NO];
                [timer fire];
            }
        }
    }];
    [alertController addAction:okAction];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入名称";
    }];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)timerHideAlertViewController:(id)sender {
    NSTimer *timer = (NSTimer*)sender;
    UIAlertController *alertViewController = (UIAlertController*)timer.userInfo;
    [alertViewController dismissViewControllerAnimated:YES completion:nil];
    alertViewController = nil;
}

- (BOOL)registerPerson:(NSString *)personName
{
    ASFRPerson *registerPerson = [[ASFRPerson alloc] init];
    registerPerson.faceFeatureData = [NSData dataWithBytes:_faceFacture->feature length:_faceFacture->featureSize];
    if(registerPerson == nil || registerPerson.registered)
        return NO;
    
    registerPerson.name = personName;
    registerPerson.Id = [self.frManager getNewPersonID];
    registerPerson.registered = [self.frManager addPerson:registerPerson];
    
    return registerPerson.registered;
}

@end
