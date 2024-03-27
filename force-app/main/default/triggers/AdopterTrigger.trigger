trigger AdopterTrigger on Adopter__c (after insert, after update) {

    Map<String, List<Adopter__c>> newOldValues = new Map<String, List<Adopter__c>>();
    newOldValues.put('new', Trigger.new);
    newOldValues.put('old', Trigger.old);
    Map<String, Map<Id, Adopter__c>> newOldValuesMap = new Map<String, Map<Id, Adopter__c>>();
    newOldValuesMap.put('newMap', Trigger.newMap);
    newOldValuesMap.put('oldMap', Trigger.oldMap);

    AdopterTriggerHandler handler = new AdopterTriggerHandler(String.valueOf(Trigger.operationType), newOldValues, newOldValuesMap);
}