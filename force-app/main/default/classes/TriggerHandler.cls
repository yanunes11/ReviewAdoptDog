public interface TriggerHandler {
    void beforeInsert(List<SObject> newRecords);
    void beforeUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap);
    void beforeDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);
    void afterInsert(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
    void afterUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap);
    void afterDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);
    void afterUndelete(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
}