# Abstract Data Types

## Dynamic Array

Method | Time Complexity | Notes
---      | ------------- |------
```[]()```     | O(1)      |
```shift()/unshift()```| O(n) | ```resize!``` if ```length``` > ```capacity```
```push()/pop()``` | O(1), amortized | ```resize!``` if ```length``` > ```capacity```
```insert_at()/delete_at()``` | O(n) | ```resize!``` if ```length``` > ```capacity```

## Linked List 

Method | Time Complexity | Notes
---      | ------------- |---------
```[]()```     | O(n)      |
```shift()/unshift()```| O(1) |
```push()/pop()``` | O(1) when the last element is known, otherwise O(n) |
```insert_at()/delete_at()``` | O(1) + search time


## Binary Search Tree
### *assumes tree is already sorted
Method | Time Complexity | Notes
---      | ------------- | ---------
```find(target, node)```     | O(log(n))      | Pick middle. If mid == target, return node. if mid > target, ```find(target, left)```, else ```find(target, right)```
```insert(val, root)```| O(log(n)) |
```max()``` | O(n) 
```min()```| O(n) |
```delete()``` | O(log(n)) | if no children, delete node. if one child, remove node and replace with child. if deleting a node with two children: call the node to be deleted D. Do not delete D. Instead, choose either its in-order predecessor node or its in-order successor node as replacement node E (s. figure). Copy the user values of E to D.[note 2] If E does not have a child simply remove E from its previous parent G. If E has a child, say F, it is a right child. Replace E with F at E's parent.