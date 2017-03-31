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
    
    Stack *stack;
    Node *root;
    Node *unsequenceRoot;
    Node *bstRoot;
}

@end

@implementation BinaryTree

#pragma mark - Create Tree, UnSequences Tree, Binary Search Tree

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

- (void)createBinarySearchTree {
    
    bstRoot = [[Node alloc] init];
    bstRoot.data = 4;
    
    bstRoot.left = [Node new];
    bstRoot.left.data = 2;
    
    bstRoot.right = [Node new];
    bstRoot.right.data = 5;
    
    bstRoot.left.left = [Node new];
    bstRoot.left.left.data = 1;
    
    bstRoot.left.right = [Node new];
    bstRoot.left.right.data = 3;
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
    [self createBinarySearchTree];
    
    //Section 1
    NSLog(@"\nSection1.A. Preorder traversal");
    [self preOrderTraversal:root];
    
    NSLog(@"\nSection1.B. Post Order Traveral");
    [self postOrderTraversal:root];
    
    NSLog(@"\nSection1.C1. In Order Traveral");
    [self inOrderTraversal:root];
    
    NSLog(@"\nSection1.C2. In Order Traveral Using Stack");
    [self inOrderUsingStack:root];
    
    //Section 2
    NSLog(@"\nSection2.A Size of tree %d", [self calculateSizeOfTree:root]); // Size of left subtree + 1 + Size of right subtree
    
    NSLog(@"\nSection2.B Print Left View Binary Tree");
    [self printLeftViewOfBinaryTree:root];
    
    NSLog(@"\nSection2.C Find max in Binary Tree %d", [self findMaxInBinaryTree:unsequenceRoot]);
    
    //Section 3
    NSLog(@"\nSection3.A Find depth or height of Binary tree %d",[self calculateHeightOfBinaryTree:root]);
    
    NSLog(@"\nSection3.B Level Order Traversal or BFS");
    //TODO: Can be done using queue also. Practice after queue is done
    [self printLevelOrderForAllLevel:root];
    
    NSLog(@"\nSection4.A Check if two trees are identical");
    if ([self checkIfTwoTreeAreIdentical:root andSecondTree:unsequenceRoot]) {
        NSLog(@"Trees are identical");
    } else {
        NSLog(@"Trees are not identical");
    }
    
    NSLog(@"\nSection4.B Delete a tree")
    [self deleteTree:root];
    
    NSLog(@"\nSection4.C Create Mirror Tree");
    //To test this, Print inorder before and after in binary search tree
    [self createMirrorTree:bstRoot];

}

#pragma mark - Section4 - Identical, Mirror image

- (BOOL)checkIfTwoTreeAreIdentical:(Node *)node1 andSecondTree:(Node *)node2 {
    
    if (!node1 && !node2) {
        
        return YES;
    }
    if (node1 && node2) {
        
        /*
        if (node1.data == node2.data) {
            [self checkIfTwoTreeAreIdentical:node1.left andSecondTree:node2.left];
            [self checkIfTwoTreeAreIdentical:node1.right andSecondTree:node2.right];
        } else {
            
            return NO;
        }
         */
        
        return (node1.data == node2.data &&
                [self checkIfTwoTreeAreIdentical:node1.left andSecondTree:node2.left] &&
                [self checkIfTwoTreeAreIdentical:node1.right andSecondTree:node2.right]);
    }
    return YES;
}

- (void)deleteTree:(Node *)node {
    
    /* Use post order approach
     1. Delete child first before deleting parent
     2. No extra space complexity
     */
    
    if (!node) {
        return;
    }
    [self deleteTree:node.left];
    [self deleteTree:node.right];
    NSLog(@"Deleting node: %d",node.data);
    node = nil;
}

- (void)createMirrorTree:(Node *)node {
    
    if (!node) {
        return;
    }
    
    [self createMirrorTree:node.left];
    [self createMirrorTree:node.right];
    
    Node *temp = node.left;
    node.left = node.right;
    node.right = temp;
}

#pragma mark - Section3 - Level Order or BFS Traversal

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

- (void)printLevelOrderForAllLevel:(Node *)node {
    
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

#pragma mark - Section2 - Size, maximum, minimum, print left view

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

#pragma mark - Section1 - Depth First Search (DFS) Tree Traversal

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

- (void)inOrderUsingStack:(Node *)node {
    
    NSMutableArray *stackArr = [NSMutableArray array];
    Node *current = node;
    [stackArr addObject:node];
    
    while (stackArr.count) {
        
        current = current.left;
        
        while (current) {
            
            [stackArr addObject:current];
            current = current.left;
        }
        
        current = [stackArr lastObject];
        [stackArr removeLastObject];
        NSLog(@"%d",current.data);
        
        
        current = current.right;
        if (current) {
            [stackArr addObject:current];
        }
        
    }
}


@end
