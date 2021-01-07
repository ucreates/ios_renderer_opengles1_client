// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "FogViewController1.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "FogBehaviour1.h"
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface FogViewController1 ()
@property GLES1Renderer* renderer;
@property NSMutableArray<FogBehaviour1*>* behaviours;
@end
@implementation FogViewController1
@synthesize renderer;
@synthesize behaviours;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    GLES1Fog* fog = [[GLES1Fog alloc] init:GL_LINEAR];
    [fog setColor:GLES1Color.black];
    [fog setHint:GL_NICEST];
    [fog setDensity:1.0f];
    [fog setPosition:1.0f end:7.0f];
    self->renderer = [[GLES1Renderer alloc] init];
    [self->renderer create];
    [self->renderer.camera setFov:60.0f];
    [self->renderer.camera setClippingPlane:0.1f farPlane:100.0f dimension:kDimension3D];
    [self->renderer.camera setLookAt:GLKVector3Make(0.0f, 0.0f, -5.0f) center:GLKVector3Make(0.0f, 0.0f, 0.0f) up:GLKVector3Make(0.0f, 1.0f, 0.0f)];
    [self->renderer setFog:fog];
    self->behaviours = [[NSMutableArray<FogBehaviour1*> alloc] init];
    for (int i = 0; i < 1; i++) {
        FogBehaviour1* behaviour = [[FogBehaviour1 alloc] init];
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
    for (FogBehaviour1* behaviour in self->behaviours) {
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
    for (FogBehaviour1* behaviour in self->behaviours) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        [self->renderer render:behaviour.asset];
    }
    [self->renderer present];
    return;
}
@end
