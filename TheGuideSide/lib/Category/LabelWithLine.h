
//

#import <UIKit/UIKit.h>

@interface LabelWithLine : UILabel
@property(strong,nonatomic)UIBezierPath *path;
@property (nonatomic, strong) NSString *titleString;
+(LabelWithLine *)initLabelWithLineText:(NSString *)text;
@end
