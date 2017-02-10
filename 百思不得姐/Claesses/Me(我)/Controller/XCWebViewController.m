//
//  XCWebViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/19.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCWebViewController.h"
#import <WebKit/WebKit.h>
@interface XCWebViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,weak)WKWebView  * webView ;
@end

@implementation XCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = ({
        WKWebView *webView = [[WKWebView alloc]init];
        self.webView = webView;
        [self.contentView addSubview:webView];
        [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        //监听进度条
        [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        webView;
    
    });
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
};
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.contentView.bounds;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.goBackButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    //判断进度条加载完成后隐藏
    self.progressView.hidden = self.webView.estimatedProgress >=1;
}
-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}
- (IBAction)forward:(id)sender
{
    [self.webView goForward];
}
- (IBAction)goBack:(id)sender
{
     [self.webView goBack];
}
- (IBAction)reload:(id)sender
{
     [self.webView reload];
}

@end
