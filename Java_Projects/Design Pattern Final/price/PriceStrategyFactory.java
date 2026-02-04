
package ood.homeworkFinal.price;

import ood.homeworkFinal.item.Item;


/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class PriceStrategyFactory {
    
    public enum Type {
        CHILDREN,
        REGULAR,
        NEW_RELEASE,
        VARIABLE,
        FREE
    }
    
    static public PriceStrategy build( Item item ) {
        switch( item.getItemType() ) {
            case NEW_RELEASE_MOVIE:
                return new NewReleaseRent();                
            case CHILDRENS_MOVIE:
                return new ChildrenRent();     
            case REGULAR_MOVIE:
                 return new RegularRentPrice();
            case XBOX_GAME:
            case PS4_GAME:
                return new VideoGameRental();
            default:
                return new RegularRentPrice();
        }
    }
    static public PriceStrategy build( Type _type ) {
        switch( _type ) {
            case FREE:
                return new Free();         
            case NEW_RELEASE:
                return new NewReleaseRent();        
            case CHILDREN:
                return new ChildrenRent();    
            case  REGULAR:
            default:
                return new RegularRentPrice();
        }
    }
    static public PriceStrategy build( Item item , double price ) {
        VariableSalePrice newPrice = new VariableSalePrice();
        newPrice.setPrice(price);
        return (PriceStrategy) newPrice;
    }
}
