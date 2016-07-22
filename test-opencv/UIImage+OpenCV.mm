#import "UIImage+OpenCV.h"

@implementation UIImage (OpenCV)
- (cv::Mat) toCVImage
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(self.CGImage);

    CGFloat cols = self.size.width;
    CGFloat rows = self.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    //<Error>: CGBitmapContextCreate: unsupported parameter combination:
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast); // Bitmap info flags  |kCGBitmapByteOrderDefault

    // <Error>: CGContextDrawImage: invalid context 0x0.
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), self.CGImage);
    CGContextRelease(contextRef);
    cv::cvtColor(cvMat, cvMat, CV_RGBA2GRAY);
    
    //cv::threshold(cvMat, cvMat, 100, 255, cv::THRESH_BINARY);

    return cvMat;
}


+ (UIImage *)createFrom:(const cv::Mat&) cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length: cvMat.elemSize() * cvMat.total()];
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    //CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                        cvMat.rows,                                     // Height
                                        8,                                              // Bits per component
                                        8 * cvMat.elemSize(),                           // Bits per pixel
                                        cvMat.step[0],                                  // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent
    
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return image;
}

@end