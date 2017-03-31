//
//  Stack.h
//  DataStructures
//
//  Created by Sakshi Jain on 31/03/17.
//  Copyright © 2017 personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Stack : NSObject

@property (nonatomic, strong) Node *tree; //pointer to tree node
@property (nonatomic, strong) Stack *next; //pointer to next stack node

@end
