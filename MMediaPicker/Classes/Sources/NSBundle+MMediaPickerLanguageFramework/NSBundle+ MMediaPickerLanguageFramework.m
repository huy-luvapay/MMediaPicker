//
//  NSBundle+LanguageFramework.m
//



#import "NSBundle+ MMediaPickerLanguageFramework.h"
#import <objc/runtime.h>

static const char associatedLanguageBundle = 1;

NSString * const bundleIdentifier = @"org.cocoapods.MMediaPicker";

@interface PrivateBundleMMediaPicker : NSBundle
@end

@implementation PrivateBundleMMediaPicker
- (NSString*)localizedStringForKey:(NSString *)key
                            value:(NSString *)value
                            table:(NSString *)tableName
{
    NSBundle* bundle=objc_getAssociatedObject(self, &associatedLanguageBundle);
    return bundle ? [bundle localizedStringForKey:key
                                            value:value
                                            table:tableName] : [super localizedStringForKey:key
                                                                                      value:value
                                                                                      table:tableName];
}
@end

@implementation NSBundle (MMediaPickerLanguageFramework)
+(void)setLanguageFrameworkMMediaPicker:(NSString*)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle bundleWithIdentifier:bundleIdentifier],[PrivateBundleMMediaPicker class]);
    });
    objc_setAssociatedObject([NSBundle bundleWithIdentifier:bundleIdentifier], &associatedLanguageBundle, language ?
                             [NSBundle bundleWithPath:[[NSBundle bundleWithIdentifier:bundleIdentifier] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
