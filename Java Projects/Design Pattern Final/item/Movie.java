package ood.homeworkFinal.item;
/**
 * Movie Item
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class Movie extends Item  {

    public enum MovieTypes {
        CHILDRENS,
        REGULAR,
        NEW_RELEASE
    }
    private final MovieTypes _movieType;
    
    public Movie(ItemFactory.ItemType iType, String desc, boolean rentable, boolean forSale, MovieTypes type, double purchasePrice ) {
        super( iType, desc, rentable, forSale, purchasePrice ); 
        _movieType = type;
    }

}