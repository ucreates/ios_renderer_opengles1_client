// ======================================================================
// Project Name    : ios_renderer_opengles1_client
//
// Copyright © 2020 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#ifndef TriangleBehaviour4_h
#define TriangleBehaviour4_h
#import "iOSObjectiveCFoundation.h"
#import "iOSObjectiveCGLES1Renderer.h"
@interface TriangleBehaviour4 : BaseBehaviour
@property FiniteStateMachine<TriangleBehaviour4*>* stateMachine;
@property BaseAsset* asset;
- (id)init;
- (void)onCreate:(Parameter*)parameter;
- (void)onUpdate:(NSTimeInterval)delta;
- (void)onDestroy;
@end
#endif /* TriangleBehaviour4_h */
