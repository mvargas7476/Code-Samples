
package ood.homework4.price;

import ood.homework4.Customer;
import ood.homework4.Movie;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class PriceStrategyFactory {
    
    public enum Type {
        CHILDREN,
        REGULAR,
        NEW_RELEASE,
        FREE
    }  
    static public PriceStrategy build(Customer cust, Movie movie ) {
        throw new UnsupportedOperationException("Not supported yet.");
        // return null;
    }
    static public PriceStrategy build( Movie movie ) {
        switch( movie.getType() ) {
            case NEW_RELEASE:
                return new PriceNewRelease();
                
            case CHILDREN:
                return new PriceChildren();
                
            case  REGULAR:
            default:
                return new PriceRegular();
        }
    }
    static public PriceStrategy build( Type _type ) {
        switch( _type ) {
            case FREE:
                return new PriceFree();
                
            case NEW_RELEASE:
                return new PriceNewRelease();
                
            case CHILDREN:
                return new PriceChildren();
                
            case  REGULAR:
            default:
                return new PriceRegular();
        }
    }    
}
