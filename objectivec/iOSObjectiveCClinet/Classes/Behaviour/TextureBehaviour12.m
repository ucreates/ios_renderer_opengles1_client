// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "TextureBehaviour12.h"
@interface TextureBehaviour12 ()
@property double rotate;
@end
@implementation TextureBehaviour12
@synthesize asset;
@synthesize rotate;
- (id)init {
    self = [super init];
    NSBundle* bundle = [NSBundle mainBundle];
    NSMutableArray<NSString*>* paths = [[NSMutableArray<NSString*> alloc] init];
    for (int i = 0; i < 8; i++) {
        NSString* fileName = [NSString stringWithFormat:@"mipmap%02d", i + 1];
        NSString* path = [bundle pathForResource:fileName ofType:@"jpg"];
        [paths addObject:path];
    }
    self->asset = [[GLES1CubeAsset1 alloc] init:1.0f height:1.0f depth:1.0f color:GLES1Color.white];
    [self->asset createMipmap:paths];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    GLfloat z = sinf(self.timeLine.currentTime) * 100.0f;
    z = fabsf(z);
    [self->asset.transform setPosition:0.0f y:0.0f z:z];
    [self->asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self->asset.transform setRotation:self->rotate y:self->rotate z:self->rotate];
    [self.timeLine next:delta * 0.5f];
    self->rotate += 1.0f;
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
