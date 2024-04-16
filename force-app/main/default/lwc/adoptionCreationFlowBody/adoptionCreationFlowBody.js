import { LightningElement, api, track } from 'lwc';
import animalInformation from '@salesforce/apex/AnimalQueries.getAnimalInformationById';
import adopterInformation from '@salesforce/apex/AdopterQueries.getAdopterInformationById';
import animalListInformation from '@salesforce/apex/AnimalQueries.getAvailableAnimalList';
import adopterListInformation from '@salesforce/apex/AdopterQueries.getAvailableAdopterList';

export default class AdoptionCreationFlowBody extends LightningElement {
    @api animalId = '';
    @api adopterId = '';
    @api animal;
    animalObjectFields = [];
    adopterObjectFields = [];
    error;
    @track objectsAnimalMap = {};
    @track objectsAnimalList = [];
    @track objectsAdopterMap = {};
    @track objectsAdopterList = [];
    connectedCallback() {
        this.getAnimalList();
        this.getAdopterList();
    }

    async getAnimalList() {
        try {
            let objectsMapAux = [];
            objectsMapAux = await animalListInformation();
            this.objectsAnimalMap = JSON.parse(JSON.stringify(objectsMapAux));
            this.objectsAnimalList = Object.values(this.objectsAnimalMap);
        } catch (error) {
            this.error = error;
        }
    }

    async getAdopterList() {
        try {
            let objectsMapAux = [];
            objectsMapAux = await adopterListInformation();
            this.objectsAdopterMap = JSON.parse(JSON.stringify(objectsMapAux));
            this.objectsAdopterList = Object.values(this.objectsAdopterMap);
        } catch (error) {
            this.error = error;
        }
    }

    handleAnimalSelected(event) {
        this.animalId = event.detail;
        this.getAnimalInformation(this.animalId);
    }

    handleAdopterSelected(event) {
        this.adopterId = event.detail;
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

    getAdopterInformation(adopterId) {        
        let adopter = [];
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