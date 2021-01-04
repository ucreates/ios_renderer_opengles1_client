// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "UIBehaviour1.h"
@interface UIBehaviour1 ()
@end
@implementation UIBehaviour1
@synthesize asset;
- (id)init {
    self = [super init];
    NSBundle* bundle = [NSBundle mainBundle];
    GLESBlend* blend = [[GLESBlend alloc] init];
    [blend normal];
    TextureAnimatorAsset* animatorAsset = [[TextureAnimatorAsset alloc] init];
    for (int i = 0; i < 10; i++) {
        NSString* fileName = [NSString stringWithFormat:@"number%02d", i];
        NSString* path = [bundle pathForResource:fileName ofType:@"png"];
        BaseAsset* frame = [[RectangleAsset1 alloc] init:1.0f height:1.0f color:GLESColor.white];
        [frame create:path textureUnit:GL_TEXTURE10];
        [frame setBlend:blend];
        [animatorAsset add:frame];
    }
    [animatorAsset setFrameSpan:30];
    self->asset = animatorAsset;
    self.timeLine.rate = 0.01f;
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    [self->asset.transform setPosition:0.0f y:0.1f z:0.0f];
    [self->asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self->asset.transform setRotation:0.0f y:0.0f z:0.0f];
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
