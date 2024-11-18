@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
  
    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        // RestResponse res = RestContext.response;
        String accountId = req.requestURI.substringBetween('Accounts/', '/contacts');
        System.debug('Accountid substring = ' + accountId);
        List<Account> result = [SELECT Id, Name, (SELECT id, Name FROM Contacts) FROM Account WHERE Id = :accountId];
        return result[0];
    }
  
}