public with sharing class AdoptionServices {
    @AuraEnabled (cacheable = True)
    public static void createAdoption(Map<String, String> params) {
        System.debug('YNASC adoptionDataJson: '+params); 
        
        // Process the data here
        // System.debug('Animal ID: ' + adoptionDataList.animalId);
        // System.debug('Adopter ID: ' + adoptionDataList.adopterId);
        // System.debug('Adoption Stage: ' + adoptionDataList.adoptionStage);
    }
    
    // Inner class to represent the data structure
    public class AdoptionData {
        public String animalId { get; set; }
        public String adopterId { get; set; }
        public String adoptionStage { get; set; }
    }
}