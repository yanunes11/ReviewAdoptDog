/*
    * @author : Yan Nascimento
    * @Date : 2024/03/22
    * @Description : centralized class to created Animal Queries.
    * @log : 2024/03/22 - created
*/
public with sharing class AnimalQueries {

    @AuraEnabled (cacheable = true)
    public static Animal__c getAnimalInformationById(String animalId) {
        Animal__c animal = [
            SELECT Id, Name, Adopter_Name__c
            FROM Animal__c
            WHERE Id = :Id.valueOf(animalId)
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        return animal;
    }

    @AuraEnabled (cacheable = true)
    public static Map<String, FieldProperty> getAvailableAnimalList(){
        Map<String, FieldProperty> animalPropertyMap = new Map<String, FieldProperty>();
        try {
            List<Animal__c> animalList = [
                SELECT Id, Name, Adopter_Name__c
                FROM Animal__c
                WITH SYSTEM_MODE
            ];
            for (Animal__c animal : animalList) {
                FieldProperty fieldProperty = new FieldProperty();
                fieldProperty.id = animal.Id;
                fieldProperty.name = animal.Name;
                animalPropertyMap.put(animal.Name, fieldProperty);
            }
            return animalPropertyMap;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class FieldProperty {
        @AuraEnabled public string id {get; set;}
        @AuraEnabled public string name {get; set;}
    }
}