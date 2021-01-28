package quiz2;

public class Tuple {

	   private final int x;
	   private final double y;

	   public Tuple(int x, double y) {
	       this.x = x;
	       this.y = y;
	   }

	   @Override
	   public String toString() {
	       return "Tuple("+x+", "+y+")";
	   }

	   @Override
	   public boolean equals(Object o) {
	       if (this == o) return true;
	       if (o == null || getClass() != o.getClass()) return false;

	       Tuple tuple = (Tuple) o;

	       if (x != tuple.x) return false;
	       return Double.compare(tuple.y, y) == 0;
	   }

//	   or	
//	   @Override
//	   public boolean equals(Object o) {
//	       if (this == o) return true;
//	       if (o == null || getClass() != o.getClass()) return false;
//
//	       Tuple tuple = (Tuple) o;
//
//	       if (x != tuple.x) return false;
//	       return (new Double(y).equals(new Double(tuple.y)));
////	     return Double.compare(tuple.y, y) == 0;
//	   }

	   @Override
	   public int hashCode() {
	       int result;
	       long temp;
	       result = x;
	       temp = Double.doubleToLongBits(y);
	       result = 31 * result + (int) (temp ^ (temp >>> 32));
	       return result;
	   }

//	   or
//
//	  @Override
//	   public int hashCode() {
//	       int result = x;
//	       result = 31 * result + new Double(y).hashCode();
//	       return result;
//	   }
	}
