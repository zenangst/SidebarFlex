//
//  SidebarFlex.h
//  SidebarFlex
//
//  Created by Christoffer Winterkvist on 4/16/15.
//  Copyright (c) 2015 zenangst. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface SidebarFlex : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end