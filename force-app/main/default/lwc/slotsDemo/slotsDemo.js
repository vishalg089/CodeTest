import { LightningElement } from 'lwc';

export default class SlotsDemo extends LightningElement {
    handleEvent() {
        const evtS = new CustomEvent(
            'firstevent',
            {
                detail:{message:"1", pageno:123, staticVal:"vishal"}
            }
            );
        this.dispatchEvent(evtS);
    }
}