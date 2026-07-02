package ood.homework4;
/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class Movie {
    public enum Type {
        CHILDREN,
        REGULAR,
        NEW_RELEASE
    }    
    private String _title;
    private Type   _typeCode;
    
    public Movie(String title, Movie.Type type ) {
        _title = title;
        _typeCode = type;
    }
    
    public String getTitle() {
        return _title;
    }
    
    public Type getType() { 
        return _typeCode; 
    };
    
}