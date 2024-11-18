@isTest
public with sharing class AccountManagerTest {

    @isTest
    static void getAccount(){
        Id accountId = createTestAccount();

        RestRequest req = new RestRequest();

        req.requestURI = '/Accounts/' + accountId + '/contacts';

        req.httpMethod = 'GET';

        RestContext.request = req;

        Account thisAccount = AccountManager.getAccount();

        Assert.isTrue(thisAccount != null);
        Assert.areEqual('Test Account', thisAccount.Name);

    }


    static Id createTestAccount(){
        Account testAcc = new Account(
            Name = 'Test Account'
        );

        insert testAcc;
        return testAcc.Id;

    }
}