- ## 该项目数据源来于百思不得姐 ，以下为项目笔记，在敲代码的时候会想到与其有所关联的知识点，顺便记录以下
- #### bounds是相对于父控件，frame是相对于自己
- //按钮状态取反,夜间模式
    nigthButton.selected = !nigthButton.selected;
- #### 设置导航栏的富文本和自定义导航栏滑动手势重写导航栏的push方法

```
//load方法只会调用一次，所以把设置富文本放在load方法里性能更好
+ (void)load
{
// 获取哪个类下面的导航条
UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];

[bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

// 设置导航条标题颜色
NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
titleAttr[NSForegroundColorAttributeName] = [UIColor blueColor];
titleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
[bar setTitleTextAttributes:titleAttr];

}
- (void)viewDidLoad {
[super viewDidLoad];

/**
自定导航控制的滑动手势 
handleNavigationTransition:方法是通过打印 
interactivePopGestureRecognizer导航卡滑动手势得到
*/
UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
[self.view addGestureRecognizer:pan];
//监控手势什么时候出发，只有非根控制器才需要触发手势
pan.delegate = self;
//禁止之前的手势
self.interactivePopGestureRecognizer.enabled =NO;
};
//决定是否触发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
return self.childViewControllers.count > 1;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
/**
统一设置返回按钮，只要用了XCNavigationController的push方法就会自动生成一个自定义的返回按钮，比单个页面去设置节省代码量
*/
if (self.childViewControllers.count >0) {
viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] hlghImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
}
//真正跳转的方法是父类做的
[super pushViewController:viewController animated:animated];
}
```
- #### tableViewCell每个下滑线可以用过两种方式解决
    - ##### 自定义下划线 
    - ##### 在自定义的cell中重写setframe方法
    - ##### 这两个方法都需要先把分割线隐藏 self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
```
- (void)setFrame:(CGRect)frame
{
frame.size.height -= 1;
// 才是真正去给cell赋值
[super setFrame:frame];
}
```

- #### 屏幕适配注意
    - ##### 一个view从xib加载，需要重新固定尺寸，一定要重新设置一下
    - ##### 在viewDidload设置控件frame不好，页面的生命周期有专门布局子控件的方法viewDidLayoutSubviews，在这个方法中布局子控件比较准
    
- #### 自定义button布局

```
#import "XCFastLoginButton.h"

@implementation XCFastLoginButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.XC_y = 0;
    self.imageView.XC_CenterX = self.XC_width * 0.5;
    
    self.titleLabel.XC_y = self.XC_height - self.titleLabel.XC_height;
    [self.titleLabel sizeToFit];
    self.titleLabel.XC_CenterX = self.XC_width * 0.5;
}
@end
```
- #### 给textFild添加拓展方法
    
```
#import "UITextField+Placeholder.h"
#import <objc/message.h>
@implementation UITextField (Placeholder)
+(void)load
{
    
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setXc_PlaceholderMethod = class_getInstanceMethod(self, @selector(setXc_Placeholder:));
    //添加交换方法把系统的方法换成自定义的方法
    method_exchangeImplementations(setPlaceholderMethod, setXc_PlaceholderMethod);
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 快速设置占位文字颜色 => 文本框占位文字可能是label => 验证占位文字是label => 拿到label => 查看label属性名(1.runtime 2.断点)
    /**
     通过断点调试找到placeholderLabel属性，用kvc修换占位文字颜色
     如果单纯的使用kvc修改占位文字颜色，会产生bug
     如果先设置占位文字，在设置占位文字颜色会没有占位文字颜色，
     所以需要用runtime给textFild添加自定义的属性，然后添加交换方法
     */
    UILabel *placeholderLabel  = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    
}
-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
// 设置占位文字
// 设置占位文字颜色
- (void)setXc_Placeholder:(NSString *)placeholder
{
    [self setXc_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}
@end
```
- #### UICollectionViewliu流水布局在MeViewController的[self setupcollectionView];方法中，、
- #### tableView分组样式小问题


```
//  tableView分组样式，有额外头部和尾部的间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    //解决tableView分组样式往下走了一段距离问题
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
```

- ### button复习

	- ##### 1.UIControlStateNormal
    	- 1 除开UIControlStateHighlighted、UIControlStateDisabled、UIControlStateSelected以外的其他情况，都是normal状态
	    - 2 这种状态下的按钮【可以】接收点击事件
 
	- ##### 2.UIControlStateHighlighted
     	- 1 【当按住按钮不松开】或者【highlighted = YES】时就能达到这种状态
     	- 2 这种状态下的按钮【可以】接收点击事件
 
	- ##### 3.UIControlStateDisabled
    	 - 1 【button.enabled = NO】时就能达到这种状态
     	- 2 这种状态下的按钮【无法】接收点击事件
 
	- ##### 4.UIControlStateSelected
     	- 1 【button.selected = YES】时就能达到这种状态
     	- 2 这种状态下的按钮【可以】接收点击事件
- #### 让按钮无法点击的2种方法
    - ##### 1 button.enabled = NO;
 		- #####【会】进入UIControlStateDisabled状态
 
    - ##### 2 button.userInteractionEnabled = NO;
	   	- ##### 【不会】进入UIControlStateDisabled状态，继续保持当前状态
	   	
```
// 控件按钮内部子控件之间的间距
//    btn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

 ```
	   
- #### 特定构造方法
 - #####1 后面带有NS_DESIGNATED_INITIALIZER的方法，就是特定构造方法
 
 - #####2 子类如果重写了父类的【特定构造方法】，那么必须用super调用父类的【特定构造方法】，不然会出现警告
 
 - `tableView属性分析` 
 	- #### 什么是内容？内容包括什么？
 		- ##### 1.cell	 	- ##### 2.tableHeaderView\tableFooterView	 	- ##### 3.sectionHeader\sectionFooter	- #### contentSize.height : 所有内容的总高度	- #### contentInset : 在内容周围额外增加的间距（内边距），始终粘着内容	- #### contentOffset : 内容距离frame矩形框，偏移了多少	- #### frame : 是以父控件内容的左上角为坐标原点{0, 0}	- #### bounds : 是以自己内容的左上角为坐标原点{0, 0}	- #### 发送分页之类的网络请求如果遇到，公司借口分页数据要客户端像后台传每次不同的页码需要考虑如果请求失败追加的数据怎么操作
	```
	这种情况只能针对数据比较小的时候	 parameters[@"page"] = @(self.page +1);
    //请求成功后对操作
    self.page = [parameters [@"page"] integerValue];
    //或者在请求前对page++，但是失败后要对page--
    如果数据量大或者经常更新就要考虑，发送当前数据的最后一条，比如当前数据id是35请求新的数据就需要请求35以后所有的数据
	```
	- #### 解决上拉刷新下拉加载手势同时进行问题
	```
	第一种：
	解决这种问题最简单的方法就是定义一个BOOL属性，开始刷新的状态是YES，结束刷新为No,然后去判断状态如果正在上拉或下拉直接返回。这种方法最直接
	第二种：直接处理请求
	[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
	在请求完成后在失败的block中判断NSURLError的状态
	if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
	```
 - ####	`lineBreakMode` label超出范围的模式
 - #### 关于tableViewCell高度的问题
 ```
 /**
 这个方法特点：
  - 1.默认情况下(没有设置estimatedHeight)每次刷新表格时，这个方法就一次性调用多少次，每次reloadData时，这个方法就会调用
  - 2.每次有cell进入屏幕范围内，就会调用一次
 针对以上的特点思考：如果每次都要调用这个方法都要去计算cell的高度，这样写不严谨，所以就要考虑如果以前如果算过cell的高度，就直接返回
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}
/**
 估算高度的好处:用到哪个cell才会调用这个方法计算cell的高度,降低heightForRowAtIndexPath方法的调用频率
 缺点:滚动条的长度是假的，不稳定，甚至卡顿
 */
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
 ```
 - #### `__bridge`：在CoreFoundation与Foundation之间转换需要用`__bridge`桥接 比如 NSString * 和 CFStringRef
