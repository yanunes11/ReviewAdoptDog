trigger AdopterTrigger on Adopter__c (after insert, after update) {

    AdopterTriggerHandler handler = new AdopterTriggerHandler(Trigger.isExecuting, Trigger.size, String.valueOf(Trigger.operationType));
}