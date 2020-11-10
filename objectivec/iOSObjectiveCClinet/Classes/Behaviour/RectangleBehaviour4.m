// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "RectangleBehaviour4.h"
@interface RectangleBehaviour4 ()
@property double rotate;
@end
@implementation RectangleBehaviour4
@synthesize asset;
- (id)init {
    self = [super init];
    self->asset = [[RectangleAsset4 alloc] init:1.0f height:1.0f color:GLESColor.white];
    [self->asset create];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    [self->asset.transform setPosition:0.0f y:0.0f z:0.0f];
    [self->asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self->asset.transform setRotation:0.0f y:0.0f z:0.0f];
    [self->asset.vertex setRandomColor];
    return;
}
@end
