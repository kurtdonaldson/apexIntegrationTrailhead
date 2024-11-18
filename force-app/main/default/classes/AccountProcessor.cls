public with sharing class AccountProcessor {


    @future
    public static void countContacts(List<Id> accountIds){
        List<Account> accoutList = [SELECT Id, Name, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];

        for(Account acc: accoutList){
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }

        update accoutList;

    }


}