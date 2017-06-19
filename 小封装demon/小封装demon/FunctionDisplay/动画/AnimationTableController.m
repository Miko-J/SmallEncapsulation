//
//  AnimationTableController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/19.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "AnimationTableController.h"
#import "EncapsulationSystemControls.h"
#import "PingInvertTransition.h"
@interface AnimationTableController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *backImageView;
@end

@implementation AnimationTableController{
    UIPercentDrivenInteractiveTransition *percentTransition;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgeGes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置ui
    [self setUpUI];
}
#pragma mark -设置UI
- (void)setUpUI
{
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return percentTransition;
}

-(void)edgePan:(UIPanGestureRecognizer *)recognizer{
    CGFloat per = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    per = MIN(1.0,(MAX(0.0, per)));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [percentTransition updateInteractiveTransition:per];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (per > 0.3) {
            [percentTransition finishInteractiveTransition];
        }else{
            [percentTransition cancelInteractiveTransition];
        }
        percentTransition = nil;
    }
}

#pragma mark: - 懒加载
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"003"]];
    }
    return _backImageView;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        PingInvertTransition *pingInvert = [PingInvertTransition new];
        return pingInvert;
    }else{
        return nil;
    }
}

@end
