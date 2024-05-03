import { LightningElement, api, track } from 'lwc';
import adoptionOptionList from '@salesforce/apex/AdoptionQueries.retrieveAdoptionStageInfo';

export default class CreateAdoptionModal extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @api isModalOpen = false;
    @api animalId = '';
    @api adopterId = '';
    @api animalFields = {};
    @api adopterFields = {};
    @track animalName = '';
    @track adopterName = '';
    @track stageOptionsMap = []; // [{"id":"BacktoShelter","value":"Back to Shelter"},{"id":"AdoptionProcess","value":"Adoption Process"},{"id":"Adopted","value":"Adopted"}]

    connectedCallback() {
        if (this.isModalOpen) {
            this.animalName = this.animalFields[0].value;
            this.adopterName = this.adopterFields[0].value;
            this.getAdoptionOptionsList();
        }
    }
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        const selectedEvent = new CustomEvent('closemodal', { detail: false });
        this.dispatchEvent(selectedEvent);
    }

    handleAnimalStageChange() {
        console.log('YNASC - handleAnimalStageChange');
    }

    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        const selectedEvent = new CustomEvent('closemodal', { detail: false });
        this.dispatchEvent(selectedEvent);
        this.isModalOpen = false;
    }

    async getAdoptionOptionsList() {
        try {
            let adoptionOptionsMap = await adoptionOptionList();
            let optionsList = [];
            let optionsMap = [];
            for (var key in adoptionOptionsMap) {
                optionsMap.push({id : key, value : adoptionOptionsMap[key]});
            }
            this.stageOptionsMap = optionsMap;
        } catch (error) {
            
        }
    }

    handleStageSelected() {

    }

    handleRecordUnselection() {

    }
}