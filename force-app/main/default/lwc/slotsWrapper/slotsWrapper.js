import { LightningElement } from 'lwc';

export default class SlotsWrapper extends LightningElement {
    handleEvent(event){
        alert(event.detail.pageno);
    }
}