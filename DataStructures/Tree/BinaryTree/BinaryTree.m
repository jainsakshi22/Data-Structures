//
//  BinaryTree.m
//  DataStructures
//
//  Created by Sakshi Jain on 28/03/17.
//  Copyright © 2017 personal. All rights reserved.
//

#import "BinaryTree.h"
#import "Node.h"

//disable timestamps in console
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface BinaryTree() {
    
    Node *root;
}

@end

@implementation BinaryTree

- (void)createBinaryTree {
    
    root = [[Node alloc] init];
    root.data = 1;
    
    root.left = [Node new];
    root.left.data = 2;
    
    root.right = [Node new];
    root.right.data = 3;
    
    root.left.left = [Node new];
    root.left.left.data = 4;
    
    root.left.right = [Node new];
    root.left.right.data = 5;
}

- (void)performVariousOperations {
    
    [self createBinaryTree];
    
    NSLog(@"\nA. Preorder traversal");
    [self preOrderTraversal:root];
    
    NSLog(@"\nB. Post Order Traveral");
    [self postOrderTraversal:root];
    
    NSLog(@"\nC. In Order Traveral");
    [self inOrderTraversal:root];
    
}

#pragma mark - Tree Traversal

- (void)preOrderTraversal:(Node *)node {
    
    if (!node) {
        
        return;
    }
    NSLog(@"%d",node.data);
    [self preOrderTraversal:node.left];
    [self preOrderTraversal:node.right];
}

- (void)postOrderTraversal:(Node *)node {
    
    if (!node) {
        return;
    }
    [self postOrderTraversal:node.left];
    [self postOrderTraversal:node.right];
    NSLog(@"%d",node.data);
}

- (void)inOrderTraversal:(Node *)node {
    
    if (!node) {
        return;
    }
    [self inOrderTraversal:node.left];
    NSLog(@"%d",node.data);
    [self inOrderTraversal:node.right];
}

@end
