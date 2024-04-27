/*
    * @author : Yan Nascimento
    * @Date : 2024/03/26
    * @Description : creates records for testing purposes.
    * @log : 2024/03/22 - created
*/
@IsTest
public with sharing class TestDataFactory {

    public static List<Adopter__c> createAdotperList(Integer numberOfAdopters) {
        List<Adopter__c> adopterList = new List<Adopter__c>();
        for (Integer i = 0; i < numberOfAdopters; i++) {
            Adopter__c adopter = new Adopter__c();
            adopter.Name = 'Aldo ' + i;
            adopterList.add(adopter);
        }
        return adopterList;
    }
    public static List<Animal__c> createAnimalList(Integer numberOfAnimals) {
        List<Animal__c> animalList = new List<Animal__c>();
        for (Integer i = 0; i < numberOfAnimals; i++) {
            Animal__c animal = new Animal__c();
            animal.Name = 'Lucas '+ i;
            animalList.add(animal);
        }
        return animalList;
    }
    public static List<Adoption__c> createAdoptionList(List<Adopter__c> adopterList, List<Animal__c> animalList) {
        List<Adoption__c> adoptionList = new List<Adoption__c>();
            for (Integer i = 0; i < adopterList.Size(); i++) {
                Adoption__c adoption = new Adoption__c();
                adoption.Animal__c = animalList[i].Id;
                adoption.Adopter__c = adopterList[i].Id;
                if (Math.mod(i, 2) == 0) {
                    adoption.Adoption_Stage__c = 'Adopted';
                } else {
                    adoption.Adoption_Stage__c = 'Adoption Process';
                }
                adoptionList.add(adoption);
            }
            return adoptionList;
    }
}