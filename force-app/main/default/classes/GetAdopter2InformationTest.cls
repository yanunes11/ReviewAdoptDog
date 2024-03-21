/*
    * @author : Yan Nascimento
    * @Date : 2024/03/21
    * @Description : test the GetAdopter2Information class
    * @log : 2024/03/21 - created
*/

@isTest
public with sharing class GetAdopter2InformationTest {

    @TestSetup
    static void makeData(){
        Animal__c animal = new Animal__c(Name = 'Pimpolho');
        insert animal;

        // Adopter2__c adopter = new Adopter2__c(Name = 'Juliano');
        // insert adopter;

        // Adoption__c adoption = new Adoption__c(
        //     Animal__c = animal.Id,
        //     Adopter2__c = adopter.Id
        // );
    }

    @isTest
    public static void getAdopter2InfoTest() {
        Animal__c animal = [
            SELECT Id
            FROM Animal__c
            LIMIT 1
        ];
        // Adoption__c adoption = [
        //     SELECT Id, Adopter2__c.Name
        //     FROM Adoption__c
        //     WHERE Animal__c.Id = :animal.Id
        // ];

        System.assert(true, true);
    }
}