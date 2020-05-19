public with sharing Class ContactTriggerHandler {
    /** 
    ** Name        : beforeUpdateContact
    ** Description : beforeUpdate Trigger operations on Contacts
    ** Params      : List<Contact>
    **/
    public static void beforeUpdateContact(List<Contact> lstContacts) {
        processContacts(lstContacts);
    }
    
    /** 
    ** Name        : beforeInsertContact
    ** Description : beforeInsert Trigger operations on Contacts
    ** Params      : List<Contact>
    **/
    public static void beforeInsertContact(List<Contact> lstContacts) {
        processContacts(lstContacts);
    }
    
    /** 
    ** Name        : processContacts
    ** Description : validations on updating contacts
    ** Params      : List<Contact>
    **/
    private static void processContacts(List<Contact> lstContacts) {
        set<Id> accountIds = new set<Id>(); //set to store the account Ids in trigger
        map<Id, boolean> primaryContactForAccountMap = new map<Id, boolean>(); //map to put the primary contact related account
        //get the account Ids to iterate on different accounts in trigger
        for(Contact cont : lstContacts) {
            accountIds.add(cont.AccountId);
        }
        
        //get the primary contact related account in primaryContactForAccountMap
        for(Account acc : [select Id, (select Id from Contacts where Primary__c = true limit 1) from Account where Id in :accountIds]) {
            if(!acc.Contacts.isEmpty()) {
                primaryContactForAccountMap.put(acc.Id, true);
            }    
        }
        //validations on Primary contact
        for(Contact cont : lstContacts) {
            if(cont.primary__c && !primaryContactForAccountMap.isEmpty() && primaryContactForAccountMap.get(cont.AccountId)) {
                cont.primary__c.addError('Error : Primary contact already exist');
            }
        }
    }
}