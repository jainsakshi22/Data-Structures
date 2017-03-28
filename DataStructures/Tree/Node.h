//
//  Node.h
//  DataStructures
//
//  Created by Sakshi Jain on 28/03/17.
//  Copyright © 2017 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) int data;

@end
