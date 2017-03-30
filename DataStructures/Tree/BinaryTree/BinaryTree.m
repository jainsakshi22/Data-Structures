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
    Node *unsequenceRoot;
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
    
    root.right.left = [Node new];
    root.right.left.data = 6;
    
    root.right.left.left = [Node new];
    root.right.left.left.data = 7;
    
    root.left.left = [Node new];
    root.left.left.data = 4;
    
    root.left.right = [Node new];
    root.left.right.data = 5;
    
}

- (void)createUnsequenceBinaryTree {
    
    unsequenceRoot = [[Node alloc] init];
    unsequenceRoot.data = 2;
    
    unsequenceRoot.left = [Node new];
    unsequenceRoot.left.data = 7;
    
    unsequenceRoot.left.right = [Node new];
    unsequenceRoot.left.right.data = 6;
    
    unsequenceRoot.left.right.left = [Node new];
    unsequenceRoot.left.right.left.data = 1;

    unsequenceRoot.left.right.right = [Node new];
    unsequenceRoot.left.right.right.data = 11;
    
    unsequenceRoot.right = [Node new];
    unsequenceRoot.right.data = 5;
    
    unsequenceRoot.right.right = [Node new];
    unsequenceRoot.right.right.data = 9;
    
    unsequenceRoot.right.right.left = [Node new];
    unsequenceRoot.right.right.left.data = 4;
    
}

- (void)performVariousOperations {
    
    [self createBinaryTree];
    [self createUnsequenceBinaryTree];
    
    NSLog(@"\nA. Preorder traversal");
    [self preOrderTraversal:root];
    
    NSLog(@"\nB. Post Order Traveral");
    [self postOrderTraversal:root];
    
    NSLog(@"\nC. In Order Traveral");
    [self inOrderTraversal:root];
    
    NSLog(@"\nD Size of tree %d", [self calculateSizeOfTree:root]); // Size of left subtree + 1 + Size of right subtree
    
    NSLog(@"\nE Print Left View Binary Tree");
    [self printLeftViewOfBinaryTree:root];
    
    NSLog(@"\nF Find max in Binary Tree %d", [self findMaxInBinaryTree:unsequenceRoot]);
    
}

#pragma mark - Size, maximum, minimum, print left view

- (int)calculateSizeOfTree:(Node *)node {
    
    if (!node) {
        return 0;
    }
    return [self calculateSizeOfTree:node.left] + 1 + [self calculateSizeOfTree:node.right];;
}

- (void)printLeftViewOfBinaryTree:(Node *)node {
    
    int maxLevel = 0;
    [self printLeftViewOfBinaryTree:node withLevel:1 andMaxLavel:&maxLevel];
}

- (void)printLeftViewOfBinaryTree:(Node *)node withLevel:(int)level andMaxLavel:(int *)maxLevel {
    
    if (!node) {
        return;
    }
    if (*maxLevel < level) {
        
        NSLog(@"%d",node.data);
        *maxLevel = level;
    }
    [self printLeftViewOfBinaryTree:node.left withLevel:level+1 andMaxLavel:maxLevel];
    [self printLeftViewOfBinaryTree:node.right withLevel:level+1 andMaxLavel:maxLevel];
}

- (int)findMaxInBinaryTree:(Node *)node {
    
    if (!node) {
        return CGFLOAT_MIN;
    }
    int res = node.data;
    int lRes = [self findMaxInBinaryTree:node.left];
    int rRes = [self findMaxInBinaryTree:node.right];
    
    if (lRes > res) {
        
        res = lRes;
    } else if (rRes > res) {
        
        res = rRes;
    }
    return res;
}

#pragma mark - Depth First Search (DFS) Tree Traversal

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
