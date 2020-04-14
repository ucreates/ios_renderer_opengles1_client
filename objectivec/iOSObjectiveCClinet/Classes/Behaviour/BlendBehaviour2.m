// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "BlendBehaviour2.h"
@interface BlendBehaviour2 ()
@end
@implementation BlendBehaviour2
- (id)init {
    self = [super init];
    GLESBlend* blend = [[GLESBlend alloc] init];
    [blend normal];
    self.asset = [[TriangleAsset1 alloc] init:1.0f height:1.0f color:[GLESColor green:0.5f]];
    [self.asset setBlend:blend];
    [self.asset create];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    [self.asset.transform setPosition:-0.25f y:0.0f z:-0.5f];
    [self.asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self.asset.transform setRotation:0.0f y:0.0f z:0.0f];
    return;
}
- (void)onDestroy {
    [self.asset dispose];
    return;
}
@end
