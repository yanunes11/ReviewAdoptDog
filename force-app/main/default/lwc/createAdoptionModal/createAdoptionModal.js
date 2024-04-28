import { LightningElement, api } from 'lwc';
export default class CreateAdoptionModal extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @api isModalOpen = false; //YNASC - change to false
    connectedCallback() {
        this.isModalOpen = true;
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