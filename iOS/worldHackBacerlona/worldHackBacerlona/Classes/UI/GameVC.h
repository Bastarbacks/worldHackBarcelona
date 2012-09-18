//
//  GameVC.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView     *myTableView;
    NSMutableArray  *list;
}

@property (nonatomic, retain) IBOutlet UITableView      *myTableView;
@property (nonatomic, retain) NSMutableArray            *list;

@end
