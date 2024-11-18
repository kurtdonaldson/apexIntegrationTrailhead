@isTest
public with sharing class AccountProcessorTest {

    @TestSetup
    static void makeData(){
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 4; i++){
            contactList.add(new Contact(LastName = 'Contact ' + i, AccountId = testAccount.Id));
        }
        insert contactList;
    }

    @isTest
    static void testNumContacts(){

        Account accountList = [SELECT id, Name FROM Account WHERE Name = 'Test Account'];
        List<Id> accIds = new List<Id>{Id.valueOf(accountList.Id)};

        test.startTest();

        AccountProcessor.countContacts(accIds);

        test.stopTest();

        Account accountResults = [SELECT id, Name, Number_Of_Contacts__c FROM Account WHERE Name = 'Test Account'];         
        
        Assert.areEqual(4, accountResults.Number_Of_Contacts__c);
    }

}