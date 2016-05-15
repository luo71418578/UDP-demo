//
//  ViewController.h
//  UDPDemo
//
//  Created by qianfeng on 14-2-13.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncUdpSocket.h"
@interface ViewController : UIViewController
<AsyncUdpSocketDelegate,
UITextFieldDelegate>
{
   IBOutlet UITextField *_ipField;
   
   IBOutlet UITextField *_sendField;
   
   IBOutlet UITextView *_textView;
   AsyncUdpSocket *_sendSocket;
   AsyncUdpSocket *_recvSocket;
}

- (IBAction)send:(id)sender;



@end
