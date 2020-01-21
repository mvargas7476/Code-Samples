
package ood.homeworkFinal.coupons;

import ood.homeworkFinal.points.RenterPointsStrategyFactory;
import java.util.Enumeration;
import java.util.Vector;

import ood.homeworkFinal.Customer;
import ood.homeworkFinal.LineItem;
import static ood.homeworkFinal.LineItem.TransType.RENTAL;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class DoubleForTwoCoupon extends Coupon {
    // This coupon doubles points if there are more than one catagory
    @Override
    public void applyCoupon(Vector lineIitems, Customer cust) {
        if(  this.validateCoupon(lineIitems, cust ) ) {
            Enumeration lineItemList = lineIitems.elements();
            while( lineItemList.hasMoreElements() ) {
                LineItem lineItem = (LineItem) lineItemList.nextElement();
                if(lineItem.getTransType() == RENTAL ) {
                    // Double all Rental lines' Points
                   lineItem.setPointsStrategy(RenterPointsStrategyFactory.buildDouble(lineItem.getItem() ));
                }
            }
        }
    }
    @Override
    public boolean validateCoupon(Vector _lineItems, Customer cust ) {
        Vector rentedTypes = new Vector();
        // Tests to see if coupon is valid for the lineItem list
        Enumeration lineItems = _lineItems.elements();
        while (lineItems.hasMoreElements()) {
            LineItem lineItem       = (LineItem) lineItems.nextElement();
            if( lineItem.getTransType() == RENTAL && lineItem.getItem().getItemType().toString().contains("MOVIE") ) {
                // Only appies to "MOVE" Rentals
                if(!rentedTypes.contains(lineItem.getItem().getItemType().toString() )) {
                    rentedTypes.add(lineItem.getItem().getItemType().toString() );
                }
            }
        }
        return rentedTypes.size() > 1 ;
    }
}
