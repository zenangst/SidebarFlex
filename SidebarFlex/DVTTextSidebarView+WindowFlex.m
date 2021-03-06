//
//  DVTTextSidebarView+WindowFlex.m
//  WindowFlex
//
//  Created by Christoffer Winterkvist on 4/15/15.
//  Copyright (c) 2015 zenangst. All rights reserved.
//

#import "DVTTextSidebarView+WindowFlex.h"
#import <objc/runtime.h>

@implementation DVTTextSidebarView (WindowFlex)

- (id)zen_foldbarBackgroundColor
{
    return [NSColor colorWithSRGBRed:0.980 green:0.980 blue:0.980 alpha:1];
}

- (id)zen_sidebarBackgroundColor
{
    return [NSColor colorWithSRGBRed:0.980 green:0.980 blue:0.980 alpha:1];
}

- (id)zen_lineNumberTextColor
{
    return [NSColor colorWithSRGBRed:0.835 green:0.835 blue:0.835 alpha:1];
}

- (id)zen_sidebarEdgeColor
{
    return [NSColor colorWithSRGBRed:0.980 green:0.980 blue:0.980 alpha:1];
}

- (id)zen_lineNumberFont
{
    return [NSFont fontWithName:@"Menlo" size:9.f];
}

- (double)zen_sidebarWidth
{
    double sidebarWidth = [self zen_sidebarWidth] - 1;

    return sidebarWidth;
}

+ (void)load
{
    Method original, swizzle;

    original = class_getInstanceMethod(self, NSSelectorFromString(@"sidebarBackgroundColor"));
    swizzle = class_getInstanceMethod(self, NSSelectorFromString(@"zen_sidebarBackgroundColor"));

    method_exchangeImplementations(original, swizzle);

    original = class_getInstanceMethod(self, NSSelectorFromString(@"foldbarBackgroundColor"));
    swizzle = class_getInstanceMethod(self, NSSelectorFromString(@"zen_foldbarBackgroundColor"));

    method_exchangeImplementations(original, swizzle);

    original = class_getInstanceMethod(self, NSSelectorFromString(@"lineNumberTextColor"));
    swizzle = class_getInstanceMethod(self, NSSelectorFromString(@"zen_lineNumberTextColor"));

    method_exchangeImplementations(original, swizzle);

    original = class_getInstanceMethod(self, NSSelectorFromString(@"sidebarEdgeColor"));
    swizzle = class_getInstanceMethod(self, NSSelectorFromString(@"zen_sidebarEdgeColor"));

    method_exchangeImplementations(original, swizzle);

    original = class_getInstanceMethod(self, NSSelectorFromString(@"lineNumberFont"));
    swizzle = class_getInstanceMethod(self, NSSelectorFromString(@"zen_lineNumberFont"));

    method_exchangeImplementations(original, swizzle);

    original = class_getInstanceMethod(self, NSSelectorFromString(@"sidebarWidth"));
    swizzle = class_getInstanceMethod(self, NSSelectorFromString(@"zen_sidebarWidth"));

    method_exchangeImplementations(original, swizzle);
}

@end
