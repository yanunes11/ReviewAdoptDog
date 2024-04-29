import { LightningElement, api } from 'lwc';
export default class CreateAdoptionModal extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @api isModalOpen = false;
    @api animalId = '';
    @api adopterId = '';
    @api animalFields = {};
    @api adopterFields = {};

    connectedCallback() {
        console.log('YNASC animalId: '+JSON.stringify(this.animalId));
        console.log('YNASC adopterId: '+JSON.stringify(this.adopterId));
        console.log('YNASC animalFields: '+JSON.stringify(this.animalFields.fieldName));
        console.log('YNASC animalFields: '+JSON.stringify(this.animalFields[0].fieldName));
        console.log('YNASC adopterFields: '+JSON.stringify(this.adopterFields));
    }
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        const selectedEvent = new CustomEvent('closemodal', { detail: false });
        this.dispatchEvent(selectedEvent);
        // YNASC this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        const selectedEvent = new CustomEvent('closemodal', { detail: false });
        this.dispatchEvent(selectedEvent);
        this.isModalOpen = false;
    }
}