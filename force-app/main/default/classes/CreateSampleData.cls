/*
    * @author : Yan Nascimento
    * @Date : 2024/04/23
    * @Description : create sample data.
    * @log : 2024/04/23 - created
*/
@IsTest
public with sharing class CreateSampleData {

    public static void createAllSampleData() {
        List<Animal__c> animalList = createAnimalList();
        if (Schema.sObjectType.Animal__c.isCreateable() || Schema.sObjectType.Animal__c.isUpdateable()) {
            upsert animalList;
        }
        List<Adopter__c> adopterList = createAdopterList();
        if (Schema.sObjectType.Adopter__c.isCreateable() || Schema.sObjectType.Adopter__c.isUpdateable()) {
            upsert adopterList;
        }
    }

    public static List<Animal__c> createAnimalList() {
        List<Animal__c> animalListToCreate = new List<Animal__c>();
        Animal__c animal1 = new Animal__c(Name = 'Pinduca');
        Animal__c animal2 = new Animal__c(Name = 'Caramelo');
        Animal__c animal3 = new Animal__c(Name = 'Aya');
        Animal__c animal4 = new Animal__c(Name = 'Lulu');
        Animal__c animal5 = new Animal__c(Name = 'Mel');
        Animal__c animal6 = new Animal__c(Name = 'Biscoito');
        Animal__c animal7 = new Animal__c(Name = 'Coragem');
        Animal__c animal8 = new Animal__c(Name = 'Chico');
        Animal__c animal9 = new Animal__c(Name = 'Lina');
        Animal__c animal10 = new Animal__c(Name = 'Paola');
        animalListToCreate.add(animal1);
        animalListToCreate.add(animal2);
        animalListToCreate.add(animal3);
        animalListToCreate.add(animal4);
        animalListToCreate.add(animal5);
        animalListToCreate.add(animal6);
        animalListToCreate.add(animal7);
        animalListToCreate.add(animal8);
        animalListToCreate.add(animal9);
        animalListToCreate.add(animal10);

        return animalListToCreate;
    }

    public static List<Adopter__c> createAdopterList() {
        List<Adopter__c> adopterListToCreate = new List<Adopter__c>();
        Adopter__c adopter1 = new Adopter__c(Name = 'Carlos');
        Adopter__c adopter2 = new Adopter__c(Name = 'Aldemir');
        Adopter__c adopter3 = new Adopter__c(Name = 'Juliana');
        Adopter__c adopter4 = new Adopter__c(Name = 'Luana');
        Adopter__c adopter5 = new Adopter__c(Name = 'Amannda');
        Adopter__c adopter6 = new Adopter__c(Name = 'Douglas');
        Adopter__c adopter7 = new Adopter__c(Name = 'Carol');
        Adopter__c adopter8 = new Adopter__c(Name = 'Creuza');
        Adopter__c adopter9 = new Adopter__c(Name = 'Luciana');
        Adopter__c adopter10 = new Adopter__c(Name = 'Adalberto');
        adopterListToCreate.add(adopter1);
        adopterListToCreate.add(adopter2);
        adopterListToCreate.add(adopter3);
        adopterListToCreate.add(adopter4);
        adopterListToCreate.add(adopter5);
        adopterListToCreate.add(adopter6);
        adopterListToCreate.add(adopter7);
        adopterListToCreate.add(adopter8);
        adopterListToCreate.add(adopter9);
        adopterListToCreate.add(adopter10);

        return adopterListToCreate;
    }
}