import { LightningElement } from 'lwc';

export default class UdemyLWC extends LightningElement {
    name = 'vishal';
    constructor(){
        super();
        console.log('inside const');
        this.name = this.name + 'gupta';
    }

    connectedCallback() {
        console.log('inside connected callback');
    }

    disConnectedCallback() {
        console.log('inside disconnected callback');
    }
    renderedCallback() {
        console.log('inside render callback');
    }
    
    /*render() {

    }*/
    errorCallback(error, stack) {
        console.error(error);
    }
}