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
            sharedPlugin = [self new];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidFinishLaunching:)
                                                 name:NSApplicationDidFinishLaunchingNotification
                                               object:nil];

    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSMenuItem *windowMenuItem = [[NSApp mainMenu] itemWithTitle:@"Window"];

    if (windowMenuItem) {
        NSMenu *pluginMenu = [[NSMenu alloc] initWithTitle:@"Sidebar Flex"];
        [[windowMenuItem submenu] addItem:[NSMenuItem separatorItem]];

        NSMenuItem *flexMenuItem;
        flexMenuItem = [[NSMenuItem alloc] initWithTitle:@"Foldbar Color"
                                                  action:@selector(showColorPanel)
                                           keyEquivalent:@""];
        flexMenuItem.target = self;
        [pluginMenu addItem:flexMenuItem];
        NSString *versionString = [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSString *title = [NSString stringWithFormat:@"Sidebar Flex (%@)", versionString];
        NSMenuItem *pluginMenuItem = [[NSMenuItem alloc] initWithTitle:title
                                                                action:nil
                                                         keyEquivalent:@""];
        pluginMenuItem.submenu = pluginMenu;

        [[windowMenuItem submenu] addItem:pluginMenuItem];
    }
}

- (void)adjustColor:(id)sender {
    NSColorPanel *panel = (NSColorPanel *)sender;

    if (panel.color) {
        //        NSData *colorData = [NSArchiver archivedDataWithRootObject:panel.color];
        //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //        [userDefaults setObject:colorData forKey:kChangeMarksColor];
        //        [userDefaults synchronize];
    }
}

- (void)showColorPanel {
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
    //    panel.color = self.changeMarkColor;
    panel.target = self;
    panel.action = @selector(adjustColor:);
    [panel orderFront:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(colorPanelWillClose:)
                                                 name:NSWindowWillCloseNotification object:nil];
}

- (void)colorPanelWillClose:(NSNotification *)notification {
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
    if (panel == notification.object) {
        panel.target = nil;
        panel.action = nil;

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NSWindowWillCloseNotification
                                                      object:nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
