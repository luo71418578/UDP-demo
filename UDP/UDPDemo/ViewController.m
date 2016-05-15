//
//  ViewController.m
//  UDPDemo
//
//  Created by qianfeng on 14-2-13.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	_ipField.delegate=self;
   _sendField.delegate=self;
   
   //发送端
   _sendSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
   //和端口进行绑定
   [_sendSocket bindToPort:5000 error:nil];
   
   //接收端
   _recvSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
   [_recvSocket bindToPort:6000 error:nil];
   
   //监听有没有消息发送，这只超时，如果timeout为负数，则永远不超时 
   [_recvSocket receiveWithTimeout:-1 tag:0];
}

//监听到了有消息发送
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    
    NSLog(@"接收成功！！！");
   //接收到的数据转成字符串
   NSString* str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
   _textView.text = [NSString stringWithFormat:@"%@\n%@:%@\n",_textView.text,host,str];
   
   //继续监听
   [_recvSocket receiveWithTimeout:-1 tag:0];
   
   return YES;
}

//发送数据成功
-(void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"发送数据成功!");
}


//发送端
-(void)send:(id)sender
{
   //字符串转成数据
   NSData* data = [_sendField.text dataUsingEncoding:NSUTF8StringEncoding];
   
   //发送
   [_sendSocket sendData:data toHost:_ipField.text port:6000 withTimeout:30 tag:0];
   
   _textView.text = [NSString stringWithFormat:@"我说:%@",_sendField.text];
   _sendField.text = @"发送完毕";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
   return YES;
}

- (void)dealloc {
   [_ipField release];
   [_sendField release];
   [_textView release];
   [super dealloc];
}


@end
