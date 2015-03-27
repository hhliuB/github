//
//  OAuth2ViewController.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/24.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "OAuth2ViewController.h"

#import "AFNetworking.h"
#import "RootViewController.h"

@interface OAuth2ViewController ()
<UIWebViewDelegate>

@end

@implementation OAuth2ViewController

- (void)viewDidLoad
{
//  [super viewDidLoad];
  // 创建UIWebView
  UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
  
  // 加载登陆页面
  NSURL *url = [NSURL URLWithString:@"https://openapi.youku.com/v2/oauth2/authorize?client_id=e0d3d0729883df01&response_type=code&redirect_uri=http://www.baidu.com"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [webView loadRequest:request];
  
  [self.view addSubview:webView];
  
  // 设置代理
  webView.delegate = self;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
// 开始请求
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  // 请求结束
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   // 请求失败
}

// UIWebView没当发送一个请求之前都会调用这个代理（询问允不允许加载此请求）
// YES 允许 NO 不允许

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  // 获取请求地址
  NSString *url = request.URL.absoluteString;
   // 判断URL是否为回调地址
  NSRange range = [url rangeOfString:@"http://www.baidu.com/?code="];
  
  // 是回调地址
  if (range.location != NSNotFound) {
    
    // 截取授权成功后的请求标记
    NSRange downRange = [url rangeOfString:@"&state="];
    
    NSRange relRange;
    relRange.location = range.length;
    relRange.length   = downRange.location - range.length;
    
    NSString *code = [url substringWithRange:relRange];
    
    // 根据code获得一个accessToken
    [self accessTokenWithCode:code];
    
    // 禁止加载回调页面
    return NO;
  }
 
  
  return YES;
}

// 根据code获得一个accessToken （发送一个post请求）
// 授权成功后的请求标记

- (void)accessTokenWithCode:(NSString *)code
{
  // 获得请求管理者
  AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//  mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
  
  // 封装请求参数
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
//  client_id： e0d3d0729883df01 client_secret： f83b14c9cc904643c1510789c534d3b7
  
  params[@"client_id"] = @"e0d3d0729883df01";
  params[@"client_secret"] = @"f83b14c9cc904643c1510789c534d3b7";
  params[@"grant_type"] = @"authorization_code";
  params[@"code"] = code;
  params[@"redirect_uri"] = @"http://www.baidu.com";
  
// client_id	string	true	 	应用Key 
//  client_secret	string	true	 	应用Secret
//  grant_type	string	true	 	授权码方式: authorization_code	authorization_code
//  code	string	true	 	用户授权码，用于交换Access Token
//  redirect_uri	string	true	 	授权跳转地址，必须和应用设置的跳转地址相匹配
  
  
  [mgr POST:@"https://openapi.youku.com/v2/oauth2/token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
    // 授权成功
    // 存储账号信息
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"account.plist"];
    [responseObject writeToFile:filePath atomically:YES];
    NSLog(@"%@",responseObject);
    // 切换控制器
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    RootViewController *rootViewController = [[RootViewController alloc]init];
    window.rootViewController = rootViewController;
    [rootViewController enter];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"请求失败--%@",error);
  }];
  
//  {
//  用来调用其他已授权的API接口的凭证
//    "access_token" = 026623ad9d07ef1f763dc096b02c1164;
//  addess_token的有效时长 ，单位：秒
//    "expires_in" = 2592000;
//  刷新Token，用于获取新的access_token
//    "refresh_token" = 342913003c7e1d8850c98255186e45a8;
//  使用access_token访问资源的方式
//    "token_type" = bearer;
//    
//  }
  
}
@end
