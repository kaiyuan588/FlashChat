package quiz3;

import static org.junit.Assert.assertTrue;

public class DijkstraStack<Item>{
	
	public DijkstraStack(int size) {
		 grow((Item[]) new Object[0],size);
	 }
	    
	 public void push(Item element) {
		 if (isFull())
			 grow(arr, 2*size);
		 arr[index] = element;
		 index++;
	 }

	 public Item pop(){
		 if (isEmpty())
			 return null;
		 return arr[--index];
	 }
	 
	 public Item peek(){
		 if (isEmpty())
			 return null;
		 return arr[index-1];
	 }

	 public boolean isEmpty() {
		 return index == 0;
	 }

	 public boolean isFull() {
		 return index == size;
	 }

	 public int size() {
		 return size;
	 }
	 
	 public static void evaluate(DijkstraStack<String> operators,DijkstraStack<Integer> values,String expr){
		 String[] tokens = expr.split(" ");
				 
		 for(String token : tokens){
			 switch(token){
			 case "(": break;
			 case "+":
			 case "-":
			 case "*":
			 case "/":
				 operators.push(token);
				 break;
			 case ")":
				 String operator = operators.pop();
				 Integer val = values.pop();
							
				 switch(operator){
				 case "+": val = values.pop() + val;break;
				 case "-": val = values.pop() - val;break;
				 case "*": val = values.pop() * val;break;
				 case "/": val = values.pop() / val;break;
				 }
				 values.push(val);
				 break;
			 default:
				 Integer num = Integer.parseInt(token);
				 values.push(num);
				 break;	
			 }
		 }
	 }
	 
	 private void grow(Item[] source, int size){
		 this.size = size;
		 arr = growTheArray(source, size); 
	 }
	    
	 private static<Item> Item[] growTheArray(Item[] source, int size){
		 Item[] newArray = (Item[]) new Object[size];
		 System.arraycopy(source, 0, newArray, 0, source.length);
		 return newArray;
	 }
	 private Item arr[];
	 private int size;
	 private int index = 0;
	 
	 public static void main(String[] args){
		 DijkstraStack<String> operators = new DijkstraStack<>(10);
		 DijkstraStack<Integer> values = new DijkstraStack<>(10);
		 
		 // Note that the expression is split based on the spaces between operands and operators.
		 //"( 1 + ( ( 2 + 3 ) * ( 4 * 5 ) ) + ( 2 * ( 10 + 15 ) ) - ( 1 + ( 17 + 2 * ( 5 + 4 ) ) ) )";
		 String expr =  "( 1 + ( ( 2 + 3 ) * ( 4 * 5 ) ) )";
		 
		 DijkstraStack.evaluate(operators, values, expr);
		 
		 assertTrue(values.peek() == 101);
		 System.out.println("result is = "+values.pop());
	 }
}
