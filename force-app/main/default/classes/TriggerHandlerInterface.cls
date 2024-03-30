/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : interface to handle all the triggers.
    * @log : 2024/03/25 - created
*/
public interface TriggerHandlerInterface {
    void beforeInsert(List<SObject> newRecords);
    void beforeUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap);
    void beforeDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);
    void afterInsert(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
    void afterUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap);
    void afterDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);
    void afterUndelete(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
}