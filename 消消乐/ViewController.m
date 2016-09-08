#import "ViewController.h"

typedef enum : NSUInteger {
    MoveViewType_Left=1,
    MoveViewType_Mid=2,
    MoveViewType_Right=3,
    MoveViewType_None=0
} MoveViewType;
@interface ViewController ()
@property (nonatomic,assign)CGPoint oldPoint;
@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *midView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,assign)MoveViewType moveViewType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBGImage];
    [self loadUI];
    [self loadCanMoveUI]; //test
    
}

- (void)loadBGImage{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"bgImage.jpg"];
    [self.view addSubview:imageView];
}

- (void)loadUI{
    UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake((self.view.width-10*30)/2, (self.view.height-10*30)/2, 300, 300)];
    mainView.backgroundColor=[UIColor clearColor];
    self.mainView=mainView;
    for (int i=0; i<10; i++) {
        for (int j=0; j<10; j++) {
            UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
            button.frame=CGRectMake(30*j,i*30, 30, 30);
            button.tag=100+i*10+j+1;
            button.layer.borderWidth=1;
            [button setBackgroundImage:[self getImageWithType:arc4random()%5+1] forState:(UIControlStateNormal)];
            button.layer.borderColor=[[UIColor grayColor]CGColor];
            button.backgroundColor=[UIColor clearColor];
            button.userInteractionEnabled=NO;
            [mainView addSubview:button];
        }
    }
    [self.view addSubview:mainView];
}

- (void)loadCanMoveUI{
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake((self.view.width-10*30)/2, (self.view.height-10*30)/2+10*30+25, 75, 75)];
    leftView.backgroundColor=[UIColor redColor];
    leftView.contentMode=UIViewContentModeTop|UIViewContentModeBottom|UIViewContentModeLeft|UIViewContentModeRight;
    leftView.translatesAutoresizingMaskIntoConstraints=NO;
    self.leftView=leftView;
    NSInteger sjLeft=arc4random()%5+1;
    for (int i=0; i<5; i++) {
        for (int j=0; j<5; j++) {
            UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
            button.frame=CGRectMake(15*j,i*15, 15, 15);
//            button.tag=100+i*10+j+1;
            button.layer.borderWidth=1;
//            button.contentMode=UIViewContentModeRedraw|UIViewContentModeTop|UIViewContentModeBottom|UIViewContentModeLeft|UIViewContentModeRight;
            [button setBackgroundImage:[self getImageWithType:sjLeft] forState:(UIControlStateNormal)];
            button.layer.borderColor=[[UIColor grayColor]CGColor];
            button.backgroundColor=[UIColor clearColor];
            button.userInteractionEnabled=NO;
            [leftView addSubview:button];
        }
    }
    [self.view addSubview:leftView];

    UIView *midView=[[UIView alloc]initWithFrame:CGRectMake((self.view.width-10*30)/2+75+75/2.0, (self.view.height-10*30)/2+10*30+25, 75, 75)];
    midView.backgroundColor=[UIColor blueColor];
    midView.contentMode=UIViewContentModeTop|UIViewContentModeBottom|UIViewContentModeLeft|UIViewContentModeRight;
    midView.translatesAutoresizingMaskIntoConstraints=NO;
    self.midView=midView;
    NSInteger sjMid=arc4random()%5+1;
    for (int i=0; i<5; i++) {
        for (int j=0; j<5; j++) {
            UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
            button.frame=CGRectMake(15*j,i*15, 15, 15);
//            button.tag=100+i*10+j+1;
            button.layer.borderWidth=1;
//            button.contentMode=UIViewContentModeRedraw|UIViewContentModeCenter;
            [button setBackgroundImage:[self getImageWithType:sjMid] forState:(UIControlStateNormal)];
            button.layer.borderColor=[[UIColor grayColor]CGColor];
            button.backgroundColor=[UIColor clearColor];
            button.userInteractionEnabled=NO;
            [midView addSubview:button];
        }
    }
    [self.view addSubview:midView];

    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake((self.view.width-10*30)/2+150+75, (self.view.height-10*30)/2+10*30+25, 75, 75)];
    rightView.backgroundColor=[UIColor greenColor];
    rightView.translatesAutoresizingMaskIntoConstraints=NO;
    rightView.contentMode=UIViewContentModeTop|UIViewContentModeBottom|UIViewContentModeLeft|UIViewContentModeRight;
    self.rightView=rightView;
    NSInteger sjRight=arc4random()%5+1;
    for (int i=0; i<5; i++) {
        for (int j=0; j<5; j++) {
            UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
            button.frame=CGRectMake(15*j,i*15, 15, 15);
//            button.tag=100+i*10+j+1;
            button.layer.borderWidth=1;
//            button.contentMode=UIViewContentModeRedraw|UIViewContentModeCenter;
            [button setBackgroundImage:[self getImageWithType:sjRight] forState:(UIControlStateNormal)];
            button.layer.borderColor=[[UIColor grayColor]CGColor];
            button.backgroundColor=[UIColor clearColor];
            button.userInteractionEnabled=NO;
            [rightView addSubview:button];
        }
    }
    [self.view addSubview:rightView];
}

- (UIImage *)getImageWithType:(NSInteger)type{
    NSInteger const myType=type;
    switch (myType) {
        case 1:return [UIImage imageNamed:@"red"]; break;
        case 2:return [UIImage imageNamed:@"blue"]; break;
        case 3:return [UIImage imageNamed:@"green"]; break;
        case 4:return [UIImage imageNamed:@"purple"]; break;
        case 5:return [UIImage imageNamed:@"yellow"]; break;
    }
    return nil;
}

- (BOOL)isInside:(CGPoint)point{
    if (point.x>=0&&point.x<=75&&point.y>=0&&point.y<=75) {
        return YES;
    }
    return NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    self.oldPoint=[touch locationInView:self.view];
    CGPoint leftPoint=[touch locationInView:self.leftView];
    CGPoint midPoint=[touch locationInView:self.midView];
    CGPoint rightPoint=[touch locationInView:self.rightView];
    if ([self isInside:leftPoint]){self.moveViewType=MoveViewType_Left;self.leftView.frame=CGRectMake((self.view.width-10*30)/2-30, (self.view.height-10*30)/2+10*30-25, 140, 140);[self.leftView setNeedsDisplay];}
    else if ([self isInside:midPoint]){self.moveViewType=MoveViewType_Mid;self.midView.frame=CGRectMake((self.view.width-10*30)/2-30, (self.view.height-10*30)/2+10*30-25, 140, 140);[self.midView setNeedsDisplay];}
    else if ([self isInside:rightPoint]){self.moveViewType=MoveViewType_Right;self.rightView.frame=CGRectMake((self.view.width-10*30)/2-30, (self.view.height-10*30)/2+10*30-25, 140, 140);[self.rightView setNeedsDisplay];}
    else self.moveViewType=MoveViewType_None;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if (self.moveViewType==0) return;
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    CGFloat x,y;
    x=point.x-self.oldPoint.x;
    y=point.y-self.oldPoint.y;
    self.oldPoint=point;
    switch (self.moveViewType) {
        case MoveViewType_Left:
        {
            CGPoint oldCenter=self.leftView.center;
            self.leftView.center=CGPointMake(oldCenter.x+x, oldCenter.y+y);
        }
            break;
        case MoveViewType_Mid:
        {
            CGPoint oldCenter=self.midView.center;
            self.midView.center=CGPointMake(oldCenter.x+x, oldCenter.y+y);
        }
            break;
        case MoveViewType_Right:
        {
            CGPoint oldCenter=self.rightView.center;
            self.rightView.center=CGPointMake(oldCenter.x+x, oldCenter.y+y);
        }
            break;
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}

@end
