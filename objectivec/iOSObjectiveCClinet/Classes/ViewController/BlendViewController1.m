// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import "BlendViewController1.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlendBehaviour1.h"
#import "BlendBehaviour2.h"
#import "BlendBehaviour3.h"
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface BlendViewController1 ()
@property GLES1Renderer* renderer;
@property NSMutableArray<BlendBehaviour*>* behaviours;
@end
@implementation BlendViewController1
@synthesize renderer;
@synthesize behaviours;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    self->renderer = [[GLES1Renderer alloc] init];
    [self->renderer create];
    [self->renderer.camera setClearColor:GLES1Color.black];
    [self->renderer.camera setClippingPlane:-1.0f farPlane:1.0f dimension:kDimension2D];
    self->behaviours = [[NSMutableArray<BlendBehaviour*> alloc] init];
    BlendBehaviour1* behaviour1 = [[BlendBehaviour1 alloc] init];
    BlendBehaviour2* behaviour2 = [[BlendBehaviour2 alloc] init];
    BlendBehaviour3* behaviour3 = [[BlendBehaviour3 alloc] init];
    [self->behaviours addObject:behaviour1];
    [self->behaviours addObject:behaviour2];
    [self->behaviours addObject:behaviour3];
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
    for (BlendBehaviour1* behaviour in self->behaviours) {
        [behaviour onDestroy];
    }
    [self->renderer delete];
    return;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)glkViewControllerUpdate:(nonnull GLKViewController*)controller {
    NSComparisonResult (^comparecbk)(id obj1, id obj2) = ^(id obj1, id obj2) {
      BlendBehaviour* b1 = obj1;
      BlendBehaviour* b2 = obj2;
      if (b1.asset.transform.position.z < b2.asset.transform.position.z) {
          return (NSComparisonResult)NSOrderedDescending;
      } else {
          return (NSComparisonResult)NSOrderedAscending;
      }
      return (NSComparisonResult)NSOrderedSame;
    };
    self->behaviours = [[self->behaviours sortedArrayUsingComparator:comparecbk] copy];
    [self->renderer clear];
    [self->renderer transform:kDimension2D];
    for (BlendBehaviour* behaviour in self->behaviours) {
        [behaviour onUpdate:self.timeSinceLastUpdate];
        [self->renderer render:behaviour.asset];
    }
    [self->renderer present];
    return;
}
@end
