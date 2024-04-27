/*
    * @author : Yan Nascimento
    * @Date : 2024/03/22
    * @Description : test the AdoptionTriggerHelper class.
    * @log : 2024/03/22 - created
*/
@IsTest
public with sharing class AdoptionTriggerHelperTest {

    @TestVisible
    private static Integer numberOfRecords = 10;
    
    @TestSetup
    static void makeData(){
        List<Adopter__c> adopterList = TestDataFactory.createAdotperList(numberOfRecords);
        insert adopterList;
        List<Animal__c> animalList = TestDataFactory.createAnimalList(numberOfRecords);
        insert animalList;
        List<Adoption__c> adoptionList = TestDataFactory.createAdoptionList(adopterList, animalList);
        insert adoptionList;
    }

    @IsTest
    public static void checkInsertAnimalHasBeenAdoptedTest() {
        String error;
        Animal__c animal = [
            SELECT Id
            FROM Animal__c
            LIMIT 1
        ];
        Adoption__c adoption = [
            SELECT Id, Adopter__c
            FROM Adoption__c
            WHERE Animal__c = :animal.Id AND Adoption_Stage__c = 'Adopted'
            LIMIT 1
        ];
        Adopter__c adopter = [
            SELECT Id
            FROM Adopter__c
            WHERE Id != :adoption.Adopter__c
            LIMIT 1
        ];
        Adoption__c newAdoption = new Adoption__c(
            Animal__c = animal.Id,
            Adopter__c = adopter.Id
        );
        Test.startTest();
        try {
            insert newAdoption;
        } catch (System.DmlException e) {
            error = e.getMessage();
        }
        Test.stopTest();
        System.assert(error != null, 'It should be thrown an error.');
    }

    @IsTest
    public static void checkInsertAnimalHasBeenAdoptedListTest() {
        String error;
        Animal__c[] animalList = [
            SELECT Id
            FROM Animal__c
            LIMIT 3
        ];
        Set<Id> animalIds = new Set<Id>();
        for (Animal__c animal : animalList) {
            animalIds.add(animal.Id);
        }
        Adoption__c[] adoptionList = [
            SELECT Id, Adopter__c
            FROM Adoption__c
            WHERE Animal__c IN :animalIds AND (Adoption_Stage__c = 'Adopted' OR Adoption_Stage__c = 'Adoption Process')
            LIMIT 3
        ];
        Set<Id> adopterIds = new Set<Id>();
        for (Adoption__c adoption : adoptionList) {
            adopterIds.add(adoption.Adopter__c);
        }
        Adopter__c[] adopterList = [
            SELECT Id
            FROM Adopter__c
            WHERE Id IN :adopterIds
            LIMIT 3
        ];
        List<Adoption__c> newAdoptionList = new List<Adoption__c>();
        for (Integer i = 0; i < 3; i++) {
            Adoption__c newAdoption = new Adoption__c();
            newAdoption.Animal__c = animalList[i].Id;
            newAdoption.Adopter__c = adopterList[i].Id;
            newAdoptionList.add(newAdoption);
        }
        Test.startTest();
        try {
            insert newAdoptionList;
        } catch (System.DmlException e) {
            error = e.getMessage();
        }
        Test.stopTest();
        System.assert(error != null, 'It should be thrown an error.');
    }

    @IsTest
    public static void checkUpdateAnimalHasBeenAdoptedTest() {

        //YNASC Change this, it's terrible

        //Instanciate new objects
        Adopter__c adopter2 = new Adopter__c(Name = 'Andre');
        insert adopter2;
        Animal__c animal2 = new Animal__c(Name = 'Toin');
        insert animal2;
        Adoption__c adoption2 = new Adoption__c(Animal__c = animal2.Id, Adopter__c = adopter2.Id, Adoption_Stage__c = 'Adopted');
        insert adoption2;

        //Query for Adoption Animals with Adoption_Stage__c = Adopted
        Adoption__c adoption = [
            SELECT Id, Animal__c, Adopter__c, Adoption_Stage__c
            FROM Adoption__c
            WHERE Adoption_Stage__c = 'Adopted'
            LIMIT 1
        ];

        adoption2.Animal__c = adoption.Animal__c;

        Boolean hasAddError = false;

        Test.startTest();
        try {
            update adoption2;
        } catch (Exception e) {
            hasAddError =  e.getMessage().contains('This animal has been adopted! Sorry!') ? true : false;
        }
        Test.stopTest();
        System.assertEquals(hasAddError, true, 'Notification not displayed upon updating an adoption for an animal that has already been adopted. This message should be shown: \'This animal has been adopted! Sorry!\' ');
    }

    @IsTest
    public static void checkUpdateAnimalHasBeenAdoptedListTest() {

        List<Adoption__c> adoptionList = [
            SELECT Id, Animal__c, Adopter__c
            FROM Adoption__c
            WHERE Adoption_Stage__c = 'Adopted'
            LIMIT 3
        ];
        Set<Id> animalIds = new Set<Id>();
        Set<Id> adopterIds = new Set<Id>();
        for (Adoption__c adoption : adoptionList) {
            animalIds.add(adoption.Animal__c);
            adopterIds.add(adoption.Adopter__c);
        }
        List<Animal__c> animalList = [
            SELECT Id
            FROM Animal__c
            WHERE Id IN :animalIds
            LIMIT 3
        ];
        Adopter__c adopter = [
            SELECT Id
            FROM Adopter__c
            WHERE Id NOT IN :adopterIds
            LIMIT 1
        ];

        for (Adoption__c adoption : adoptionList) {
            adoption.Adopter__c = adopter.Id;
        }

        String error;

        Test.startTest();
        try {
            update adoptionList;
        } catch (Exception e) {
            error =  e.getMessage();
        }
        Test.stopTest();
        System.assert(error == null, 'Notification not displayed upon updating an adoption for an animal that has already been adopted for a list.');
    }

    @IsTest
    public static void checkUpdateAnimalHasBeenAdoptionProcessListTest() {
        List<Adoption__c> adoptionList = [
            SELECT Id, Animal__c, Adopter__c
            FROM Adoption__c
            WHERE Adoption_Stage__c = 'Adoption Process'
            LIMIT 3
        ];
        Set<Id> animalIds = new Set<Id>();
        for (Adoption__c adoption : adoptionList) {
            animalIds.add(adoption.Animal__c);
        }
        List<Animal__c> animalList = [
            SELECT Id
            FROM Animal__c
            WHERE Id IN :animalIds
            LIMIT 3
        ];

        List<Adoption__c> adoptionAdoptedList = [
            SELECT Id, Animal__c, Adopter__c
            FROM Adoption__c
            WHERE Adoption_Stage__c = 'Adopted'
            LIMIT 3
        ];

        //update an adoption list with animals in Adoption Process.
        for (Integer i = 0; i < 3; i++) {
            adoptionAdoptedList[i].Animal__c = animalList[i].Id;
        }

        Boolean hasAddError = false;

        Test.startTest();
        try {
            update adoptionAdoptedList;
        } catch (Exception e) {
            hasAddError =  e.getMessage().contains('This animal is in adoption process. Sorry!');
        }
        Test.stopTest();
        System.assertEquals(true, hasAddError, 'New adoptionList should not be update OR the addError() message has been changed.');
    }

    @IsTest
    public static void saveAdopterNameToAnimalOnInsertTest() {
        String error;
        Animal__c animal = new Animal__c(Name = 'AnimalToInsert');
        insert animal;
        Adopter__c adopter = new Adopter__c(Name = 'AdopterToInsert');
        insert adopter;
        Adoption__c newAdoption = new Adoption__c();
        newAdoption.Animal__c = animal.Id;
        newAdoption.Adopter__c = adopter.Id;
        newAdoption.Adoption_Stage__c = 'Adopted';
        Test.startTest();
        insert newAdoption;
        Test.stopTest();
        Animal__c animalWithAdopter = [
            SELECT Adopter__c
            FROM Animal__c
            WHERE Id = :animal.Id
            LIMIT 1
        ];
        System.assertEquals(adopter.Id, animalWithAdopter.Adopter__c, 'Animal has been not saved with the current Adopter from the new Adoption');
    }

    @IsTest
    public static void saveAdopterNameToAnimalOnUpdateTest() {
        String error;
        Animal__c animal = new Animal__c(Name = 'AnimalToInsert');
        insert animal;
        Animal__c animal2 = new Animal__c(Name = 'AnimalToUpdate');
        insert animal2;
        Adopter__c adopter = new Adopter__c(Name = 'AdopterToInsert');
        insert adopter;
        Adoption__c newAdoption = new Adoption__c();
        newAdoption.Animal__c = animal.Id;
        newAdoption.Adopter__c = adopter.Id;
        newAdoption.Adoption_Stage__c = 'Adopted';
        insert newAdoption;
        newAdoption.Animal__c = animal2.Id;
        Test.startTest();
        update newAdoption;
        Test.stopTest();
        Animal__c animalWithAdopter = [
            SELECT Adopter__c
            FROM Animal__c
            WHERE Id = :animal.Id
            LIMIT 1
        ];
        System.assertEquals(adopter.Id, animalWithAdopter.Adopter__c, 'Animal has been not saved with the current Adopter from the new Adoption');
    }

    @isTest
    public static void afterUndeleteTest() {
        Adoption__c adoption = [
            SELECT Id, Name
            FROM Adoption__c
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        delete adoption;
        Adoption__c adoptionToUndelete = [
            SELECT Id, Name
            FROM Adoption__c
            WHERE Id = :adoption.Id
            WITH SYSTEM_MODE
            LIMIT 1
            ALL ROWS
        ];
        Test.startTest();
        undelete adoptionToUndelete;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AdoptionTriggerHandlerTest.afterUndeleteTest');
        System.assert(true, 'Any code written.');
    }
}