import { LightningElement, api, track } from 'lwc';
import adoptionOptionList from '@salesforce/apex/AdoptionQueries.retrieveAdoptionStageInfo';
import createAdoption from '@salesforce/apex/AdoptionServices.createAdoption';

export default class CreateAdoptionModal extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @api isModalOpen = false;
    @api animalId = '';
    @api adopterId = '';
    @api animalFields = {};
    @api adopterFields = {};
    adoptionStage = '';
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

    handleStageSelected(event) {
        this.adoptionStage = event.detail;
    }
    
    handleRecordUnselection(event) {
        console.log('YNASC event.detail handleRecordUnselection: '+JSON.stringify(event.detail));
        
    }

    handleApplyClassCustomHeight(event) {
        this.template.querySelector('.apply-custom-height--inherit')?.classList.add(event.detail.customclass);        
        }
        
        handleRemoveClassCustomHeight(event) {
        this.template.querySelector('.apply-custom-height--inherit')?.classList.remove(event.detail.customclass);
    }

    async createAdoptionHandle() {
        const data = {
            animalId: this.animalId,
            adopterId: this.adopterId,
            adoptionStage: this.adoptionStage
        };

        try {
            await createAdoption({ params: data });
            // Handle success
            console.log('YNASC - Data processed successfully');
            const refreshEvent = new CustomEvent('refreshdata', { detail: {message: 'Adoption record saved successfully'} });
            this.dispatchEvent(refreshEvent);
            const selectedEvent = new CustomEvent('closemodal', { detail: false });
            this.dispatchEvent(selectedEvent);
            this.isModalOpen = false;
        } catch (error) {
            // Handle error
            console.error('YNASC - Error processing data: ', error.body);
            alert(error.body.message);
        }
    }
}