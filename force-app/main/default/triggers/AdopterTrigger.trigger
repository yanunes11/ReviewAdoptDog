/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : trigger for Adopter object.
    * @log : 2024/03/25 - created
*/
trigger AdopterTrigger on Adopter__c (after insert, after update) {

    TriggerDataDTO triggerData = new TriggerDataDTO.Builder()
        .setNewValues(Trigger.new)
        .setOldValues(Trigger.old)
        .setMapNew(Trigger.newMap)
        .setMapOld(Trigger.oldMap)
        .setOperationType(String.valueOf(Trigger.operationType))
        .build();

    AdopterTriggerHandler handler = new AdopterTriggerHandler(triggerData);
    handler.switchOperationType();
}