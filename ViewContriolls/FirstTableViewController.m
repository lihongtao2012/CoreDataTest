//
//  FirstTableViewController.m
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-6.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import "FirstTableViewController.h"
#import "SecondViewController.h"
#import "Department.h"

@interface FirstTableViewController ()

{
    NSMutableArray *dataArray;
    NSManagedObjectContext * mangedObjectContext;
    IBOutlet UITextField *nameTF;
    IBOutlet UITextField *idCardTF;
}
@end

@implementation FirstTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mangedObjectContext= ((AppDelegate *) ([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Employee" inManagedObjectContext:mangedObjectContext];
    request.entity=entity;
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"(department.name = %@) AND (name LIKE[cd] 'pen?')",@"miaolianwangios"];
    request.predicate=predicate;
    
    NSArray *arr=[mangedObjectContext executeFetchRequest:request error:nil];
    
    NSLog(@" arrr  %@",arr);
    

    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Department"];
    NSArray *fetchArray= [mangedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    dataArray=[NSMutableArray arrayWithArray:fetchArray];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
- (IBAction)addRightItem:(id)sender {
    
    UIView *addView=  [[NSBundle mainBundle]loadNibNamed:@"addView" owner:self options:nil][0];
    addView.frame=self.view.window.frame;
    [self.view.window addSubview:addView];

}

/**
 *  完成;
 */
- (IBAction)complete:(id)sender {
    
      Department *mangedObject=[NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:mangedObjectContext];
    mangedObject.name=nameTF.text;
    mangedObject.idCard=idCardTF.text;
    
    [dataArray addObject:mangedObject]; //数据源添加好.
    [mangedObjectContext save:nil];
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:dataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    
    [[self.view.window.subviews lastObject] removeFromSuperview];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
   Department *managedObject= dataArray[indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"部门名称: %@",managedObject.name];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"部门id: %@",managedObject.idCard];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [mangedObjectContext deleteObject:dataArray[indexPath.row]];
        [mangedObjectContext save:nil];
        [dataArray removeObjectAtIndex:indexPath.row];
    
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];  //涮新UI界面 ;
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    UITableViewCell *cell= sender;
   NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
   SecondViewController *secondeVC= segue.destinationViewController;
    secondeVC.managedObject = dataArray[indexPath.row];
    secondeVC.managedObjectContext=mangedObjectContext;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
