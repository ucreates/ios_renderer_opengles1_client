// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "BackgroundBehaviour1.h"
@interface BackgroundBehaviour1 ()
@end
@implementation BackgroundBehaviour1
@synthesize asset;
- (id)init {
    self = [super init];
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"texture01" ofType:@"jpg"];
    self->asset = [[RectangleAsset1 alloc] init:1.0f height:1.0f color:GLESColor.white];
    [self->asset create:path textureUnit:GL_TEXTURE10];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    [self->asset.transform setPosition:0.0f y:0.0f z:0.0f];
    [self->asset.transform setScale:2.0f y:2.0f z:2.0f];
    [self->asset.transform setRotation:0.0f y:0.0f z:0.0f];
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
