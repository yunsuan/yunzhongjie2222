//
//  BaseModel.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(NSMutableDictionary *)modeltodic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars;
        ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            key = [key substringFromIndex:1];
            id value = [self valueForKey:key];
            
            if (value) {
                
                [dic setValue:value forKey:key];
            }
        }
        // 获得c的父类
        c = [c superclass];
        free(ivars);}
    return dic;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description {
    return [self modelDescription];
}

- (NSArray<NSString *> *)propertyNames {
    
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:propertyCount];
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        [results addObject:[NSString stringWithCString:cName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    return [NSArray arrayWithArray:results];
}

- (NSString *)modelDescription {
    
    NSDictionary *keyAndValues = [self dictionaryWithValuesForKeys:self.propertyNames];
    NSMutableDictionary *jsonObject = [[NSMutableDictionary alloc] initWithDictionary:keyAndValues];
    for (NSString *key in keyAndValues) {
        id value = keyAndValues[key];
        if (![value isKindOfClass:[NSString class]] &&
            ![value isKindOfClass:[NSNumber class]] &&
            ![value isKindOfClass:[NSNull class]]) {
            NSString *valueDescription = [value description];
            [jsonObject setValue:valueDescription forKey:key];
        }
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, jsonString];
}

@end
