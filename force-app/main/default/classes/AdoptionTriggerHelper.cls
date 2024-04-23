/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : handle the trigger for Adoption object.
    * @log : 2024/03/25 - created
*/
public with sharing class AdoptionTriggerHelper {

    //check the animal status "Adopted" or "Adoption Process" by someone during insert.
    public static void checkInsertAnimalHasBeenAdopted(TriggerDataDTO triggerData) {
        List<Adoption__c> newAdoptionList = triggerData.getNewValues();
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
    public static void checkUpdateAnimalHasBeenAdopted(TriggerDataDTO triggerData) {
        System.debug('YNASC triggerData: '+triggerData);
        List<Adoption__c> newAdoptionList = (List<Adoption__c>) triggerData.getNewValues();
        List<Adoption__c> oldAdoptionList = (List<Adoption__c>) triggerData.getOldValues();
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

    public static void saveAdopterNameToAnimal(TriggerDataDTO triggerData) {
        List<Adoption__c> newAdoptionList = (List<Adoption__c>) triggerData.getNewValues();
        List<Animal__c> animalToUpdate = new List<Animal__c>();
        for (Adoption__c newAdoption : newAdoptionList) {
            Animal__c animal = new Animal__c();
            animal.Id = newAdoption.Animal__c;
            animal.Adopter__c = newAdoption.Adopter__c;
            animalToUpdate.add(animal);
        }

        if (Schema.sObjectType.Animal__c.fields.Adopter__c.isUpdateable()) {
            update animalToUpdate;
        }
    }
}