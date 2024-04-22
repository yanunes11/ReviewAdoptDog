/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : trigger for the adoption object.
    * @log : 2024/03/25 - created
*/
trigger AdoptionTrigger on Adoption__c (before insert, before update, after insert, after update, before delete, after delete, after undelete) {

    TriggerDataDTO triggerData = new TriggerDataDTO.Builder()
        .setNewValues(Trigger.new)
        .setOldValues(Trigger.old)
        .setMapNew(Trigger.newMap)
        .setMapOld(Trigger.oldMap)
        .setOperationType(String.valueOf(Trigger.operationType))
        .build();

    AdoptionTriggerHandler handler = new AdoptionTriggerHandler(triggerData);
    handler.switchOperationType();
}