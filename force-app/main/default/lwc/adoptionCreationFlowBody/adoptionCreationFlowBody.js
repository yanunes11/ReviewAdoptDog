import { LightningElement, api } from 'lwc';
import animalInformation from '@salesforce/apex/AnimalQueries.getAnimalInformationById';
import adopterInformation from '@salesforce/apex/AdopterQueries.getAdopterInformationById';

export default class AdoptionCreationFlowBody extends LightningElement {
    animalId = 'a00aj000006C4GMAA0';
    adopterId = 'a03aj000001LRskAAG';
    @api animal;
    animalObjectFields = [];
    adopterObjectFields = [];
    error;
    connectedCallback() {

        //YNASC Delete these functions. It should be invoked by the choosing the animal and adopter in the list
        this.getAnimalInformation(this.animalId);
        this.getAdopterInformation(this.adopterId);
    }

    getAnimalInformation(animalId) {
        let animal = [];
        animalInformation({animalId: animalId})
        .then((result) => {
            for (let key in result) {
                if (key !== 'Id') {
                    let cleanKey = key.replace("__c", "").replace("_", " ");
                    let animaObject = {'fieldName': cleanKey, 'value': result[key]};
                    animal.push(animaObject);
                }
            }
            this.animalObjectFields = animal;
        })
        .catch((error) => {
            console.log('YNASC error: '+JSON.stringify(error));
        })
    }

    getAdopterInformation(adopterId) {        let adopter = [];
        adopterInformation({adopterId: adopterId})
        .then((result) => {

            for (let key in result) {
                if (key !== 'Id') {
                    let cleanKey = key.replace("__c", "").replace("_", " ");
                    let adopterObject = {'fieldName': cleanKey, 'value': result[key]};
                    adopter.push(adopterObject);
                }
            }
            this.adopterObjectFields = adopter;
        })
        .catch((error) => {
            console.log('YNASC error: '+JSON.stringify(error));
        })
    }

}