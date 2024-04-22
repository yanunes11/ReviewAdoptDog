/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : handle the trigger for Adopter object.
    * @log : 2024/03/25 - created
*/
public with sharing class AdopterTriggerHandler implements TriggerHandlerInterface {
    private TriggerDataDTO triggerData;

    //Constructor
    public AdopterTriggerHandler(TriggerDataDTO triggerData) {
        this.triggerData = triggerData;
    }

    public void switchOperationType() {
        switch on (String) this.triggerData.getOperationType() {
            when  'AFTER_INSERT' {
                afterInsert(this.triggerData);
            }
            when else {
                afterUpdate(this.triggerData);
            }
        }
    }

    public void afterInsert(TriggerDataDTO triggerData) {
        System.debug('YNASC afterInsert');
        AdopterTriggerHelper.getAdopterNameToInsertOnAnimal(triggerData);
    }
    public void afterUpdate(TriggerDataDTO triggerData) {
        System.debug('YNASC afterUpdate');
        AdopterTriggerHelper.getAdopterNameToInsertOnAnimal(triggerData);
    }
    
    public void beforeInsert(TriggerDataDTO triggerData) {System.debug('YNASC beforeInsert');}
    public void beforeUpdate(TriggerDataDTO triggerData) {System.debug('YNASC beforeUpdate');}
    public void beforeDelete(TriggerDataDTO triggerData) {System.debug('YNASC beforeDelete');}
    public void afterDelete(TriggerDataDTO triggerData) {System.debug('YNASC afterDelete');}
    public void afterUndelete(TriggerDataDTO triggerData) {System.debug('YNASC afterUndelete');}
}