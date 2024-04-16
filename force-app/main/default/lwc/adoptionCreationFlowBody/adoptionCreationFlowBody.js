import { LightningElement, api, track } from 'lwc';
import animalInformation from '@salesforce/apex/AnimalQueries.getAnimalInformationById';
import adopterInformation from '@salesforce/apex/AdopterQueries.getAdopterInformationById';
import animalListInformation from '@salesforce/apex/AnimalQueries.getAvailableAnimalList';

export default class AdoptionCreationFlowBody extends LightningElement {
    @api animalId = '';
    adopterId = 'a03aj000001LRskAAG';
    @api animal;
    animalObjectFields = [];
    adopterObjectFields = [];
    error;
    @track objectsMap = {};
    @track objectsList = [];
    connectedCallback() {
        this.getAnimalList();
        //YNASC Delete these functions. It should be invoked by the choosing the animal and adopter in the list
        // this.getAnimalInformation(this.animalId);
        // this.getAdopterInformation(this.adopterId);
    }

    async getAnimalList() {
        try {
            let objectsMapAux = [];
            objectsMapAux = await animalListInformation();
            this.objectsMap = JSON.parse(JSON.stringify(objectsMapAux));
            this.objectsList = Object.values(this.objectsMap);
        } catch (error) {
            this.error = error;
        }
    }

    handleRecordSelected(event) {
        // console.log('YNASC event.detail: '+event.detail);
        this.animalId = event.detail;
        // console.log('YNASC this.animalId: '+this.animalId);
        this.getAnimalInformation(this.animalId);
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