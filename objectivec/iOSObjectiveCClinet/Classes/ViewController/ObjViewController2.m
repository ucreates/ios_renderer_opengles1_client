// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "ObjViewController2.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BackgroundBehaviour1.h"
#import "ObjBehaviour1.h"
#import "UIBehaviour1.h"
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface ObjViewController2 ()
@property GLES1Renderer* renderer;
@property NSMutableArray<ObjBehaviour1*>* behaviours3d;
@property NSMutableArray<BackgroundBehaviour1*>* behavioursBG;
@property NSMutableArray<UIBehaviour1*>* behavioursUI;
@end
@implementation ObjViewController2
@synthesize renderer;
@synthesize behaviours3d;
@synthesize behavioursBG;
@synthesize behavioursUI;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    GLES1Light* light = [[GLES1Light alloc] init:GL_LIGHT0];
    [light setPosition:-3.0 y:0.0 z:-3.0];
    [light setAmbient:GLESColor.white];
    [light setDiffuse:GLESColor.white];
    [light setSpecular:GLESColor.white];
    self->renderer = [[GLES1Renderer alloc] init];
    [self->renderer create];
    [self->renderer.camera setFov:60.0f];
    [self->renderer.camera setClippingPlane:-1.0f farPlane:10.0f dimension:kDimension2D];
    [self->renderer.camera setClippingPlane:0.1f farPlane:100.0f dimension:kDimension3D];
    [self->renderer.camera setLookAt:GLKVector3Make(0.0f, 0.0f, -1.0f) center:GLKVector3Make(0.0f, 0.0f, 0.0f) up:GLKVector3Make(0.0f, 1.0f, 0.0f)];
    [self->renderer addLight:light];
    self->behaviours3d = [[NSMutableArray<ObjBehaviour1*> alloc] init];
    self->behavioursBG = [[NSMutableArray<BackgroundBehaviour1*> alloc] init];
    self->behavioursUI = [[NSMutableArray<UIBehaviour1*> alloc] init];
    for (int i = 0; i < 1; i++) {
        ObjBehaviour1* behaviour3d = [[ObjBehaviour1 alloc] init];
        BackgroundBehaviour1* behaviourBG = [[BackgroundBehaviour1 alloc] init];
        UIBehaviour1* behaviourUI = [[UIBehaviour1 alloc] init];
        [self->behaviours3d addObject:behaviour3d];
        [self->behavioursBG addObject:behaviourBG];
        [self->behavioursUI addObject:behaviourUI];
    }
    GLKView* glkView = (GLKView*)self.view;
    glkView.context = self->renderer.context;
    glkView.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    CAEAGLLayer* caglLayer = (CAEAGLLayer*)self.view.layer;
    caglLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking : @NO, kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8};
    [caglLayer setOpaque:YES];
    CGSize size = UIScreen.mainScreen.nativeBounds.size;
    [self->renderer bind:caglLayer width:size.width height:size.height];
    return;
}
- (void)viewWillLayoutSubviews {
    CAEAGLLayer* caglLayer = (CAEAGLLayer*)self.view.layer;
    [self->renderer rebind:caglLayer];
    return;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    for (ObjBehaviour1* behaviour in self->behaviours3d) {
        [behaviour onDestroy];
    }
    [self->renderer delete];
    return;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)glkViewControllerUpdate:(nonnull GLKViewController*)controller {
    [self->renderer clear];
    [self->renderer transform:kDimension2D];
    for (BackgroundBehaviour1* behaviour in self->behavioursBG) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        [self->renderer render:behaviour.asset];
    }
    [self->renderer clear:YES];
    [self->renderer transform:kDimension3D];
    for (ObjBehaviour1* behaviour in self->behaviours3d) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        ObjAsset* asset = (ObjAsset*)behaviour.asset;
        for (Mesh* mesh in asset.subMeshes) {
            [self->renderer render:mesh];
        }
    }
    [self->renderer transform:kDimension2D];
    for (UIBehaviour1* behaviour in self->behavioursUI) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        TextureAtlasAnimatorAsset* asset = (TextureAtlasAnimatorAsset*)behaviour.asset;
        BaseAsset* currentFrame = [asset getCurrentFrame];
        [self->renderer render:currentFrame];
    }
    [self->renderer present];
    return;
}
@end
