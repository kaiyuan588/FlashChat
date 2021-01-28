package quiz3;

import java.util.Scanner;

public class Stack<Item> {
	@SuppressWarnings("unchecked")
	private Item[] items = (Item[]) new Object[30];
	private int N = 0;
	
	public void push(Item item) {
		// TODO implement this method
		 items[N] = item;
			N++;
	}
		
	public Item pop() {
		// TODO implement this method
		if(N==0) return null;
		return items[--N];
	}
	
	public static Double evaluateDijkstraTwoStack(String expression) {
		String[] array = expression.split(" ");
		
		Stack<String> ops = new Stack<String>();
		Stack<Double> vals = new Stack<Double>();
		
		for (String s : array) {
			if (s.equals("("));
			else if (s.equals("+")) ops.push(s);
			else if (s.equals("-")) ops.push(s);
			else if (s.equals("*")) ops.push(s);
			else if (s.equals("/")) ops.push(s);
			else if (s.equals("sqrt")) ops.push(s);
			else if (s.equals(")")) {
				String op = ops.pop();
				double v = vals.pop();
				if (op.equals("+")) v = vals.pop() + v;
				else if (op.equals("-")) v = vals.pop() - v;
				else if (op.equals("*")) v = vals.pop() * v;
				else if (op.equals("/")) v = vals.pop() / v;
				else if (op.equals("sqrt")) v = Math.sqrt(v);
				vals.push(v);
 			}
			else vals.push(Double.parseDouble(s));
		}
		return vals.pop();	
	}
	
	private void resize(int max) {
		@SuppressWarnings("unchecked")
		Item[] temp = (Item[]) new Object[max];
		for (int i = 0; i < N; i++)
			temp[i] = this.items[i];
		this.items = temp;
	}
	
	public static void main(String[] args) {
        //String input = "( 2 * ( 1 + 3 ) )";
        Scanner scan = new Scanner(System.in);
        String input = "" + scan.next();
        System.out.println(Stack.evaluateDijkstraTwoStack(input));
		System.out.println(Stack.evaluateDijkstraTwoStack(input));
    }
}