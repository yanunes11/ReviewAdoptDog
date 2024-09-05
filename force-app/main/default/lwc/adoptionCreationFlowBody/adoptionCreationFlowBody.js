import { LightningElement, api, track } from 'lwc';
import animalInformation from '@salesforce/apex/AnimalQueries.getAnimalInformationById';
import adopterInformation from '@salesforce/apex/AdopterQueries.getAdopterInformationById';
import animalListInformation from '@salesforce/apex/AnimalQueries.getAvailableAnimalList';
import adopterListInformation from '@salesforce/apex/AdopterQueries.getAvailableAdopterList';
import IMAGE_ADOPTER from "@salesforce/resourceUrl/adopterDefaultImage";
import IMAGE_DOG from "@salesforce/resourceUrl/dogDefaultImage";

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
    @track isModalOpen = false;
    @track showCreateAdoptionButton = false;
    refreshAll = false;
    dogImage = IMAGE_DOG;
    adopterImage = IMAGE_ADOPTER;
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
        if (this.animalId !== '' && this.adopterId !== '') {
            this.showCreateAdoptionButton = true;
        }
    }

    handleAdopterSelected(event) {
        this.adopterId = event.detail;
        this.getAdopterInformation(this.adopterId);
        if (this.animalId !== '' && this.adopterId !== '') {
            this.showCreateAdoptionButton = true;
        }
    }

    handleRecordUnselection(event) {
        switch (event.detail.recordid) {
            case this.animalId:
                this.animalId = '';
                break;
        
            default:
                this.adopterId = '';
                break;
        }
        this.showCreateAdoptionButton = event.detail.unselected === true? false : true;
    }

    createAdoptionOnClick() {
        this.isModalOpen = true;
    }

    handleCloseModal(event) {
        this.isModalOpen = event.detail;
    }

    async handleRefreshAnimalAndAdopterlist(event) {
        console.log('YNASC Refresh data in parent');
        this.refreshAll = true;
        this.animalId = '';
        this.adopterId = '';
        this.objectsAnimalMap = {};
        this.objectsAnimalList = [];
        this.objectsAdopterMap = {};
        this.objectsAdopterList = [];
        this.animalObjectFields = [];
        this.adopterObjectFields = [];
        await this.getAnimalList();
        await this.getAdopterList();
    }

    // Retrieve animal information to show in the Animal card
    async getAnimalInformation(animalId) {
        try {
            let animal = [];
            let result = await animalInformation({animalId: animalId});
            for (let key in result) {
                if (key !== 'Id') {
                    let cleanKey = key.replace("__c", "").replace("_", " ");
                    let animaObject = {'fieldName': cleanKey, 'value': result[key]};
                    animal.push(animaObject);
                }
            }
            this.animalObjectFields = animal;
        } catch (error) {
            this.error = error;
        }
    }

    // Retrieve adopter information to show in the Adopter card
    async getAdopterInformation(adopterId) {
        try {
            let adopter = [];
            let result = await adopterInformation({adopterId: adopterId});
            for (let key in result) {
                if (key !== 'Id') {
                    let cleanKey = key.replace("__c", "").replace("_", " ");
                    let adopterObject = {'fieldName': cleanKey, 'value': result[key]};
                    adopter.push(adopterObject);
                }
            }
            this.adopterObjectFields = adopter;
        } catch (error) {
            this.error = error;
        }
    }

}