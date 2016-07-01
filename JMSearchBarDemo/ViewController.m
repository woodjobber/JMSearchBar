//
//  ViewController.m
//  JMSearchBarDemo
//
//  Created by chengbin on 16/6/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "ViewController.h"
#import "JMSearchBar/JMSearchBar.h"
#import "JMTableView.h"

@interface ViewController ()<JMTableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarItem;

@property (strong, nonatomic) JMTableView *jmTableView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = [@[] mutableCopy];
    self.jmTableView = [[JMTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.jmTableView.delegate = self;
    self.jmTableView.dataSource = self;
    [self.view addSubview:self.jmTableView];
    for (int i = 1; i <= 20; i++) {
        [self.dataSource addObject:@(i)];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(test:) name:UITableViewSelectionDidChangeNotification object:nil];
}

- (void)test:(NSNotification *)noti {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"finished numberOfRowsInSection");
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] stringValue];
     NSLog(@"finished cellForRowAtIndexPath %@",indexPath);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
    
        NSLog(@"finished willDisplayCell");
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.jmTableView indexPathsForVisibleRows].firstObject.row == indexPath.row ) {
       NSLog(@"finished didEndDisplayingCell %@",indexPath); // 表示已经结束显示cell，即从table上移除 cell,且 移除的顺序是 从row 大到小。
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     NSLog(@"finished numberOfSectionsInTableView");
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"finished heightForRowAtIndexPath %@",indexPath);
    return 44.0f;
}

- (IBAction)searchClick:(id)sender {
//    [self.jmTableView beginOrEndUpdatesWithAnimations:^{
//        NSLog(@"begin or end Reload");
//    } completion:^{
//        NSLog(@"finished Reload");
//      
//    }];
   //[JMSearchBar showSearchBarInView:self.navigationController.navigationBar maskViewInView:self.view];
   [self.jmTableView reloadData];
   NSLog(@"%@", [self.jmTableView indexPathsForVisibleRows]);
    //[self.jmTableView selectRowAtIndexPath:[NSIndexPath indexPathWithIndex:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)jm_tableViewDidReloadData:(JMTableView *)tableView {
    NSLog(@"}Did Reload");
    
}

- (void)jm_tableViewWillReloadData:(JMTableView *)tableView {
    NSLog(@"Will Reload{");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
