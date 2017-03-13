//
//  ViewController.m
//  UIDynamic(重力行为+碰撞检测)
//
//  Created by iosdev on 17/3/13.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置view的角度
    self.blueView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 //1.重力行为
//    [self testGravity];
 //2.重力行为+碰撞检测
//    [self testGravityAndCollsion];
//3.测试重力的一些属性
    [self testGravityAndCollsion2];
//用2根线作为边界
//    [self testGravityAndCollision3];
//4.用圆作为边界
//    [self testGravityAndCollision4];
}

- (void)testGravity{
    //1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    //2.添加物理仿真元素
    [gravity addItem:self.blueView];
    //3.执行仿真
    [self.animator addBehavior:gravity];
}

- (void)testGravityAndCollsion{
    //1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.blueView];
    
    //2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.blueView];
    [collision addItem:self.progress];
    [collision addItem:self.segment];
    
    //让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

- (void)testGravityAndCollsion2{
    //1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    //设置重力方向
//    gravity.angle = (M_PI_2-M_PI_4);
    //设置重力加速度，重力加速度越大 碰撞越厉害
    gravity.magnitude = 100;
    //设置重力方向（是一个二维向量）
    gravity.gravityDirection = CGVectorMake(0, 1);
    [gravity addItem:self.blueView];
    
    //2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.blueView];
    [collision addItem:self.progress];
    [collision addItem:self.segment];
    
    //让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}
- (void)testGravityAndCollision3{
    //1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.blueView];
    
    //2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.blueView];
    CGPoint startP = CGPointMake(0, 160);
    CGPoint endP = CGPointMake(320, 400);
    [collision addBoundaryWithIdentifier:@"line1" fromPoint:startP toPoint:endP];
    CGPoint startP1 = CGPointMake(320, 0);
    [collision addBoundaryWithIdentifier:@"line2" fromPoint:startP1 toPoint:endP];
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
  
}

- (void)testGravityAndCollision4{
    //1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.blueView];
    //2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.blueView];
    //添加一个椭圆为碰撞边界
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 320, 320)];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    
}
- (UIDynamicAnimator *)animator{
    if (!_animator) {
        //创建物理仿真器 （ReferenceView:参照视图，设置仿真范围）
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
