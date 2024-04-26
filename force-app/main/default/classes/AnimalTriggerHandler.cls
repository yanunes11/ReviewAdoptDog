/*
    * @author : Yan Nascimento
    * @Date : 2024/04/23
    * @Description : handle the trigger for Animal object.
    * @log : 2024/04/23 - created
*/
public with sharing class AnimalTriggerHandler implements TriggerHandlerInterface {
    private TriggerDataDTO triggerData;

    public AnimalTriggerHandler(TriggerDataDTO triggerData) {
        this.triggerData = triggerData;
    }

    public void switchOperationType() {
        Boolean triggerEnabled = this.isTriggersEnabled();
        if (triggerEnabled) {            
            switch on (String) triggerData.getOperationType() {
                when 'BEFORE_INSERT' {
                    beforeInsert(this.triggerData);
                } 
                when 'AFTER_INSERT' {
                    afterInsert(this.triggerData);
                }
                when 'BEFORE_UPDATE' {
                    beforeUpdate(this.triggerData);
                }
                when 'AFTER_UPDATE' {
                    afterUpdate(this.triggerData);
                }
                when 'BEFORE_DELETE' {
                    beforeDelete(this.triggerData);
                }
                when 'AFTER_DELETE' {
                    beforeDelete(this.triggerData);
                }
                when else {
                    System.debug('Operation Type: '+(String) triggerData.getOperationType());
                    System.debug('Please, create this operation in your code.');
                }
            }
        } else {
            System.debug('Triggers Deactivated on Custom Metadata.');
        }
    }

    public Boolean isTriggersEnabled() {
        Trigger_Setting__mdt triggerSetting = [
            SELECT isEnabled__c
            FROM Trigger_Setting__mdt
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        return triggerSetting.isEnabled__c;
    }
    
    public void beforeInsert(TriggerDataDTO triggerData) {
        AnimalTriggerHelper.avoidCreateAdopterDirectlyOnAnimal(triggerData);
    }
    public void beforeUpdate(TriggerDataDTO triggerData) {
        AnimalTriggerHelper.avoidCreateAdopterDirectlyOnAnimal(triggerData);
    }
    public void afterInsert(TriggerDataDTO triggerData) {System.debug('YNASC afterInsert');}
    public void afterUpdate(TriggerDataDTO triggerData) {System.debug('YNASC afterUpdate');}
    public void beforeDelete(TriggerDataDTO triggerData) {System.debug('YNASC beforeDelete');}
    public void afterDelete(TriggerDataDTO triggerData) {System.debug('YNASC afterDelete');}
    public void afterUndelete(TriggerDataDTO triggerData) {System.debug('YNASC afterUndelete');}
}