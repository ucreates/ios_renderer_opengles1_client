// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "TextureBehaviour7.h"
@interface TextureBehaviour7 ()
@property double rotate;
@end
@implementation TextureBehaviour7
@synthesize asset;
@synthesize rotate;
- (id)init {
    self = [super init];
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"texture01" ofType:@"jpg"];
    self->asset = [[CubeAsset1 alloc] init:1.0f height:1.0f depth:1.0f color:GLESColor.white];
    [self->asset create:path];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    [self->asset.transform setPosition:0.0f y:0.0f z:0.0f];
    [self->asset.transform setScale:1.0f y:1.0f z:1.0f];
    [self->asset.transform setRotation:self->rotate y:self->rotate z:self->rotate];
    [self.timeLine next:delta];
    self->rotate += 1.0f;
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
