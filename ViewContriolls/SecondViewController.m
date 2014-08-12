//
//  SecondViewController.m
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-6.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import "SecondViewController.h"
#import "secondCell.h"
#import "Employee.h"
@interface SecondViewController ()
{
    NSMutableArray *dataArray;
    IBOutlet UITextField *toolTF;
    IBOutlet UITextField *nameTF;
    IBOutlet UITextView *loveTF;
    IBOutlet UITextField *employeeID;

    
}
@end


@implementation SecondViewController

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

    self.navigationItem.title=@"员工名字";
    NSSet *set= _managedObject.employee;
    dataArray=[NSMutableArray arrayWithArray:[set allObjects]];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self.tools = '1'"];
    NSArray *arr= [dataArray filteredArrayUsingPredicate:predicate];
    
    NSLog(@" arr  %@  ",arr);
    
    
//    NSString *regex = @"^A.+e$";//以A 开头，以e 结尾的字符。
//    NSPredicate *pre= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if([pre evaluateWithObject: @"Apple"]){
//        NSLog(@"YES");
//    }else{
//        NSLog(@"NO");
//    }
//    
    [self.tableView reloadData];
    
}

- (IBAction)addEmployee:(id)sender {
    
    UIView *addView=  [[NSBundle mainBundle]loadNibNamed:@"addView2" owner:self options:nil][0];
    addView.frame=self.view.window.frame;
    [self.view.window addSubview:addView];
    
}
- (IBAction)complete:(id)sender {
    
    Employee *employeeObject=[NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_managedObjectContext];
    employeeObject.name=nameTF.text;
    employeeObject.tools=toolTF.text;
    employeeObject.love=loveTF.text;
    employeeObject.employeeNumber=employeeID.text;
    employeeObject.department=_managedObject;
    [dataArray addObject:employeeObject];
    [_managedObjectContext save:nil];
    
    [self.tableView  insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:dataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    secondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    Employee *managedObject=dataArray[indexPath.row];

    cell.cellNameLabel.text=managedObject.name ;
    cell.cellNumberDepartNumber.text=_managedObject.name;
    cell.cellNumberLabel.text=managedObject.employeeNumber;
    cell.cellToolLabel.text=managedObject.tools;
    cell.cellLoveLabel.text=managedObject.love;
    
    return cell;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
       [_managedObjectContext deleteObject:dataArray[indexPath.row]];
        [_managedObjectContext save:nil];
       [dataArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];  //涮新UI界面 ;
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Employee *employee=dataArray[indexPath.row];
    employee.employeeNumber=[NSString stringWithFormat:@"%.f",[employee.employeeNumber floatValue ]+1000000];
   BOOL isSave= [_managedObjectContext save:nil]; //本地处理
    
    [dataArray removeObjectAtIndex:indexPath.row];
    [dataArray insertObject:employee atIndex:indexPath.row];//处理数据源;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; //刷新UI
    
    
    if (isSave) {
       UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"" message:@"成功save" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    

    
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void)dealloc
{
}

@end
