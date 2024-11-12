public with sharing class ParkLocator {


    public static List<String> country(String countryInput){

        ParkService.ParksImplPort parks = new ParkService.ParksImplPort();

        List<String> parkNames = parks.byCountry(countryInput);

        System.debug(parkNames);

        return parkNames;


    }
}