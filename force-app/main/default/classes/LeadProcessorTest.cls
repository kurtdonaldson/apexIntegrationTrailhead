@isTest
public with sharing class LeadProcessorTest {

    @TestSetup
    static void makeData(){

        List<Lead> leadList = new List<Lead>();

        for(Integer i = 0; i < 200; i++){
            Lead newLead = new Lead(LastName = 'Lead' + i, Company = 'Company' + i);
            leadList.add(newLead);
        }

        insert leadList;
        
    }

    @isTest
    static void updateLead(){

        LeadProcessor batchObject = new LeadProcessor();

        Test.startTest();

        Id batchJob = Database.executeBatch(batchObject);

        Test.stopTest();

        List<Lead> leadResults = [SELECT Id, LeadSource FROM Lead];

        Integer results = 0;

        for(Lead singleLead: leadResults){
            if(singleLead.LeadSource == 'Dreamforce'){
                results++;
            }
        }

        Assert.areEqual(200, results);



    }

}