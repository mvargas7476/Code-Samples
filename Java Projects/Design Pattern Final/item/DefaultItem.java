
package ood.homeworkFinal.item;

/**
 * The DefulatItem is what we use for any "Purchase Only" items, that never get rented.
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class DefaultItem extends Item {
    public DefaultItem(ItemFactory.ItemType type, String desc, boolean Rentable, boolean ForSale, double purchasePrice ) {
        super(type, desc, false, ForSale, purchasePrice);
    }
    
}
