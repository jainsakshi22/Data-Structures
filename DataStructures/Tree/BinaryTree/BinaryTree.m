//
//  BinaryTree.m
//  DataStructures
//
//  Created by Sakshi Jain on 28/03/17.
//  Copyright © 2017 personal. All rights reserved.
//

#import "BinaryTree.h"
#import "Node.h"
#import "Stack.h"

//disable timestamps in console
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface BinaryTree() {
    
    Node *root;
    Stack *stack;
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
    
    root.left.left = [Node new];
    root.left.left.data = 4;
    
    root.left.right = [Node new];
    root.left.right.data = 5;
    
    root.right.left = [Node new];
    root.right.left.data = 6;
    
    root.right.left.left = [Node new];
    root.right.left.left.data = 7;
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
    
    //Section 1
    NSLog(@"\nSection1.A. Preorder traversal");
    [self preOrderTraversal:root];
    
    NSLog(@"\nSection1.B. Post Order Traveral");
    [self postOrderTraversal:root];
    
    NSLog(@"\nSection1.C. In Order Traveral");
    [self inOrderTraversal:root];
    
    //Section 2
    NSLog(@"\nSection2.A Size of tree %d", [self calculateSizeOfTree:root]); // Size of left subtree + 1 + Size of right subtree
    
    NSLog(@"\nSection2.B Print Left View Binary Tree");
    [self printLeftViewOfBinaryTree:root];
    
    NSLog(@"\nSection2.C Find max in Binary Tree %d", [self findMaxInBinaryTree:unsequenceRoot]);
    
    //Section 3
    NSLog(@"\nSection3.A Find depth or height of Binary tree %d",[self calculateHeightOfBinaryTree:root]);
    
    NSLog(@"\nSection3.B Level Order Traversal or BFS");
    [self printLevelOrderForAllLevel:root];
    //TODO: Can be done using queue also. Practice after queue is done
    
}

#pragma mark - Level Order or BFS Traversal

- (void)printLevelOrderForGivenLevel:(Node *)node andLevel:(int)level {
    
    if (!node) {
        return;
    }
    if (level == 1) {
        NSLog(@"%d",node.data);
    } else {
        
        [self printLevelOrderForGivenLevel:node.left andLevel:level-1];
        [self printLevelOrderForGivenLevel:node.right andLevel:level-1];
    }
}

-(void)printLevelOrderForAllLevel:(Node *)node {
    
    //To print all level order, print all nodes from level 1 to height of tree
    if (!node) {
        return;
    }
    for (int i = 1;i <= [self calculateHeightOfBinaryTree:node] ; i++) {
        [self printLevelOrderForGivenLevel:node andLevel:i];
    }
}

- (int)calculateHeightOfBinaryTree:(Node *)node {
    
    if (!node) {
        return 0;
    }
    int lDepth = [self calculateHeightOfBinaryTree:node.left];
    int rDepth = [self calculateHeightOfBinaryTree:node.right];
    if (lDepth > rDepth) {
        return lDepth + 1;
    }
    return rDepth + 1;
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
