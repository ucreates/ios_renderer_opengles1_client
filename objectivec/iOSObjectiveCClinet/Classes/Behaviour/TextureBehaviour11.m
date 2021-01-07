// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "TextureBehaviour11.h"
@interface TextureBehaviour11 ()
@end
@implementation TextureBehaviour11
@synthesize asset;
- (id)init:(int)type {
    self = [super init];
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"texture03" ofType:@"png"];
    GLES1Blend* blend = [[GLES1Blend alloc] init];
    [blend normal];
    self->_type = type;
    self->asset = [[GLES1RectangleAsset1 alloc] init:1.0f height:1.0f color:GLES1Color.white];
    [self.asset setBlend:blend];
    [self->asset create:path];
    self.timeLine.rate = 0.01f;
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    GLfloat alpha = fabsf(cosf(self.timeLine.currentFrame));
    if (0 == self->_type) {
        GLfloat x = sinf(self.timeLine.currentFrame);
        [self->asset.transform setPosition:x y:0.0f z:0.0f];
    } else {
        GLfloat y = sinf(self.timeLine.currentFrame);
        [self->asset.transform setPosition:0.0f y:y z:0.0f];
    }
    [self->asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self->asset.transform setRotation:0.0f y:0.0f z:0.0f];
    [self->asset.vertex setAlpha:alpha];
    [self.timeLine next:delta];
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
