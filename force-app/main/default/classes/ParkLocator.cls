public with sharing class ParkLocator {

    public List<String> country(String countryInput){

        ParkService.byCountry parkService = new ParkService.byCountry();

        System.debug('Park Service variable = ' + parkService);

        List<String> dummyList = new List<String>{'bees', 'tigers'};

        return dummyList;

    }

}