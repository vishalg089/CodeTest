import { LightningElement, api } from 'lwc';

export default class LdsRecordForm extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    handleSubmit(){
        alert('Submit');
    }

    handleSuccess(){
        alert('Submit');
    }
}