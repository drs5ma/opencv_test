#import "OpenCVWrapper.h"
#import "UIImage+OpenCV.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>


@implementation OpenCVWrapper


+(NSString *) openCVVersionString{
    return [NSString stringWithFormat: @"OpenCV Version %s", CV_VERSION];
    
}

+(UIImage *) subtractImages :(UIImage *) image1  :(UIImage *) image2{

    cv::Mat imageMat1= [image1 toCVImage];
    cv::Mat imageMat2 = [image2 toCVImage];

// <Error>: CGBitmapContextCreate: unsupported parameter combination: set
//  <Error>: CGContextDrawImage: invalid context 0x0.

    cv::Mat imageMat3;
    cv::bitwise_not(imageMat1, imageMat1);
    cv::bitwise_or(imageMat1, imageMat2, imageMat3);
    UIImage* image = [UIImage createFrom:imageMat3];
    return image;
}

+(UIImage *) clearCanvas {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(400 , 400), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return blank;
}

+ (UIImage *) processImageWithOpenCV : (UIImage *) inputImage {
    
//    cv::Mat mat = [inputImage toCVImage];
//    UIImage* image = [UIImage createFrom:mat];
//    return image;
    cv::Mat imagemat= [inputImage toCVImage];
    cv::threshold(imagemat, imagemat, 5, 255, cv::THRESH_BINARY);
    //UIImageToMat(inputImage,imagemat);
    UIImage* image = [UIImage createFrom:imagemat];
    return image;
    //return MatToUIImage(imagemat);
}
@end