// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#ifndef TextureBehaviour20_h
#define TextureBehaviour20_h
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface TextureBehaviour20 : BaseBehaviour
@property FiniteStateMachine<TextureBehaviour20*>* stateMachine;
@property GLES1BaseAsset* asset;
- (id)init;
- (void)onCreate:(Parameter*)parameter;
- (void)onUpdate:(NSTimeInterval)delta;
- (void)onDestroy;
@end
#endif /* TextureBehaviour20_h */
