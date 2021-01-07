// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "BlendBehaviour3.h"
@interface BlendBehaviour3 ()
@end
@implementation BlendBehaviour3
- (id)init {
    self = [super init];
    GLES1Blend* blend = [[GLES1Blend alloc] init];
    [blend normal];
    self.asset = [[GLES1TriangleAsset1 alloc] init:1.0f height:1.0f color:[GLES1Color blue:0.5f]];
    [self.asset setBlend:blend];
    [self.asset create];
    self.timeLine.rate = 0.01f;
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    GLfloat z = sinf(self.timeLine.currentFrame);
    [self.asset.transform setPosition:0.0f y:0.0f z:z];
    [self.asset.transform setScale:0.5f y:0.5f z:0.5f];
    [self.asset.transform setRotation:0.0f y:0.0f z:0.0f];
    [self.timeLine next:delta];
    return;
}
- (void)onDestroy {
    [self.asset dispose];
    return;
}
@end
