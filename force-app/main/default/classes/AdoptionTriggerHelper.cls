/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : handle the trigger for Adoption object.
    * @log : 2024/03/25 - created
*/
public with sharing class AdoptionTriggerHelper {

    //check the animal status "Adopted" or "Adoption Process" by someone during insert.
    public static void checkInsertAnimalHasBeenAdopted(List<Adoption__c> newAdoptionList) {
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

    //check the animal status "Adopted" or "Adoption Process" by someone during update.
    public static void checkUpdateAnimalHasBeenAdopted(Map<String, List<Adoption__c>> newOldAdoptions, Map<String, Map<Id, Adoption__c>> newOldAdoptionsMap) {
        System.debug('YNASC newAdoptionList: '+newOldAdoptionsMap);
        List<Adoption__c> newAdoptionList = newOldAdoptions.get('new');
        List<Adoption__c> oldAdoptionList = newOldAdoptions.get('old');
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

        //Test if the animal has been adopted
        if (!adoptedList.isEmpty()) {
            for (Integer i = 0; i < newAdoptionList.Size(); i++) {
                if (newAdoptionList[i].Animal__c != oldAdoptionList[i].Animal__c) {
                    newAdoptionList[i].Animal__c.addError('This animal has been adopted! Sorry!');
                }
            }
        }

        //Test if the animal is In Process
        if (!adoptionInProcessList.isEmpty()) {
            for (Integer i = 0 ; i < newAdoptionList.Size(); i++) {
                if (newAdoptionList[i].Animal__c != oldAdoptionList[i].Animal__c) {
                    newAdoptionList[i].Animal__c.addError('This animal is in adoption process. Sorry!');
                }
            }
        }

    }
    public static void getAnimalId(Id adoptionId) {
        System.debug('');
    }
}