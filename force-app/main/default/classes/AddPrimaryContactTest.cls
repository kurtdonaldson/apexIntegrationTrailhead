@isTest
public with sharing class AddPrimaryContactTest {

    @TestSetup
    static void makeData(){

        List<Account> testAccounts = new List<Account>();

        for(Integer i = 0; i < 100; i++){
            String bState = i < 50 ? 'NY' : 'CA';

            Account acc = new Account(Name = 'Account' + i, BillingState = bState);

            testAccounts.add(acc);

        }

        insert testAccounts;

        Contact testContact = new Contact(LastName = 'Test Contact');

        insert testContact;
        
    }

    @isTest
    static void testPrimaryContactCreated(){

        Contact testContact = [SELECT Id, LastName FROM Contact WHERE LastName = 'Test Contact' LIMIT 1];

        AddPrimaryContact testQueueableClass = new AddPrimaryContact(testContact, 'CA');

        Test.startTest();

        System.enqueueJob(testQueueableClass);

        Test.stopTest();

        List<Contact> results = [SELECT Id FROM Contact WHERE Account.BillingState = 'CA'];

        Assert.areEqual(50, results.size());

    }

}