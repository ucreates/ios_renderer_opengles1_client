// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "ObjBehaviour1.h"
@interface ObjBehaviour1 ()
@property double rotate;
@property int objType;
@end
@implementation ObjBehaviour1
@synthesize asset;
@synthesize rotate;
@synthesize objType;
- (id)init {
    self = [super init];
    self->objType = (int)[Random range:0.0f max:3.0f];
    NSString* objName = @"";
    if (0 == self->objType) {
        objName = @"apple";
    } else if (1 == self->objType) {
        objName = @"android";
    } else {
        objName = @"tank";
    }
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:objName ofType:@"obj"];
    self->asset = [[ObjAsset alloc] init];
    [self->asset create:path];
    return self;
}
- (void)onCreate:(Parameter*)parameter {
    return;
}
- (void)onUpdate:(NSTimeInterval)delta {
    ObjAsset* asset = (ObjAsset*)self.asset;
    for (Mesh* mesh in asset.subMeshes) {
        if (0 == self->objType) {
            [mesh.transform setPosition:0.0f y:-0.1f z:0.0f];
            [mesh.transform setScale:0.025f y:0.025f z:0.025f];
            [mesh.transform setRotation:0.0f y:self->rotate z:0.0f];
        } else if (1 == self->objType) {
            [mesh.transform setPosition:0.0f y:-0.1f z:0.0f];
            [mesh.transform setScale:1.5f y:1.5f z:1.5f];
            [mesh.transform setRotation:0.0f y:self->rotate z:0.0f];
        } else {
            [mesh.transform setPosition:0.0f y:0.0f z:0.0f];
            [mesh.transform setScale:0.0015f y:0.0015f z:0.0015f];
            [mesh.transform setRotation:270.0f y:0.0f z:self->rotate];
        }
    }
    [self.timeLine next:delta];
    self->rotate += 1.0f;
    return;
}
- (void)onDestroy {
    [self->asset dispose];
    return;
}
@end
