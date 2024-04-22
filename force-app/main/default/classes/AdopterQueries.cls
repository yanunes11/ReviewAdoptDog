/*
    * @author : Yan Nascimento
    * @Date : 2024/03/22
    * @Description : centralized class to created Adopter Queries.
    * @log : 2024/03/22 - created
*/
public with sharing class AdopterQueries {

    @AuraEnabled
    public static Adopter__c getAdopterInformationById(String adopterId){
        Adopter__c adopter = [
            SELECT Id, Name
            FROM Adopter__c
            WHERE Id = :Id.valueOf(adopterId)
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        return adopter;
    }

    @AuraEnabled (cacheable = true)
    public static Map<String, FieldProperty> getAvailableAdopterList(){
        Map<String, FieldProperty> adopterPropertyMap = new Map<String, FieldProperty>();
        try {
            List<Adopter__c> adopterList = [
                SELECT Id, Name
                FROM Adopter__c
                WITH SYSTEM_MODE
            ];
            for (Adopter__c adopter : adopterList) {
                FieldProperty fieldProperty = new FieldProperty();
                fieldProperty.id = adopter.Id;
                fieldProperty.name = adopter.Name;
                adopterPropertyMap.put(adopter.Name, fieldProperty);
            }
            return adopterPropertyMap;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class FieldProperty {
        @AuraEnabled public string id {get; set;}
        @AuraEnabled public string name {get; set;}
    }
}