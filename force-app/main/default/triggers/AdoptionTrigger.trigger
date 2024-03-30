/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : trigger for the adoption object.
    * @log : 2024/03/25 - created
*/
trigger AdoptionTrigger on Adoption__c (before insert, before update, after insert, after update) {
    Map<String, List<Adoption__c>> newOldValues = new Map<String, List<Adoption__c>>();
    newOldValues.put('new', Trigger.new);
    newOldValues.put('old', Trigger.old);
    Map<String, Map<Id, Adoption__c>> newOldValuesMap = new Map<String, Map<Id, Adoption__c>>();
    newOldValuesMap.put('newMap', Trigger.newMap);
    newOldValuesMap.put('oldMap', Trigger.oldMap);

    AdoptionTriggerHandler handler = new AdoptionTriggerHandler(String.valueOf(Trigger.operationType), newOldValues, newOldValuesMap);
    handler.switchOperationType();
}