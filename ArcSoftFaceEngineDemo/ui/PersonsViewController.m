//
//  PersonsViewController.m
//  ArcSoftFaceEngineDemo
//
//  Created by smarfid on 2018/11/12.
//  Copyright © 2018 ArcSoft. All rights reserved.
//

#import "PersonsViewController.h"
#import "ASFRManager.h"

@interface PersonsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ASFRManager *frManager;
@property (strong, nonatomic) NSMutableArray <ASFRPerson *>*persons;

@end

@implementation PersonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.frManager = [[ASFRManager alloc] init];
    self.persons = [self.frManager.allPersons mutableCopy];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"uitableviewcell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:NULL];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASFRPerson *person = self.persons[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uitableviewcell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"id:%lu----name:%@----data length:%lu", (unsigned long)person.Id, person.name, (unsigned long)person.faceFeatureData.length];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.frManager deletePerson:(int)self.persons[indexPath.row].Id];
        [self.persons removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
