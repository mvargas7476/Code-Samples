
package ood.homeworkFinal.item;

import ood.homeworkFinal.item.ItemFactory.ItemType;
import ood.homeworkFinal.points.RenterPointsStrategy;
import ood.homeworkFinal.price.PriceStrategy;

/**
 * This Abstract class is the common Item behavior
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public abstract class Item {
    
    // Common Data Elements shared by all concrete Items
    private final String _desc;
    private final boolean _Rentable;
    private final boolean _ForSale;
    private final ItemType _type;
    private final double _PurchasePrice;
    
    // Common Constructor 
    public Item(ItemType type, String desc, boolean isRentable, boolean isForSale , double PurchasePrice) {
        _desc = desc;
        _Rentable = isRentable;
        _ForSale = isForSale;
        _type = type;
        _PurchasePrice = PurchasePrice;
    }
    
    // Common Methods for all kinds of Items
    public String  description() {return _desc; };
    public boolean forRent() { return _Rentable; };
    public boolean forSale() { return _ForSale; };

    public  ItemType getItemType() {return _type; };
    public double getPurchasePrice() {return _PurchasePrice; };
}
