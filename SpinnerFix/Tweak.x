/**
 * SpinnerFix — Fix stuck loading spinner on iPad
 *
 * When watching YouTube on iPad, the loading spinner can get stuck
 * over the video even while playback is active. This hooks the player
 * state change and clears stuck spinners after playback is confirmed.
 */

@interface YTPlayerView : UIView
@property (nonatomic, readonly) UIView *overlayView;
@end

static void hideStuckSpinnersInView(UIView *view) {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"MDCActivityIndicator")] ||
            [subview isKindOfClass:NSClassFromString(@"QTMActivityIndicator")]) {
            if ([subview respondsToSelector:@selector(isAnimating)] && [(id)subview isAnimating]) {
                subview.hidden = YES;
                if ([subview respondsToSelector:@selector(stopAnimating)]) {
                    [(id)subview stopAnimating];
                }
            }
        }
        hideStuckSpinnersInView(subview);
    }
}

%hook YTContentVideoPlayerOverlayViewController
- (void)playerStateDidChangeToState:(NSInteger)state {
    %orig;

    // State 2 = Playing
    if (state == 2) {
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;

            NSInteger currentState = 0;
            if ([strongSelf respondsToSelector:@selector(playerState)]) {
                currentState = [(id)strongSelf playerState];
            }
            if (currentState != 2) return;

            UIView *view = strongSelf.view;
            while (view && ![view isKindOfClass:NSClassFromString(@"YTPlayerView")]) {
                view = view.superview;
            }

            if ([view isKindOfClass:NSClassFromString(@"YTPlayerView")]) {
                YTPlayerView *playerView = (YTPlayerView *)view;
                if (playerView.overlayView) {
                    hideStuckSpinnersInView(playerView.overlayView);
                }
                hideStuckSpinnersInView(playerView);
            }
        });
    }
}
%end
