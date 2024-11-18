public with sharing class LeadProcessor implements Database.Batchable<sObject> {

    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, LeadSource FROM Lead]);
     }

     public void execute(Database.BatchableContext bc, List<Lead> scope){

        List<sObject> leadsToUpdate = new List<Lead>();


        for(Lead singleLead: scope){
            singleLead.LeadSource = 'Dreamforce';
            leadsToUpdate.add(singleLead);
        }

        update leadsToUpdate;
       }


     public void finish(Database.BatchableContext bc){
    }
  
}