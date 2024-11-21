@isTest
public with sharing class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 0 3 9 ? 2042';


    @isTest
    static void testLeadSourcePopulated(){

        List<Lead> testLeads = new List<Lead>();

        for(Integer i = 0; i < 200; i++ ){
            Lead newLead = new Lead(LastName = 'Test Lead' + i, Company = 'Test Company');
            testLeads.add(newLead);
        }

        insert testLeads;

        Map<Id, Lead> insertedLeads= new Map<Id, Lead>([SELECT Id FROM Lead LIMIT 200]);
        List<Id> listIds = new List<Id>(insertedLeads.keySet());
        
        Test.startTest();

        DailyLeadProcessor scheduleClass = new DailyLeadProcessor();

        String jobId = System.schedule('testScheduleJob', CRON_EXP, scheduleClass);

        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
        NextFireTime
        FROM CronTrigger WHERE id = :jobId];

        // Verify the expressions are the same
        System.assertEquals(DailyLeadProcessorTest.CRON_EXP, 
        ct.CronExpression);

        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered); 
        
        // Verify the next time the job will run
        System.assertEquals('2042-09-03 00:00:00', 
        String.valueOf(ct.NextFireTime));

        Test.stopTest();

        List<Lead> leadResult = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        Assert.areEqual(200, leadResult.size(), '200 Leads should have LeadSource updated');


    }

}