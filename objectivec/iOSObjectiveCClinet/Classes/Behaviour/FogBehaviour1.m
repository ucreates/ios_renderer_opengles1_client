// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "FogBehaviour1.h"
@interface FogBehaviour1 ()
@property double rotate;
@end
@implementation FogBehaviour1
@synthesize asset;
@synthesize rotate;
- (id)init {
    self = [super init];
    self->asset = [[GLES1CubeAsset1 alloc] init:1.0f height:1.0f depth:1.0f color:GLES1Color.white];
    [self->asset create];
    self.timeLine.rate = 0.01f;
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    GLfloat z = fabsf(sinf(self.timeLine.currentTime)) * 5.0f - 2.0f;
    [self->asset.transform setPosition:0.0f y:0.0f z:z];
    [self->asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self->asset.transform setRotation:self->rotate y:self->rotate z:self->rotate];
    [self->asset.vertex setRandomColor];
    [self.timeLine next:delta];
    self->rotate += 1.0f;
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
