// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "LightingViewController2.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "CubeBehaviour1.h"
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface LightingViewController2 ()
@property GLES1Renderer* renderer;
@property NSMutableArray<CubeBehaviour1*>* behaviours;
@end
@implementation LightingViewController2
@synthesize renderer;
@synthesize behaviours;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    GLES1Light* light1 = [[GLES1Light alloc] init:GL_LIGHT0];
    [light1 setPosition:3.0 y:0.0 z:0.0];
    [light1 setDirection:-1.0 y:0.0 z:0.0];
    [light1 setAmbient:[[GLESColor alloc] init:0.0f g:0.0f b:0.0f a:1.0f]];
    [light1 setDiffuse:[[GLESColor alloc] init:0.0f g:0.0f b:1.0f a:1.0f]];
    GLES1Light* light2 = [[GLES1Light alloc] init:GL_LIGHT1];
    [light2 setPosition:-3.0 y:0.0 z:0.0];
    [light1 setDirection:1.0 y:0.0 z:0.0];
    [light2 setAmbient:[[GLESColor alloc] init:0.0f g:0.0f b:0.0f a:1.0f]];
    [light2 setDiffuse:[[GLESColor alloc] init:1.0f g:0.0f b:0.0f a:1.0f]];
    self->renderer = [[GLES1Renderer alloc] init];
    [self->renderer create];
    [self->renderer.camera setFov:60.0f];
    [self->renderer.camera setClippingPlane:0.1f farPlane:100.0f];
    [self->renderer.camera setLookAt:GLKVector3Make(0.0f, 0.0f, -5.0f) center:GLKVector3Make(0.0f, 0.0f, 0.0f) up:GLKVector3Make(0.0f, 1.0f, 0.0f)];
    [self->renderer addLight:light1];
    [self->renderer addLight:light2];
    self->behaviours = [[NSMutableArray<CubeBehaviour1*> alloc] init];
    for (int i = 0; i < 1; i++) {
        CubeBehaviour1* behaviour = [[CubeBehaviour1 alloc] init];
        [self->behaviours addObject:behaviour];
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
    [renderer transform:kDimension3D];
    for (CubeBehaviour1* behaviour in self->behaviours) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        [renderer render:behaviour.asset];
    }
    [renderer present];
    return;
}
@end