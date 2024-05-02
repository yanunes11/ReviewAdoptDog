/*
    * @author : Yan Nascimento
    * @Date : 2024/04/30
    * @Description : centralized class to created Adoption Queries.
    * @log : 2024/04/30 - created
*/
public with sharing class AdoptionQueries {

    @AuraEnabled (cacheable = true)
    public static Map<String, String> retrieveAdoptionStageInfo(){
        schema.DescribeFieldResult adoptionStages = schema.SObjectType.Adoption__c.fields.Adoption_Stage__c.getsObjectField().getDescribe();
        Map<String, String> adoptionStagesMap = new Map<String, String>();
        for (PicklistEntry ent : adoptionStages.getPicklistValues()) {
            if (ent.isActive()) {
                adoptionStagesMap.put(ent.getLabel(), ent.getValue());
            }
        }
        return adoptionStagesMap;
    }
}