@isTest
public with sharing class ParkLocatorTest {

    @isTest
    static void ParkServiceMock(){

        //This causes fake response to be sent
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        List<String> results = ParkLocator.country('Japan');

        List<String> expectedResults = new List<String>{'Shiretoko National Park', 'Oze National Park', 'Hakusan National Park'};

        Assert.areEqual(expectedResults, results);

    }

}