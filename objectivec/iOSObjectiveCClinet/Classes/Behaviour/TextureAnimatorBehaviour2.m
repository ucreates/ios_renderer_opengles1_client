// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "TextureAnimatorBehaviour2.h"
@interface TextureAnimatorBehaviour2 ()
@end
@implementation TextureAnimatorBehaviour2
@synthesize asset;
- (id)init {
    self = [super init];
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"animation" ofType:@"png"];
    GLES1Blend* blend = [[GLES1Blend alloc] init];
    [blend normal];
    GLES1TextureAtlasAnimatorAsset* animatorAsset = [[GLES1TextureAtlasAnimatorAsset alloc] init];
    GLES1BaseAsset* frame = [[GLES1RectangleAsset1 alloc] init:1.0f height:1.0f color:GLES1Color.white];
    [frame create:path];
    [frame setBlend:blend];
    [animatorAsset setTestureAtlas:frame];
    [animatorAsset setFrameSpan:2];
    const GLfloat u[] = {0.0f, 0.075f, 0.1f, 0.175f, 0.2f, 0.275f, 0.29f, 0.375f, 0.37f, 0.475f, 0.48f, 0.565f, 0.57f, 0.65f, 0.67f, 0.75f, 0.77f, 0.84f, 0.845f, 0.94f};
    for (int i = 0; i < 20; i += 2) {
        float sx = u[i];
        float ex = u[i + 1];
        GLfloat uvs[] = {
            // left down
            sx,
            1.0f,
            // right down
            ex,
            1.0f,
            // left up
            sx,
            0.9f,
            // right down
            ex,
            1.0f,
            // right up
            ex,
            0.9f,
            // left up
            sx,
            0.9f,
        };
        [animatorAsset addFrameUVs:uvs uvsCount:12];
    }
    self->asset = animatorAsset;
    self.timeLine.rate = 0.01f;
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    GLfloat x = cosf(self.timeLine.currentFrame) * -0.25f;
    GLfloat y = sinf(self.timeLine.currentFrame) * 0.25f;
    [self->asset.transform setPosition:x y:y z:0.0f];
    [self->asset.transform setScale:0.1f y:0.1f z:1.0f];
    [self->asset.transform setRotation:0.0f y:0.0f z:0.0f];
    [self.timeLine next:delta];
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
