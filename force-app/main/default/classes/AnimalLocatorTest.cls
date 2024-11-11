@isTest
private class AnimalLocatorTest {

    @isTest
    static void testPostCallout() {
    // Set mock callout class
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock.
    String response =  AnimalLocator.getAnimalNameById(1);
    // Verify that the response received contains fake values
    // String contentType = response.getHeader('Content-Type');
    // Assert.isTrue(contentType == 'application/json');
    // String actualValue = response.getBody();
    // System.debug(response.getBody());
    // String expectedValue = 'chicken';
    // Assert.areEqual(expectedValue, actualValue);
    // Assert.areEqual(200, response.getStatusCode());
    Assert.areEqual('chicken', response);
    }
    
}