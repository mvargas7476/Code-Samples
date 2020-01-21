
package ood.homeworkFinal.coupons;

import java.util.Enumeration;
import java.util.Vector;
import ood.homeworkFinal.Customer;
import ood.homeworkFinal.LineItem;
import static ood.homeworkFinal.item.ItemFactory.ItemType.NEW_RELEASE_MOVIE;
import ood.homeworkFinal.points.RenterPointsStrategyFactory;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class DoubleForYoungAdults extends Coupon {
    // Double points for young adults who rent at least one New Release
    @Override
    public void applyCoupon(Vector _lineItems, Customer cust ) {
        if(  this.validateCoupon(_lineItems, cust ) ) {
            Enumeration lineItems = _lineItems.elements();
            while( lineItems.hasMoreElements() ) {
                LineItem lineItem = (LineItem) lineItems.nextElement();
                lineItem.setPointsStrategy(RenterPointsStrategyFactory.buildDouble(lineItem.getItem()));
            }
        }
    }

    @Override
    public boolean validateCoupon(Vector _lineItems, Customer cust) {
        // True if Customer age between 18-21 & they are renting one or more New Release
        Enumeration lineItems = _lineItems.elements();
        boolean hasNewRelease = false;
        while( lineItems.hasMoreElements() ) {
            // Looking for a new release
            LineItem lineItem = (LineItem) lineItems.nextElement();
            if(lineItem.getItem().getItemType() == NEW_RELEASE_MOVIE ) {
                hasNewRelease = true;
                break;
            }
        }
        return hasNewRelease && (cust.getAge() > 18) && (cust.getAge() < 22);
    }
}
