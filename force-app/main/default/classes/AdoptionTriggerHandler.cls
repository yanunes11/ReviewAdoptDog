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
            when 'BEFORE_UPDATE' {
                beforeUpdate(this.triggerData);
            }
            when else {
                System.debug('when else');
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
    public void beforeDelete(TriggerDataDTO triggerData){System.debug('YNASC beforeDelete');}
    public void afterInsert(TriggerDataDTO triggerData){System.debug('YNASC afterInsert');}
    public void afterUpdate(TriggerDataDTO triggerData){System.debug('YNASC afterUpdate');}
    public void afterDelete(TriggerDataDTO triggerData){System.debug('YNASC afterDelete');}
    public void afterUndelete(TriggerDataDTO triggerData){System.debug('YNASC afterUndelete');}
}