//
//  ViewController.m
//  TableViewScrollTestDemo
//
//  Created by 刘光军 on 15/11/20.
//  Copyright © 2015年 刘光军. All rights reserved.
//

#import "ViewController.h"

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ViewController
{
    UITableView *_tableView;
    NSArray *_arr;
    UIButton *_nextBtn;
    UIButton *_frontBtn;
    NSInteger _currentIndex;//当前的索引值
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
    [self configArr];
    [self configTableView];
//    _currentIndex = 0;
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 数组
- (void)configArr {
    _arr = @[@"我是第0行",@"我是第1行",@"我是第2行",@"我是第3行",@"我是第4行",@"我是第5行",@"我是第6行"];
}

#pragma mark - 导航栏
- (void)configNavigationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:234/255.0 green:100/255.0 blue:140/255.0 alpha:1];
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, 0, 70, 40);
    [_nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor colorWithRed:0.47f green:0.71f blue:0.15f alpha:1.0f] forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor colorWithRed:0.98f green:0.29f blue:0.32f alpha:1.0f] forState:UIControlStateDisabled];
    [_nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithCustomView:_nextBtn];
    
    _frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _frontBtn.frame = CGRectMake(0, 0, 70, 40);
    [_frontBtn setTitle:@"上一页" forState:UIControlStateNormal];
    _frontBtn.enabled = NO;
    [_frontBtn setTitleColor:[UIColor colorWithRed:0.47f green:0.71f blue:0.15f alpha:1.0f] forState:UIControlStateNormal];
    [_frontBtn setTitleColor:[UIColor colorWithRed:0.98f green:0.29f blue:0.32f alpha:1.0f] forState:UIControlStateDisabled];
    [_frontBtn addTarget:self action:@selector(frontClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *frontItem = [[UIBarButtonItem alloc] initWithCustomView:_frontBtn];
    self.navigationItem.rightBarButtonItems = @[nextItem, frontItem];
    
}

#pragma mark - tableview
- (void)configTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.pagingEnabled = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //2
    return HEIGHT-64;
}


#pragma mark - tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //1
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //3
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.text = [_arr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - 按钮点击事件
- (void)frontClick {
    /**< 上一条消息 */
    _nextBtn.enabled = YES;
    _currentIndex--;     //判断有没有上一条
    NSLog(@"currentIndex:%ld", (long)_currentIndex);
    if (_currentIndex >=  0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    } else {
        _currentIndex = 0;
        _frontBtn.enabled = NO;
    }
    
}

- (void)nextClick {
    /**< 下一条消息 */
    _frontBtn.enabled = YES;
    _currentIndex ++;       //判断有没有下一条
    NSLog(@"currentIndex:%ld", (long)_currentIndex);
    if (_currentIndex< _arr.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }    else {
        _nextBtn.enabled = NO;
        _currentIndex = _arr.count - 1;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
