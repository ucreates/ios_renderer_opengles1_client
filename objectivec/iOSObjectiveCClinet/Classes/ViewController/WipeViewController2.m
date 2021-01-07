// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2019 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "WipeViewController2.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "CubeBehaviour1.h"
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface WipeViewController2 ()
@property GLES1Renderer* renderer;
@property GLES1WipeAsset1* wipe;
@property NSMutableArray<CubeBehaviour1*>* behaviours;
@end
@implementation WipeViewController2
@synthesize renderer;
@synthesize wipe;
@synthesize behaviours;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    self->renderer = [[GLES1Renderer alloc] init];
    [self->renderer create];
    [self->renderer.camera setClearColor:GLES1Color.black];
    [self->renderer.camera setFov:60.0f];
    [self->renderer.camera setClippingPlane:0.1f farPlane:100.0f dimension:kDimension3D];
    [self->renderer.camera setLookAt:GLKVector3Make(0.0f, 0.0f, -5.0f) center:GLKVector3Make(0.0f, 0.0f, 0.0f) up:GLKVector3Make(0.0f, 1.0f, 0.0f)];
    self->behaviours = [[NSMutableArray<CubeBehaviour1*> alloc] init];
    for (int i = 0; i < 1; i++) {
        CubeBehaviour1* behaviour = [[CubeBehaviour1 alloc] init];
        [self->behaviours addObject:behaviour];
    }
    GLKView* glkView = (GLKView*)self.view;
    glkView.context = self->renderer.context;
    glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    glkView.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    CAEAGLLayer* caglLayer = (CAEAGLLayer*)self.view.layer;
    caglLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking : @NO, kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8};
    [caglLayer setOpaque:YES];
    CGSize size = UIScreen.mainScreen.nativeBounds.size;
    [self->renderer bind:caglLayer width:size.width height:size.height attachmentType:GL_STENCIL_ATTACHMENT_OES];
    self->wipe = [[GLES1WipeAsset1 alloc] init:0.5f divideCount:100 maxScale:5.0f];
    [self->wipe create:kDimension3D];
    return;
}
- (void)viewWillLayoutSubviews {
    CAEAGLLayer* caglLayer = (CAEAGLLayer*)self.view.layer;
    [self->renderer rebind:caglLayer];
    return;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    for (CubeBehaviour1* behaviour in self->behaviours) {
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
    [self->renderer transform:kDimension3D];
    [self->renderer render:self->wipe wipeType:kWipeIn delta:self.timeSinceLastUpdate totalTime:2];
    for (CubeBehaviour1* behaviour in self->behaviours) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        [self->renderer render:behaviour.asset];
    }
    [self->renderer present];
    return;
}
@end
