trigger AdoptionTrigger on Adoption__c (after insert, after update) {
    Map<String, List<Adoption__c>> newOldValues = new Map<String, List<Adoption__c>>();
    newOldValues.put('new', Trigger.new);
    newOldValues.put('old', Trigger.old);
    Map<String, Map<Id, Adoption__c>> newOldValuesMap = new Map<String, Map<Id, Adoption__c>>();
    newOldValuesMap.put('newMap', Trigger.newMap);
    newOldValuesMap.put('oldMap', Trigger.oldMap);

    AdoptionTriggerHandler handler = new AdoptionTriggerHandler(String.valueOf(Trigger.operationType), newOldValues, newOldValuesMap);
    handler.switchOperationType();
}