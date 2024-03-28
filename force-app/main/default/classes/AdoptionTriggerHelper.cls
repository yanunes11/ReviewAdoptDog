public with sharing class AdoptionTriggerHelper {

    //check if the animal has been adopted by someone.
    public static void checkAnimalHasBeenAdopted(List<Adoption__c> newAdoptionList) {
        System.debug('YNASC newAdoptionList: '+newAdoptionList);
        Set<Id> animalIds = new Set<Id>();
        for (Adoption__c newAdoption : newAdoptionList) {
            Id animalId = newAdoption.Animal__c;
            animalIds.add(animalId);
        }
        List<Adoption__c> adoptedList = [
            SELECT Id, Animal__c,Adoption_Stage__c
            FROM Adoption__c
            WHERE Animal__c IN :animalIds AND Adoption_Stage__c = 'Adopted'
            WITH SYSTEM_MODE
        ];

        List<Adoption__c> adoptionInProcessList = [
            SELECT Id, Animal__c,Adoption_Stage__c
            FROM Adoption__c
            WHERE Animal__c IN :animalIds AND Adoption_Stage__c = 'Adoption Process'
            WITH SYSTEM_MODE
        ];

        if (!adoptedList.isEmpty()) {
            for (Adoption__c adoption : newAdoptionList) {
                adoption.Animal__c.addError('This animal has been adopted! Sorry!');
            }
        }

        if (!adoptionInProcessList.isEmpty()) {
            for (Adoption__c adoption : newAdoptionList) {
                adoption.Animal__c.addError('This animal is in adoption process! Sorry!');
            }
        }

    }
    public static void getAnimalId(Id adoptionId) {
        System.debug('');
    }
}