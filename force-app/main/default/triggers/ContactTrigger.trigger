/**
** Name        :  ContactTrigger
** Description :  Insert/Update operations on Contact
**/
trigger ContactTrigger on Contact (before insert, before update) {
    if(Trigger.new != null) {
        if(Trigger.isInsert) {
            ContactTriggerHandler.beforeInsertContact(Trigger.New);
        }
        else if(Trigger.isUpdate) {
            ContactTriggerHandler.beforeUpdateContact(Trigger.New);
        }
    }
}