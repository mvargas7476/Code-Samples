
package ood.homeworkFinal;
import ood.homeworkFinal.coupons.Coupon;
import ood.homeworkFinal.coupons.CouponFactory;

import java.util.Enumeration;
import java.util.Vector;
import static ood.homeworkFinal.LineItem.TransType.PURCHASE;
import static ood.homeworkFinal.LineItem.TransType.RENTAL;

/**
 * A customer's Invoice for the current transaction 
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class Invoice {
    private Vector _item = new Vector();
    private int rentalPoints ;
    
    Invoice( ) { }
    
    int getRentalPoints() { return rentalPoints; }
    
    public void addLIneItem(LineItem lineItem) {
        _item.addElement(lineItem);
    }
    
    public void applyCoupon(CouponFactory.CouponType couponType, Customer customer ) {
        Coupon coupon = CouponFactory.build(couponType) ;
        coupon.applyCoupon(_item,  customer );  
    }
    
    private String xmlStatementFooter(double totalCost) {
        return "<AmountOwed>" + String.valueOf(totalCost) + "</AmountOwed>\n" 
           +   "<PointsEarned>" + rentalPoints + "</PointsEarned>\n";
    }
    
    private String statementFooter(double totalCost) {
        String result = "";
        // add footer lines
        result += "Amount owed is " + String.valueOf(totalCost) + "\n";
        result += "You earned " + String.valueOf(rentalPoints) +
                  " frequent renter points";
        return result;
    }
    
    public String xmlStatement( String custName ) {
        rentalPoints = 0 ;
        double totalCost = 0 ;
        Enumeration items = _item.elements();
        String      result  = "<statement>\n\n" + "<customerName>" + custName + "</customerName>\n";
        
        while (items.hasMoreElements()) {
            
            LineItem lineItem       = (LineItem) items.nextElement();
            double lineAmount = lineItem.getCost();
            rentalPoints += lineItem.getPoints();
            totalCost += lineAmount;
            // show figures for this lineItem
            if( lineItem.getTransType() == RENTAL) {
                result += "\t<rental>" + lineItem.description() + "</rental>" +
                      "<price>" + String.valueOf(lineAmount) + "</price>\n"; 
            }
            else {
                result += "\t<purchase>" + lineItem.description() + "</purchase>" +
                      "<price>" + String.valueOf(lineAmount) + "</price>\n";
            }
        }
        
        result += xmlStatementFooter( totalCost );

        return result + "</statement>\n";
    }
    
    public String statement(String custName) {
        rentalPoints = 0 ;
        double totalCost = 0 ;
        Enumeration items = _item.elements();
        String      result  = "Rental Record for " + custName + "\n";
        
        while (items.hasMoreElements()) {
            
            LineItem lineItem       = (LineItem) items.nextElement();
            double lineAmount = lineItem.getCost();
            rentalPoints += lineItem.getPoints();
            totalCost += lineAmount;
            
            // show figures for this lineItem
            if( lineItem.getTransType() == PURCHASE) {
                result += "\tPurchase: " + lineItem.description() +
                        "\t" + String.valueOf(lineAmount) + "\n"; 
            }
            else {
                result += "\tRental:   " + lineItem.description() +
                        "\t" + String.valueOf(lineAmount) + "\n"; 
            }
        }
        
        result += statementFooter( totalCost );

        return result;
    } 
}
