
package ood.homework4.points;

import ood.homework4.Movie;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class RenterPointsStrategyFactory {
    public enum Type {
        CHILDREN,
        REGULAR,
        NEW_RELEASE,
        DOUBLE_NEW_RELEASE,
        DOUBLE,
    }  
    
    // Set strategy based on just the movie
    static public RenterPointsStrategy build( Movie movie ) {
        switch( movie.getType() ) {
            case NEW_RELEASE:
                return new RenterPointsNewRelease();
            case CHILDREN:
            case  REGULAR:
            default:
                return new RenterPointsDefault();
        }
    } 
    static public RenterPointsStrategy buildDouble( Movie movie  ) {
        switch( movie.getType() ) {
            case NEW_RELEASE:
                return new RenterPointsDoubleNewRelease();
            case CHILDREN:
            case  REGULAR:
            default:
                return new RenterPointsDouble();
        }
    }     
}
