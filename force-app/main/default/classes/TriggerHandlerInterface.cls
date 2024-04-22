/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : interface to handle all the triggers.
    * @log : 2024/03/25 - created
*/
public interface TriggerHandlerInterface {
    void beforeInsert(TriggerDataDTO triggerData);
    void beforeUpdate(TriggerDataDTO triggerData);
    void beforeDelete(TriggerDataDTO triggerData);
    void afterInsert(TriggerDataDTO triggerData);
    void afterUpdate(TriggerDataDTO triggerData);
    void afterDelete(TriggerDataDTO triggerData);
    void afterUndelete(TriggerDataDTO triggerData);
}