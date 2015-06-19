//
//  ViewController.m
//  Xml
//
//  Created by MAEDA HAJIME on 2015/06/19.
//  Copyright (c) 2015年 HAJIME MAEDA. All rights reserved.
//

#import "ViewController.h"

// 接続
@interface ViewController () <NSXMLParserDelegate> {
    
    // XMLパーサー オブジェクト
    NSXMLParser *_prs; // 解析するもの
    
    // 解析中の要素名
    NSMutableString *_nowElm;
}

@property (weak, nonatomic) IBOutlet UITextView *teString;

@end

// 実装
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

// [読込]ボタンを押した時
- (IBAction)readXml:(id)sender {
    
    self.teString.text = nil;
    
    // 対象ファイルの読込
    NSBundle *bnd = [NSBundle mainBundle];
    NSString *pth = [bnd pathForResource:@"test"
                                  ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:pth];
    
    // XMLパーサー生成
    _prs = [[NSXMLParser alloc] initWithContentsOfURL:url ];
    
    // 設定（デリゲート）
    _prs.delegate = self;
    
    // 解析開始
    [_prs parse];
    
}

#pragma mark - NSXMLParserDelegate Method

// 要素の解析開始後（上から読んでいる）
- (void)     parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qName
         attributes:(NSDictionary *)attributeDict {

    // スタート
    //NSLog(@"start：%@", elementName);
    
    // 解析中の要素名の保持
    _nowElm = [NSMutableString stringWithString:elementName];
    
    // 解析中の要素名の判定
    if ([_nowElm isEqualToString:@"item"]) {

        // 属性値の取得
        NSLog(@"属性（価格）：%@", attributeDict[@"price"]);
        self.teString.text = [self.teString.text
                    stringByAppendingFormat:@"属性（価格）：%@\n", attributeDict[@"price"]];
        NSLog(@"属性（kcal）：%@", attributeDict[@"kcal"]);
        self.teString.text = [self.teString.text
                              stringByAppendingFormat:@"属性（kcal）：%@\n", attributeDict[@"kcal"]];
        
    }
    
}

// 要素の解析終了後（上から読んでいる）
- (void) parser:(NSXMLParser *)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName {
    
    // エンド
    //NSLog(@"end：%@", elementName);
    
    // 解析中の要素名の保持解除
    _nowElm = [NSMutableString string];

}

// 要素値の発見時
- (void) parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    
    // 解析中の要素名の判定
    if ([_nowElm isEqualToString:@"item"]) {
        NSLog(@"　　　要素値：%@", string);
        self.teString.text = [self.teString.text
                              stringByAppendingFormat:@"　　　要素値：%@\n", string];
    }
}

@end
