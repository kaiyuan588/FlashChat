package quiz2;

public class Student {
	private final String name;
    final int id;
         
    public Student(String name, int id){
        this.name = name;
        this.id = id;
    }
     
    @Override
	public String toString() {
	       return "Student "+name+" has id "+id+"";
	}
    
    @Override
    public boolean equals(Object obj){
    	if(this == obj)
            return true;
        
    	if(obj == null || obj.getClass()!= this.getClass())
            return false;
         
        Student student = (Student) obj;
        if(id != student.id) return false;
        
        return student.name.equals(this.name);
    }
     
    @Override
    public int hashCode(){
    	int result;
	       result = id;
	       result = result * 31 + ((name == null) ? 0 : name.hashCode());
	       return result;
    }
}
