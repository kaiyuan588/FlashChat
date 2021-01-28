package edu.neu.coe.info6205.union_find;

import java.util.Random;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();
		WQUPC uf = new WQUPC(n);
		
		double result = 0.5*Math.log(n)*n;
		while (uf.c()!=1) {
			
			Random random = new Random();
		    int p = random.nextInt(n);
		    int q = random.nextInt(n);
		    if (uf.connected(p, q))
		    continue;
		    uf.union(p, q);
		   

		}

	
		System.out.println(uf.count() + " pairs"+" and result "+ result);

		

	}

}
