//
//  PlaceRecommend.h
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceRecommend : UIViewController<UIWebViewDelegate>
{
    UIWebView * mWebView;
    UIAlertView * mAlertView;
    UIView * mOpaqueview;
    UIActivityIndicatorView * mActivityIndicator;
}
@end
