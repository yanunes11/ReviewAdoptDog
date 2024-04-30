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
            SELECT Id, Name
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
        List<Adoption__c> adoptionList = [
            SELECT Animal__c, Adoption_Stage__c
            FROM Adoption__c
            WHERE Adoption_Stage__c = 'Adoption Process' OR Adoption_Stage__c = 'Adopted'
            WITH SYSTEM_MODE
        ];
        Set<Id> animalIds = new Set<Id>();
        for (Adoption__c adoption : adoptionList) {
            animalIds.add(adoption.Animal__c);
        }
        List<Animal__c> animalList = [
            SELECT Id, Name, Adopter__c
            FROM Animal__c
            WHERE Id NOT IN :animalIds
            WITH SYSTEM_MODE
        ];
        for (Animal__c animal : animalList) {
            FieldProperty fieldProperty = new FieldProperty();
            fieldProperty.id = animal.Id;
            fieldProperty.name = animal.Name;
            animalPropertyMap.put(animal.Name, fieldProperty);
        }
        return animalPropertyMap;
    }

    public class FieldProperty {
        @AuraEnabled public string id {get; set;}
        @AuraEnabled public string name {get; set;}
    }
}