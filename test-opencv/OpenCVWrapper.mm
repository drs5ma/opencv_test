using namespace std;
#import "OpenCVWrapper.h"
#import "UIImage+OpenCV.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>


@implementation OpenCVWrapper


+(NSString *) openCVVersionString{
    return [NSString stringWithFormat: @"OpenCV Version %s", CV_VERSION];
    
}

+(UIImage *) subtractImages :(UIImage *) image1  :(UIImage *) image2{
    printf("here1");

//    cv::Mat imageMat1;
//    UIImageToMat(image1, imageMat1);
//    
    
cv::Mat imageMat1= [image1 toCVImage];

    
    
    printf("here in between");
    cv::Mat imageMat2 = [image2 toCVImage];
//    cv::Mat imageMat2;
//    UIImageToMat(image2, imageMat2);
//    
//    
    
    
    printf("here1");
    //cout << "imageMat1 " << imageMat1.rows  << imageMat1.cols <<endl;
    //cout << "imageMat2 " << imageMat2.rows  << imageMat2.cols <<endl;
    //    cout << "imageMat1 " << imageMat1.type() <<endl;
    //    cout << "imageMat2 " << imageMat2.type() <<endl;
    
    cv::Mat imageMat3;
    printf("here2");

    
    cv::bitwise_not(imageMat1, imageMat1);
    cv::bitwise_or(imageMat1, imageMat2, imageMat3);
    //cv::bitwise_xor(imageMat1, imageMat2, imageMat3);
    
    UIImage* image = [UIImage createFrom:imageMat3];
    printf("here3");

    return image;
    
    
}

+(UIImage *) cleanse:(UIImage *)image {
//    cv::Mat imageMat1;
//    UIImageToMat(image, imageMat1);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(400 , 400), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return blank;
}

+ (UIImage *) processImageWithOpenCV : (UIImage *) inputImage {
    
//    cv::Mat mat = [inputImage toCVImage];
//    UIImage* image = [UIImage createFrom:mat];
//    return image;
    printf("here4");

    cv::Mat imagemat= [inputImage toCVImage];
    printf("here5");

    
    cv::threshold(imagemat, imagemat, 5, 255, cv::THRESH_BINARY);

    
    //UIImageToMat(inputImage,imagemat);
    UIImage* image = [UIImage createFrom:imagemat];
    printf("here6");

    return image;
    //return MatToUIImage(imagemat);
}
@end