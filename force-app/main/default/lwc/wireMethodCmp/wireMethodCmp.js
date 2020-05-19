import { LightningElement, wire, api } from 'lwc';
import getCases from '@salesforce/apex/CaseController.getCases';
export default class WireMethodCmp extends LightningElement {

    //@wire(getCases) cases;
    @api records;
    @api errors;

    @wire(getCases)
        getAllCases({
            data, error 
        }) {
            if(data) {
                this.records = data
                this.errors = undefined
            }
            else {
                this.errors=error;
                this.records = undefined;
            }
        }
}