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
    NSArray  *list;
    
    int             step;
    int             totalSteps;
    
    UILabel         *labelWins;
    UILabel         *labelLost;

    int wins;
    int lose;
}

@property (nonatomic, retain) IBOutlet UITableView      *myTableView;
@property (nonatomic, retain) NSArray                   *list;

@property (nonatomic, assign) int                       step;
@property (nonatomic, assign) int                       totalSteps;

@property (nonatomic, retain) IBOutlet UILabel         *labelWins;
@property (nonatomic, retain) IBOutlet UILabel         *labelLost;

@property (nonatomic, assign) int wins;
@property (nonatomic, assign) int lose;
@end
