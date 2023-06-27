BST
In Average case for balanced BST, it takes O(logn) time for Insertion, Deletion and Searching.
n/2^k = 1
k steps = log2(n)
Reduce the problem in a self similar manner, in a recursive manner.
Any subtree in BST is BST
Property of each node: Nodes in left have smaller value than the node, nodes in right have larger value than the node.


Problems:
Search in a Binary Search Tree Easy
Insert into a Binary Search Tree
Minimum element in BST
Delete Node in a BST
Inorder successor in BST
Inorder Predecessor of Node in BST
Check if BT is BST
Construct BST from preorder traversal
Find LCA  of 2 nodes in a BST
Populate inorder successor of all nodes
Convert Binary tree into BST
BST Iterator implementation using Stack
Floor in BST
Ceil in BST
Convert a normal BST into a Balanced BST
merge two BST [ V.V.V>IMP ] 
Find Kth largest element in a BST
Find Kth smallest element in a BST
Count pairs from 2 BST whose sum is equal to given value "X" 
Find the median of BST in O(n) time and O(1) space
Count BST ndoes that lie in a given range
Replace every element with the least greater element on its right
Given "n" appointments, find the conflicting appointments
Check preorder is valid or not
Check whether BST contains Dead end
Largest BST in a Binary Tree [ V.V.V.V.V IMP ]
Flatten BST to sorted list







700. Search in a Binary Search Tree Easy. Tags: BST
public TreeNode searchBST(TreeNode root, int val) {
        if(root==null){
            return null;
        }
        if(root.val == val){
            return root;
        }else if(val<root.val){
            return searchBST(root.left, val);
        }else{
            return searchBST(root.right, val);
        } 
    }
701. Insert into a Binary Search Tree Medium. Tags: BST
Note no duplicates in tree. Value to be inserted is not present in BST.
Recursive solution. Standard solution
public TreeNode insertIntoBST(TreeNode root, int val) {
        if(root==null){
            return new TreeNode(val); //here left and right child are by default set to null
        }
        if(val<root.val){
            root.left = insertIntoBST(root.left, val);
        }else if(val>root.val){
            root.right = insertIntoBST(root.right, val);
        }
        return root;
    }
Iterative solution
public TreeNode insertIntoBST(TreeNode root, int val) {
        if(root==null){
            return new TreeNode(val); //here left and right child are by default set to null
        }
        TreeNode temp = root;
        while(true){
            if(val<temp.val){
                if(temp.left!=null){
                    temp = temp.left;
                }else{
                    temp.left = new TreeNode(val);
                    break;
                }
            }else if(val>temp.val){
                if(temp.right!=null){
                    temp=temp.right;
                }else{
                    temp.right = new TreeNode(val);
                    break;
                }
            }
        }
        return root;
    }

Minimum element in BST Basic. Tags: BST. GFG Problem. Not on LC
Recursive solution
int minValue(Node node){
        if(node==null)return -1; 
        if(node.left==null){
            return node.data;
        }
        return minValue(node.left);
    }
Iterative solution
int minValue(Node node) {
        if(node==null)return -1;
        while(node.left!=null){
            node=node.left;
        }
        return node.data;
    }
450. Delete Node in a BST Medium. Tags: BST
https://www.youtube.com/watch?v=gcULXE7ViZw&list=PL2_aWCzGMAwI3W_JlcBbtYTwiQSsOTa6P&index=36
class Solution {
    public TreeNode deleteNode(TreeNode root, int key) {
        if(root==null)return root;
        if(key<root.val){
            root.left = deleteNode(root.left, key);
        }else if(key>root.val){
            root.right = deleteNode(root.right, key);
        }else if(key == root.val){
            //case 1 Node to be deleted has 0 child
            if(root.left==null && root.right==null){
                root =null;
            }else if(root.left==null){
                //case 2 Node to be deleted has 1 child
                root = root.right;
            }else if(root.right == null){
                //case 2 Node to be deleted has 1 child
                root = root.left;
            }else{
                //case 3 Node to be deleted has 2 child
                //find minimum value node in right sub tree
                TreeNode minNode = findMin(root.right);
                root.val = minNode.val;
                root.right = deleteNode(root.right, minNode.val);  //imp step
            }
        }
        return root;
    }
    TreeNode findMin(TreeNode node){
        while(node.left!=null){
            node = node.left;
        }
        return node;
    }
    
}
Inorder Successor in BST Easy. Tags: BST. GFG Question. Not on LeetCode
https://www.youtube.com/watch?v=5cPbNCrdotA&list=PL2_aWCzGMAwI3W_JlcBbtYTwiQSsOTa6P&index=37
Current is the node whose inorder successor is to be found. Question would have been simple, had there been reference to parent node.
Inorder traversal of BST gives a sorted array. 
class Solution
{
    // returns the inorder successor of the Node x in BST (rooted at 'root')
	public Node inorderSuccessor(Node root,Node current){
	    //case 1 Node has right subtree. InorderSuccessor will be min element in right sub tree.
	    if(current.right!=null){
	        return findMin(current.right);   //O(h)
	    }
	    //case 2 No right subtree. InorderSuccessor is a node in current's lineage. current is not
	    //right child of this node. But this node has a left child which may be current. 
	    //Or right/left child of left child of this node may be current. Or similar others.
	    Node successor = null; 
	    Node ancestor = root;
	    while(ancestor!=current){
	        if(current.data<ancestor.data){
	            successor = ancestor;   //so far the deepest node for which the current node is in left
	            ancestor = ancestor.left;
	        }else{
	            ancestor=ancestor.right;
	        }
	    }
	    return successor;
	    
	}
	Node findMin(Node node){
	    while(node.left!=null){
	        node=node.left;
	    }
	    return node;
	}
	
}
Using Inorder traversal. Create a new Node. Find first node where value of node would be greater than current node’s value. Once you reach that node, set the left of that node to that node. Because during inorder traversal, we will find the just greater node. These bold step are peculiar. See if you see this pattern again. If we pass node object, then changes are reflected in it in recursion calls. That’s what we want.
public Node inorderSuccessor(Node root,Node current){
	    Node succ = new Node(0);
        inOrderTraversal(root, current, succ);
        return succ.left;
	}
	void inOrderTraversal(Node root, Node current, Node succ) {
        if (root == null) {
          return;
        }
     
        inOrderTraversal(root.left, current, succ);
        if (root.data > current.data && succ.left == null) {
          succ.left = root;
          return;
        }
        inOrderTraversal(root.right, current, succ);
  }

Inorder Predecessor of Node in BST. Tags: BST. WorkATTech Question. Not on LeetCode or GFG
Reverse of the above question. 
Recursive solution.
Node findPredecessor(Node root, Node current) {
	    if(current.left!=null){
	        return findMax(current.left);   //O(h)
	    }
		Node predecessor=null;
		Node ancestor = root;
		while(ancestor!=current){
			if(current.data<ancestor.data){
				ancestor = ancestor.left;
			}else{
				predecessor = ancestor;
				ancestor = ancestor.right;
			}
		}
		return predecessor;
	}
	Node findMax(Node node){
		while(node.right!=null){
			node=node.right;
		}
		return node;
	}

 	
98. Validate Binary Search Tree Medium(Check if a tree is a BST or not). Tags: BST.LeetCode problem
My implementation. Time complexity = O(). it traverses over some parts of the tree many times.
public boolean isValidBST(TreeNode root) {
        if(root==null)return true;
        if(findMin(root.right, root.val) && findMax(root.left, root.val) && isValidBST(root.left)&&isValidBST(root.right)){
            return true;   
        }
        return false;
    }
    boolean findMin(TreeNode node, int rootValue){
        if(node==null){
            return true;
        }
         while(node.left!=null){
             node=node.left;
         }
        return node.val>rootValue;
    }
    boolean findMax(TreeNode node, int rootValue){
        if(node==null){
            return true;
        }
         while(node.right!=null){
             node=node.right;
         }
        return node.val<rootValue;
    }
Using range as  Long.MAX_VALUE, Long.MIN_VALUE. Using Integer.MIN_VALUE, Integer.MAX_VALUE leads to failing of 1 test case. 
public boolean isValidBST(TreeNode root) {
        return isValidBSTUtil(root, Long.MIN_VALUE, Long.MAX_VALUE);
    }
    boolean isValidBSTUtil(TreeNode root, long min, long max){
        if(root==null)return true;
        if(root.val>=max || root.val<=min)return false;  
        return isValidBSTUtil(root.left, min, root.val) && isValidBSTUtil(root.right, root.val, max);
    } 
Using min and max as null values
public boolean isValidBST(TreeNode root) {
        return isValidBSTUtil(root, null, null);
    }
    boolean isValidBSTUtil(TreeNode root, TreeNode min, TreeNode max){
        if(root==null)return true;
        if ((min != null && root.val <= min.val) || (max != null && root.val >= max.val)){
            return false;
        }
        return isValidBSTUtil(root.left, min, root) && isValidBSTUtil(root.right, root, max);
    }
Using Recursive Inorder Traversal. Prev Node variable.
Basic intuition behind this approach is that inorder traversal of BST gives sorted array. So we keep one TreeNode reference to prev Node and at each node, we compare value of prev Node and Current node(root). If at any time prev.val>root.val, we return false. Always assign prev to current node(root) after this check.
class Solution {
    TreeNode prev;
    public boolean isValidBST(TreeNode root) {
        if (root == null)
            return true;
        if(isValidBST(root.left)==false)
            return false;
        if (prev != null && prev.val >= root.val)
            return false;
        prev = root;
        if (isValidBST(root.right)==false)
            return false;
        return true;
    }
}
Using Iterative Inorder Traversal with Stack.
public boolean isValidBST(TreeNode root) {
   if (root == null) return true;
   Stack<TreeNode> stack = new Stack<>();
   TreeNode pre = null;
   while (root != null || !stack.isEmpty()) {
      while (root != null) {
         stack.push(root);
         root = root.left;
      }
      root = stack.pop();
      if(pre != null && root.val <= pre.val) return false;
      pre = root;
      root = root.right;
   }
   return true;
}
1008. Construct Binary Search Tree from Preorder Traversal Medium Tags: BST.LeetCode problem
Constructing tree from inorder and postorder traversal. Earlier done in BT. Refer buildTree method in that problem.
We can generate a unique BST from preorder traversal. But we need preorder and inorder traversals to generate BT.
class Solution {
    public TreeNode bstFromPreorder(int[] preorder) {
        int []inorder = preorder.clone();
        Arrays.sort(preorder);
        return buildTree(inorder, preorder);
    }
}
Removing the need for inorder traversal. Because if only preorder traversal is given, we can utilize the property of BST that for a given node, all nodes in its left subtree are smaller than it and in its right subtree are greater than it.
class Solution {
    int preIndex;
    public TreeNode bstFromPreorder(int[] preorder) {
        int n= preorder.length;
        preIndex = 0;
        return buildTreeUtil(preorder, 0, n-1);
    }
    TreeNode buildTreeUtil(int[] preorder, int inStart, int inEnd){
        if(inStart>inEnd){
            return null;
        }
        TreeNode root = new TreeNode(preorder[preIndex]);
        preIndex++;
        if(inStart==inEnd){
            return root;
        }
        int length = countSmaller(preorder, inStart+1, inEnd, root.val);
        root.left = buildTreeUtil(preorder, inStart+1, inStart+length);
        root.right = buildTreeUtil(preorder, inStart+length+1, inEnd);
        return root;
    }
    int countSmaller(int[] preorder, int start, int end, int value){
        int count =0, i=start;
        while(i<=end && preorder[i]<value){
            count++;
            i++;
        }
        return count;
    }
}
Using Bound as INT_MAX. Approach followed in Validate BST Q. Top voted LC solution.
class Solution {
    int i = 0;
    public TreeNode bstFromPreorder(int[] A) {
        return bstFromPreorder(A, Integer.MAX_VALUE);
    }

    public TreeNode bstFromPreorder(int[] A, int bound) {
        if (i == A.length || A[i] > bound) return null;
        TreeNode root = new TreeNode(A[i++]);
        root.left = bstFromPreorder(A, root.val);
        root.right = bstFromPreorder(A, bound);
        return root;
    }
}
235. Lowest Common Ancestor of a Binary Search Tree Easy). Tags: BST.LeetCode problem
In Ancestor problems, start from root. My implementation.
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if(root==null)return null;
        if(p.val>q.val){
            return lowestCommonAncestor(root,q,p);
        }
        if(root.val>=p.val && root.val<=q.val){
            return root;
        }else if(root.val>=p.val && root.val>=q.val){
            return lowestCommonAncestor(root.left,p,q);
        }else{
            return lowestCommonAncestor(root.right, p,q);
        }
    }
}
More cleaner implementation. See the commented lines to know the difference. Same logic as above.
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if(root==null)return null;
        if(root.val>p.val && root.val>q.val){
            return lowestCommonAncestor(root.left,p,q);
        }else if(root.val<p.val && root.val<q.val){
            return lowestCommonAncestor(root.right, p,q);
        }else{
            // if(p.val>q.val && root.val>=q.val && root.val<=p.val){
            //     return root;
            // }else if(p.val<=q.val && root.val>=p.val && root.val<=q.val){
            //     return root;
            // }
            return root;
        }
    }
}
108. Convert Sorted Array to Binary Search Tree Easy Tags: BST. LeetCode Problem. 
class Solution {
    public TreeNode sortedArrayToBST(int[] num) {
    return helper(num, 0, num.length - 1);
}

public TreeNode helper(int[] num, int low, int high) {
    if (low > high) { // Done
        return null;
    }
    int mid = (low + high) / 2;
    TreeNode node = new TreeNode(num[mid]);
    node.left = helper(num, low, mid - 1);
    node.right = helper(num, mid + 1, high);
    return node;
}
}
Do it later: https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/

653. Two Sum IV - Input is a BST Easy Tags: BST. LeetCode Problem. 
Using Array. Using 2 pointers on sorted array. Q becomes finding 2 sum in sorted array. Time complexity = O(n). Space complexity =O(n).
    public boolean findTarget(TreeNode root, int k) {
        List<Integer> list = new ArrayList<>();
        inOrder(root, list);
        int start =0, end = list.size()-1;
        while(start<end){
            if(list.get(start)+list.get(end)==k){
                return true;
            }else if(list.get(start)+list.get(end) < k){
                start++;
            }else{
                end--;
            }
        }
        return false;
        
    }
    void inOrder(TreeNode root,List<Integer> list){
        if(root==null){
            return;    
        }
        inOrder(root.left, list);
        list.add(root.val);
        inOrder(root.right, list);
    }
}
Using HashMap. Time Complexity=O(n). Space complexity=O(n). But this solution doesn't take the advantage that our Binary Tree is a Binary Search Tree.
class Solution {
    HashMap<Integer, Integer>map;
    public boolean findTarget(TreeNode root, int k) {
        map = new HashMap<>();
        return preOrder(root,k);
    }
    boolean preOrder(TreeNode root, int k){
        if(root==null){
            return false;    
        }
        if(map.containsKey(k-root.val)){
            return true;
        }else{
            map.put(root.val, 1);
        }
        return preOrder(root.left,k) || preOrder(root.right,k);
    }
}
Using BST Iterator method. Time complexity=O(n). Space complexity=O(h)+O(h)=O(h)
class BSTIterator {
    private Stack<TreeNode> st = new Stack<>();
    private boolean reverse;
    BSTIterator(TreeNode root, boolean reverse) {
        this.reverse = reverse;
        push(root);
    }
    int next() {
        TreeNode top = st.pop();
        push(!reverse ? top.right : top.left);
        return top.val;
    }
    private void push(TreeNode root) {
        while (root != null) {
            st.push(root);
            root = !reverse ? root.left : root.right;
        }
    }
}

class Solution {
    public boolean findTarget(TreeNode root, int k) {
        BSTIterator leftItr = new BSTIterator(root, false);
        BSTIterator rightItr = new BSTIterator(root, true);

        int left = leftItr.next(), right = rightItr.next();
        while (left < right) {
            if (left + right == k) return true;
            if (left + right < k)
                left = leftItr.next();
            else
                right = rightItr.next();
        }
        return false;
    }
}
173. Binary Search Tree Iterator Medium Tags: BST. LeetCode Problem. 
The implementation of BST iterator is very similar to binary search tree Inorder traversal. Inorder using stack and two while loop. However, in the iterator, the first while condition become hasNext() and the code inside the first while condition become next().
Calling next() will return the next smallest number in the BST. Could you implement next() and hasNext() to run in average O(1) time and use O(h) memory, where h is the height of the tree?. 
Time complexity =O(h) for next(). In worst case, its O(n). I cant see how it is O(1). I cannot understand amortized time complexity concept. See Later.
This is how iterator is coded in Java.
BSTIterator itr = new BSTIterator(root);
while(itr.hasNext()){
    System.out.println(itr.next());
}
Solution using Stack. Similar to Inorder traversal.
public class BSTIterator {

    Stack<TreeNode> stack;
    TreeNode current;
    public BSTIterator(TreeNode root) {
        stack = new Stack();
        current = root;
    }

    /** @return whether we have a next smallest number */
    public boolean hasNext() {
        return current != null|| stack.isEmpty()==false ;
    }

    /** @return the next smallest number */
    public int next() {
        while (current != null) {
            stack.push(current);
            current = current.left;
        }
        current = stack.pop();
        int res = current.val;
        current = current.right;
        return res;
    }
}
More clean solution. Top voted LC Solution.
class BSTIterator {
    Stack<TreeNode>stack = new Stack<>();
    public BSTIterator(TreeNode root) {
        pushToLeft (root);
    }
    
    public int next() {
        TreeNode node = stack.pop();
        pushToLeft (node.right);
        return node.val;
    }
    
    public boolean hasNext() {
        if(stack.isEmpty()==true){
            return false;
        }
        return true;
    }
    void pushToLeft (TreeNode node){
        while(node!=null){
            stack.push(node);
            node=node.left;
        }
    }
}

Floor in BST. Tags: BST. Coding Ninjas Problem. Not on LeetCode.
public class Solution {
	static int ans;
    public static int floorInBST(TreeNode<Integer> root, int X) {
		ans =0;
		helper(root, X);
		return ans;
	}
	public static void helper(TreeNode<Integer> root, int X){
		if(root==null){
			return;
		}
		if(X<root.data){
			helper(root.left, X);
		}else if(X>root.data){
			ans = root.data;
			helper(root.right,X);
		}else{
			ans = root.data;
		}
	}
}

Ceil in BST. Tags: BST. Coding Ninjas Problem. Not on LeetCode.
Iterative solution. Basically searching for a key in BST. But like in Binary Search Questions, store so far the value greater than x. As we reach close to x, the value gets updated.
public class Solution {

    public  static int findCeil(TreeNode<Integer> node, int x) {
		int ceil = -1;
		while(node!=null){
			if(x==node.data){
				ceil = node.data;
				return ceil;
			}else if(x<node.data){
				ceil = node.data;
				node=node.left;
			}else{
				node=node.right;
			}
		}
		return ceil;
    }
}
230. Kth Smallest Element in a BST Medium Tags: BST. LeetCode Problem. 
Simple solution using BSTIterator implemented in previous Questions. Space complexity = O(h). At any particular time, max h elements in stack. Time complexity = O(n).
class Solution {
    public int kthSmallest(TreeNode root, int k) {
        BSTIterator itr = new BSTIterator(root);
        for(int i=1;i<k;i++){
            itr.next();
        }
        return itr.next();
    }
}
Recursive solution.
Use List<Integer>. Do inorder traversal and put result in List. Find element at kth index.
class Solution {
    public int kthSmallest(TreeNode root, int k) {
        List<Integer> list = new ArrayList<>();
        helper(root,list);
        return list.get(k-1);
    }
    void helper(TreeNode root, List<Integer> list){
        if(root==null){
            return;
        }
        helper(root.left, list);
        list.add(root.val);
        helper(root.right, list);
    }
    
}

Recursive Solution. 
Without List<Integer>. Important: Note we need to add a condition that we should exit once our count hits k. Once it hits k, exit the recursion. Basic idea is do not traverse entire tree if not needed. Exit earlier.
class Solution {
    int count = 0;	
    int result = Integer.MIN_VALUE;
    public int kthSmallest(TreeNode root, int k) {
        traverse(root, k);
        return result;
    }

    public void traverse(TreeNode root, int k) {
        if(root == null) return;
        traverse(root.left, k);
        count ++;
        if(count == k){
            result=root.val;
            return;
        } //do not go to next statement.// since we need elements only till k.
        traverse(root.right, k);       
    }
} 
Recursive solution. Without global variables.
class Solution {
    public int kthSmallest(TreeNode root, int k) {
        TreeNode res = new TreeNode(-1);
        int[] curr = new int[] {0};
        bstInorderTraversal(root, res, k, curr);
        return res.val;
    }
    
    private void bstInorderTraversal(TreeNode root, TreeNode res, int k, int[] curr) {
        if(root == null) {
            return;
        }
        
        bstInorderTraversal(root.left, res, k, curr);
        curr[0]++;
        if(curr[0] == k) {
            res.val = root.val;
            return;
        }
        bstInorderTraversal(root.right, res, k, curr);
    }
}

Iterative Inorder traversal solution. 
Using Stack. Best solution as per LC.
class Solution {
    public int kthSmallest(TreeNode root, int k) {
        Stack<TreeNode> stack = new Stack<>();
        while(root != null || stack.isEmpty()==false){
            while(root!=null){
                stack.push(root);
                root = root.left; 
            }
            root = stack.pop();
            k--;
            if(k==0){
                return root.val;
            }
            root = root.right;
        }
        return -1;
    }
}
Kth largest element in BST Easy. Tags: BST. GFG Question
Can also do reverse inorder traversal
public int kthLargest(Node root,int k){
        List<Integer> list = new ArrayList<>();
        helper(root,list);
        return list.get(k-1);
    }
    void helper(Node root, List<Integer> list){
        if(root==null){
            return;
        }
        helper(root.right, list);
        list.add(root.data);
        helper(root.left, list);
    }
