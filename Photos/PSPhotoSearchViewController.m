//
//  PSPhotoSearchViewController.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhotoSearchViewController.h"
#import "PSPhotoGridViewController.h"

#import <ObjectiveSugar/ObjectiveSugar.h>

@interface PSPhotoSearchViewController () <UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic, readonly) NSString *searchString;

@property (strong, nonatomic) NSMutableArray *searchHistory;
@property (strong, nonatomic) NSArray *filteredSearchHistory;

@property (strong, nonatomic) UIBarButtonItem *goBarButtonItem;

@end

@implementation PSPhotoSearchViewController

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithNibName:NSStringFromClass([PSPhotoSearchViewController class])
                          bundle:nil];
}

#pragma mark - Accessors / Mutators

- (NSMutableArray *)searchHistory {
    return _searchHistory ?: (self.searchHistory = [NSMutableArray new]);
}

- (NSString *)searchString {
    return self.searchBar.text;
}

- (NSString *)textAtIndexPath:(NSIndexPath *)indexPath {
    return self.filteredSearchHistory[indexPath.row];
}

- (NSArray *)filteredSearchHistory {
    return _filteredSearchHistory ?: self.searchHistory;
}

- (UIBarButtonItem *)goBarButtonItem {
    return _goBarButtonItem
        ?: (self.goBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                 target:self
                                                                                 action:@selector(goButtonTapped:)]);
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCells];
    
    self.navigationItem.rightBarButtonItem = self.goBarButtonItem;
    
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0001f)];
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)registerCells {
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.goBarButtonItem.enabled = self.searchString.length > 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredSearchHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [self textAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self textAtIndexPath:indexPath];
    
    self.searchBar.text = text;
    
    [self reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.goBarButtonItem.enabled = searchText.length > 0;

    [self reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self goButtonTapped:nil];
}

#pragma mark - Reload Data

- (void)reloadData {
    [self reloadDataSource];
    
    [self.tableView reloadData];
}

- (void)reloadDataSource {
    NSArray *words = [[self.searchString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
                      select:^BOOL(NSString *word) {
                          return word.length > 0;
                      }];
    
    if (words.count) {
        NSArray *predicates = [words map:^NSPredicate *(NSString *word) {
            return [NSPredicate predicateWithFormat:@"self contains[c] %@", word];
        }];
        
        NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
        
        self.filteredSearchHistory = [self.searchHistory filteredArrayUsingPredicate:predicate];
    }
    else {
        self.filteredSearchHistory = nil;
    }
}

#pragma mark - Button Actions

- (void)goButtonTapped:(id)sender {
    if (![self.searchHistory containsObject:self.searchString]) {
        [self.searchHistory addObject:self.searchString];
    }
    
    PSPhotoGridViewController *photoGridVC = [PSPhotoGridViewController new];
    photoGridVC.title = self.searchString;
    photoGridVC.searchString = self.searchString;
    
    [self.navigationController pushViewController:photoGridVC
                                         animated:YES];
}

@end
