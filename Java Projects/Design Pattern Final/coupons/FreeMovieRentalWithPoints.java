
package ood.homeworkFinal.coupons;

import java.util.Enumeration;
import java.util.Vector;
import ood.homeworkFinal.Customer;
import ood.homeworkFinal.LineItem;
import static ood.homeworkFinal.LineItem.TransType.RENTAL;
import ood.homeworkFinal.price.PriceStrategyFactory;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class FreeMovieRentalWithPoints extends Coupon {

    @Override
    public void applyCoupon(Vector _lineItems, Customer cust) {
       if( validateCoupon(_lineItems, cust)) {
           // The customer has points to use!
           // Gives Free Rental for most expensive rental
            Enumeration itemList = _lineItems.elements();
            LineItem maxRental = null;
            while( itemList.hasMoreElements() ) {
                LineItem item = (LineItem) itemList.nextElement();
                if( item.getTransType() == RENTAL )
                    if( (maxRental == null ) || (maxRental.getCost() < item.getCost()) )
                        maxRental = item;
            }
            if( (maxRental != null )) {
                maxRental.setPriceStrategy(PriceStrategyFactory.Type.FREE);
                cust.setPoints( cust.getPoints() - 10 );
            }
       }
    }

    @Override
    public boolean validateCoupon(Vector _items, Customer cust) {
        if( cust.getPoints() >= 10 )
            return true;
        return false;
    }
    
}
