//
//  SidebarFlex.m
//  SidebarFlex
//
//  Created by Christoffer Winterkvist on 4/16/15.
//    Copyright (c) 2015 zenangst. All rights reserved.
//

#import "SidebarFlex.h"
#import "DVTTextSidebarView+WindowFlex.h"

static SidebarFlex *sharedPlugin;

@interface SidebarFlex()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation SidebarFlex

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
