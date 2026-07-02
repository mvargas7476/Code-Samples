package ood.homeworkFinal;

import ood.homeworkFinal.item.Item;
import ood.homeworkFinal.price.PriceStrategy;
import ood.homeworkFinal.price.PriceStrategyFactory;
import ood.homeworkFinal.points.RenterPointsStrategyFactory;
import ood.homeworkFinal.points.RenterPointsStrategy;
/**
 * Class that holds a single line item on an invoice
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class LineItem {
    
    public enum TransType {
        RENTAL,
        PURCHASE
    }
    private final TransType _type ;
    private final Item _item;
    private final int   _daysRented;
    private PriceStrategy _pricing;
    private RenterPointsStrategy _pointing;
    
    // Rental Line Items include a "days rented" 
    public LineItem(Item item, int daysRented) {
        _item      = item;
        _daysRented = daysRented;
        _pricing = PriceStrategyFactory.build( item );
        _pointing = RenterPointsStrategyFactory.build( item );
        _type = TransType.RENTAL;
    }
    
    // Purchase items are built with just the item
    public LineItem( Item item ) {
        _item      = item;
        _daysRented = 0;
        _pricing = PriceStrategyFactory.build( item, item.getPurchasePrice() );
        _pointing = RenterPointsStrategyFactory.build( item );
        _type = TransType.PURCHASE;
    }
    
    public void setPointsStrategy( RenterPointsStrategy Points ) {
        _pointing = Points;
    }
    
    public void setPriceStrategy( PriceStrategyFactory.Type _type  ) {
        _pricing = PriceStrategyFactory.build( _type );
    }  
    public Item getItem() { return _item; };
    public TransType getTransType() {return _type; };
    public double getCost( ) {
        return _pricing.price(_daysRented);
    }    
    
    public int getPoints() {
        return _pointing.renterPoints(_daysRented);
    }
    
    public int getDaysRented() {
        return _daysRented;
    }
    
    public String description() {
        return _item.description();
    }
}