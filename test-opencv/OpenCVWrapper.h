

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+(NSString *) openCVVersionString;
+(UIImage *) subtractImages :(UIImage *) image1  :(UIImage *) image2;
+(UIImage *) clearCanvas;
+(UIImage *) processImageWithOpenCV:(UIImage*)inputImage;
@end