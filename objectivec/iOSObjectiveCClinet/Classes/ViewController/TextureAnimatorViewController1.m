// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "TextureAnimatorViewController1.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "TextureAnimatorBehaviour1.h"
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface TextureAnimatorViewController1 ()
@property GLES1Renderer* renderer;
@property NSMutableArray<TextureAnimatorBehaviour1*>* behaviours;
@end
@implementation TextureAnimatorViewController1
@synthesize renderer;
@synthesize behaviours;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    self->renderer = [[GLES1Renderer alloc] init];
    [self->renderer create];
    [self->renderer.camera setClearColor:GLES1Color.white];
    [self->renderer.camera setClippingPlane:-1.0f farPlane:1.0f dimension:kDimension2D];
    self->behaviours = [[NSMutableArray<TextureAnimatorBehaviour1*> alloc] init];
    TextureAnimatorBehaviour1* behaviour1 = [[TextureAnimatorBehaviour1 alloc] init];
    [self->behaviours addObject:behaviour1];
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
    for (TextureAnimatorBehaviour1* behaviour in self->behaviours) {
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
    for (TextureAnimatorBehaviour1* behaviour in self->behaviours) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        GLES1TextureAnimatorAsset* asset = (GLES1TextureAnimatorAsset*)behaviour.asset;
        GLES1BaseAsset* currentFrame = [asset getCurrentFrame];
        [self->renderer render:currentFrame];
    }
    [self->renderer present];
    return;
}
@end
