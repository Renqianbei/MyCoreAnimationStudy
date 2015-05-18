//
//  ViewController.m
//  RcoreAnimationStudy
//
//  Created by 任前辈 on 15-5-18.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    CALayer 有一个属性叫做`contents`，这个属性的类型被定义为id，意味着它可以是任何类型的对象。在这种情况下，你可以给`contents`属性赋任何值，你的app仍然能够编译通过。但是，在实践中，如果你给`contents`赋的不是CGImage，那么你得到的图层将是空白的。
//    
//    `contents`这个奇怪的表现是由Mac OS的历史原因造成的。它之所以被定义为id类型，是因为在Mac OS系统上，这个属性对CGImage和NSImage类型的值都起作用。如果你试图在iOS平台上将UIImage的值赋给它，只能得到一个空白的图层。一些初识Core Animation的iOS开发者可能会对这个感到困惑。
//    
//    头疼的不仅仅是我们刚才提到的这个问题。事实上，你真正要赋值的类型应该是CGImageRef，它是一个指向CGImage结构的指针。UIImage有一个CGImage属性，它返回一个"CGImageRef",如果你想把这个值直接赋值给CALayer的`contents`，那你将会得到一个编译错误。因为CGImageRef并不是一个真正的Cocoa对象，而是一个Core Foundation类型。
//    
//    尽管Core Foundation类型跟Cocoa对象在运行时貌似很像（被称作toll-free bridging），他们并不是类型兼容的，不过你可以通过bridged关键字转换。如果要给图层的寄宿图赋值，你可以按照以下这个方法：
//    
//    ``` objective-c
//    layer.contents = (__bridge id)image.CGImage;
//    ```
//    
//    如果你没有使用ARC（自动引用计数），你就不需要__bridge这部分。但是，你干嘛不用ARC？！
    UIImage * image = [UIImage imageNamed:@"testImg"];
    self.layerView.layer.contents  = (__bridge id)([image CGImage]) ;
    
//    UIView大多数视觉相关的属性比如`contentMode`，对这些属性的操作其实是对对应图层的操作。
//    
//    CALayer与`contentMode`对应的属性叫做`contentsGravity`，但是它是一个NSString类型，而不是像对应的UIKit部分，那里面的值是枚举。`contentsGravity`可选的常量值有以下一些：
//    
//    * kCAGravityCenter
//    * kCAGravityTop
//    * kCAGravityBottom
//    * kCAGravityLeft
//    * kCAGravityRight
//    * kCAGravityTopLeft
//    * kCAGravityTopRight
//    * kCAGravityBottomLeft
//    * kCAGravityBottomRight
//    * kCAGravityResize
//    * kCAGravityResizeAspect
//    * kCAGravityResizeAspectFill
//    
//    和`cotentMode`一样，`contentsGravity`的目的是为了决定内容在图层的边界中怎么对齐，我们将使用kCAGravityResizeAspect，它的效果等同于UIViewContentModeScaleAspectFit， 同时它还能在图层中等比例拉伸以适应图层的边界。
//
    
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    
//    如果`contentsScale`设置为1.0，将会以每个点1个像素绘制图片，如果设置为2.0，则会以每个点2个像素绘制图片，这就是我们熟知的Retina屏幕。（如果你对像素和点的概念不是很清楚的话，这个章节的后面部分将会对此做出解释）。
//    
//    这并不会对我们在使用kCAGravityResizeAspect时产生任何影响，因为它就是拉伸图片以适应图层而已，根本不会考虑到分辨率问题。但是如果我们把`contentsGravity`设置为kCAGravityCenter（这个值并不会拉伸图片），那将会有很明显的变化（如图2.3）

//     用错误的`contentsScale`属性显示Retina图片
//    
//    如你所见，我们的雪人不仅有点大还有点像素的颗粒感。那是因为和UIImage不同，CGImage没有拉伸的概念。当我们使用UIImage类去读取我们的雪人图片的时候，他读取了高质量的Retina版本的图片。但是当我们用CGImage来设置我们的图层的内容时，拉伸这个因素在转换的时候就丢失了。不过我们可以通过手动设置`contentsScale`来修复这个问题（

//    当用代码的方式来处理寄宿图的时候，一定要记住要手动的设置图层的`contentsScale`属性，否则，你的图片在Retina设备上就显示得不正确啦。代码如下：
//    
//    ```objective-c
//    layer.contentsScale = [UIScreen mainScreen].scale;
//    ```
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    
    
//    UIView有一个叫做`clipsToBounds`的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做`masksToBounds`，把它设置为YES，雪人就在边界里啦～（如图2.5）
    self.layerView.layer.masksToBounds = YES;
    
//    默认的`contentsRect`是{0, 0, 1, 1}，这意味着整个寄宿图默认都是可见的，如果我们指定一个小一点的矩形，图片就会被裁剪（如图2.6）

//    self.layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    
    
    
    CALayer * bluelayer = [CALayer layer];
    bluelayer.frame = CGRectMake(25,25, 50, 50);
    bluelayer.backgroundColor = [UIColor blueColor].CGColor;
    bluelayer.delegate = self;
    bluelayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layerView.layer addSublayer:bluelayer];
    [bluelayer display];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
