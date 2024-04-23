/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : handle the trigger for Adoption object.
    * @log : 2024/03/25 - created
*/
public with sharing class AdoptionTriggerHandler implements TriggerHandlerInterface {
    private TriggerDataDTO triggerData;

    public AdoptionTriggerHandler(TriggerDataDTO triggerData) {
        this.triggerData = triggerData;
        System.debug('YNASC this.triggerData: '+this.triggerData);
    }

    public void switchOperationType() {
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
                System.debug('Please, create this operation in oyour code.');
            }
        }
    }

    public void beforeInsert(TriggerDataDTO triggerData) {
        System.debug('YNASC beforeInsert');
        AdoptionTriggerHelper.checkInsertAnimalHasBeenAdopted(triggerData);
    }
    public void beforeUpdate(TriggerDataDTO triggerData){
        System.debug('YNASC beforeUpdate');
        AdoptionTriggerHelper.checkUpdateAnimalHasBeenAdopted(triggerData);
    }
    public void afterUpdate(TriggerDataDTO triggerData){
        AdoptionTriggerHelper.saveAdopterNameToAnimal(triggerData);
    }
    public void afterInsert(TriggerDataDTO triggerData){
        AdoptionTriggerHelper.saveAdopterNameToAnimal(triggerData);
        
    }
    
    public void beforeDelete(TriggerDataDTO triggerData){System.debug('YNASC beforeDelete');}
    public void afterDelete(TriggerDataDTO triggerData){System.debug('YNASC afterDelete');}
    public void afterUndelete(TriggerDataDTO triggerData){System.debug('YNASC afterUndelete');}
}