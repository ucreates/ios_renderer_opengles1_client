// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "MaterialBehaviour1.h"
@interface MaterialBehaviour1 ()
@property double rotate;
@end
@implementation MaterialBehaviour1
@synthesize asset;
@synthesize rotate;
- (id)init {
    self = [super init];
    GLES1Material* material = [[GLES1Material alloc] init];
    [material setAmbient:[[GLES1Color alloc] init:1.0f g:0.0f b:0.0f a:1.0f]];
    [material setDiffuse:[[GLES1Color alloc] init:0.0f g:1.0f b:0.0f a:1.0f]];
    [material setSpecular:[[GLES1Color alloc] init:1.0f g:1.0f b:1.0f a:1.0f]];
    self->asset = [[GLES1CubeAsset1 alloc] init:1.0f height:1.0f depth:1.0f color:GLES1Color.white];
    [self->asset setMaterial:material];
    [self->asset create];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    [self->asset.transform setPosition:0.0f y:0.0f z:0.0f];
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
