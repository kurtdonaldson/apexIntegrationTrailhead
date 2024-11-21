public with sharing class DailyLeadProcessor implements Schedulable {

    public void execute(SchedulableContext SC) {

        List<Lead> leadList = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = NULL LIMIT 200];

        for(Lead singleLead: leadList){
            singleLead.LeadSource = 'Dreamforce';
        }

        if(!leadList.isEmpty()){
            update leadList;
        }

     }

}