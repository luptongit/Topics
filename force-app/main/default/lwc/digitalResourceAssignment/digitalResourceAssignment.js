
import { LightningElement, track , wire} from 'lwc';
import getDigitalResourceAssignments from "@salesforce/apex/clsTopics.getAllTopics";



export default class DigitalResourceAssignment extends LightningElement {

    @track value = [];
    @track digitalResourceAssignments = [];

    @wire(getDigitalResourceAssignments)
    wireDigitalAssignments({ error, data }) {
      if (data) {
        this.digitalResourceAssignments = data;
        this.error = undefined;
      } else if (error) {
        this.error = error;
        this.MktUsers = undefined;
      }
    }

    get digitalassignments() {
        let alist = [];
        
        this.digitalResourceAssignments.forEach(function(element) {
           
          alist.push({ label: element[1], value: element[0] });
        });
        return alist;
      }

    get options() {
        return [
            { label: 'Ross', value: 'option1' },
            { label: 'Rachel', value: 'option2' },
        ];
    }

    get selectedValues() {
        return this.value.join(',');
    }

    handleChange(e) {
        this.value = e.detail.value;
    }
}
