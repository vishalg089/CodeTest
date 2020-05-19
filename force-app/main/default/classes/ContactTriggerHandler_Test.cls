@isTest
private class ContactTriggerHandler_Test { 
    /** 
    ** Name        : setupTestData
    ** Description : test data setup for ContactTrigger
    ** Params      : 
    **/
    @testSetup
    private static void setupTestData() {
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        for(Integer count = 0; count < 100; count++) {
            Account acc = new Account(Name = 'TestAccount'+count);
            accountList.add(acc);    
        }
        insert accountList;
        
        for(Integer count = 0; count < 100; count++) {
            Contact con = new Contact(LastName = 'TestLName'+count, accountId = accountList[count].Id);
            contactList.add(con);    
        }
        
        insert contactList;
    }
    
    /** 
    ** Name        : setPrimaryContactSuccessTest
    ** Description : test case for Successfull updating contact
    ** Params      : 
    **/
    private static testMethod void setPrimaryContactSuccessTest(){
        
        List<Contact> lstUpdateContacts = new List<Contact>();
        //updating the Primary contacts for account
        for(Contact con : [select Primary__c from Contact Where AccountId <> null]) {
            con.Primary__c = true;
            lstUpdateContacts.add(con);
        }
        
        test.startTest();
        update lstUpdateContacts;
        test.stopTest();
        
        for(Contact con : [select Primary__c from Contact where AccountId <> null]) {
            system.assertEquals(true, con.Primary__c);
        }
    }
    
    /** 
    ** Name        : setPrimaryContactFailedTest
    ** Description : test case for throwing error message on updating contact
    ** Params      : 
    **/
    private static testMethod void setPrimaryContactFailedTest(){
        List<Contact> contactList = new List<Contact>();
        List<Contact> contactErrorList = new List<Contact>();
        set<Id> accountIds = new set<Id>();
        //creating another contact for same accounts
        for(Contact existingCon : [select AccountId from Contact limit 100]) {
            Contact newCon = new Contact(LastName = 'TestLName', accountId = existingCon.AccountId, Primary__c = true);
            contactList.add(newCon);    
            accountIds.add(existingCon.AccountId);
        }
        insert contactList;
        
        //try to update the Primary contact under the same account
        for(Contact con : [select Primary__c from contact where Primary__c = false and AccountId <> null]) {
            con.Primary__c = true;
            contactErrorList.add(con);
        }
        
        test.startTest();
        
        try {
            update contactErrorList;
        }catch (DMLException ex) {
            system.assertEquals(true, ex.getMessage().contains('Error : Primary contact already exist'));        
        } 
    
        test.stopTest();   
    }        
}