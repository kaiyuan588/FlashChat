package edu.neu.coe.solutions;

public class WeightedQuickUnionUF {
	public WeightedQuickUnionUF(int N) {
		count = N;
		id = new int[count];
		for(int i = 0; i < count; i++) id[i] = i;
		size = new int[count];
		for(int i = 0; i < count; i++) size[i] = 1;
	}
	
	public int count() { return count; }
	public boolean connected(int p, int q) { return find(p) == find(q); }
	
	public void union(int p, int q) {
		int rootP = find(p);
        int rootQ = find(q);
        if (rootP == rootQ) return;
        // make smaller root point to larger one
        if (size[rootP] < size[rootQ]) {
            id[rootP] = rootQ;
            size[rootQ] += size[rootP];
        }
        else {
        	id[rootQ] = rootP;
            size[rootP] += size[rootQ];
        }
        count--;
	}
	public int find(int p) {
		int root = p;
        while (root != id[root]) {
            root = id[root];
        }
        while (p != root) {
            int newp = id[p];
            id[p] = root;
            p = newp;
        }
        return root;
	}

	private int[] id;
	private int[] size; // size of component for root
	private int count; // number of components
}

