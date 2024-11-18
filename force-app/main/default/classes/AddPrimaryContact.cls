public with sharing class AddPrimaryContact implements Queueable {

    Contact con;
    String stateAbbrev;

    public AddPrimaryContact(Contact con, String stateAbb) {
        this.con = con;
        this.stateAbbrev = stateAbb;
    }

    public void execute(QueueableContext context) {

        List<Account> acc = [SELECT Id, Name, BillingState, (SELECT Id FROM Contacts) FROM Account WHERE BillingState = :stateAbbrev LIMIT 200];

        //Insert the con record associated to each Account. Need to clone Contact and add it to each account

        List<Contact> contactsToInsert = new List<Contact>();

        for(Account parentAcc: acc){
            Contact clonedContact = con.clone();
            clonedContact.AccountId = parentAcc.Id;
            contactsToInsert.add(clonedContact);
        }

        insert contactsToInsert;
  
    }


}