package ood.homework4;

import ood.homework4.price.PriceStrategy;
import ood.homework4.price.PriceStrategyFactory;
import ood.homework4.points.RenterPointsStrategyFactory;
import ood.homework4.points.RenterPointsStrategy;
/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class Rental {
    
    private final Movie _movie;
    private final int   _daysRented;
    private PriceStrategy _pricing;
    private RenterPointsStrategy _pointing;
    
    public Rental(Movie movie, int daysRented) {
        _movie      = movie;
        _daysRented = daysRented;
        _pricing = PriceStrategyFactory.build( _movie );
        _pointing = RenterPointsStrategyFactory.build( _movie );
    }
    
    public void setPointsStrategy( RenterPointsStrategy Points ) {
        _pointing = Points;
    }
    
    public void setPriceStrategy( PriceStrategyFactory.Type _type  ) {
        _pricing = PriceStrategyFactory.build( _type );
    }  
    
    public double getCost( ) {
        return _pricing.rentalCost(_daysRented);
    }    
    
    public int getPoints() {
        return _pointing.renterPoints(_daysRented);
    }
    
    public int getDaysRented() {
        return _daysRented;
    }
    
    public Movie getMovie() {
        return _movie;
    }
}