import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';
import { refreshApex } from '@salesforce/apex';

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId;
    @track opportunities;
    @track error;
    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];
    wiredOpportunitiesResult;
    @wire(getOpportunities, { accountId : '$recordId' })
    wiredOpportunities(result) {
        this.wiredOpportunitiesResult = result;
        if (result.data) {
            this.opportunities = result.data.length > 0 ? result.data : null;
            this.error = result.data.length == 0 ? 'Vous n\'avez pas d\'opportunities associés au compte' : null;
        } else if (result.error) {
            this.error = 'Une erreur s\'est produite lors du chargement des opportunités.'
            this.opportunities = undefined; //pas d'opportunite -> on affiche rien
        }
    }
    handleRafraichir() {
        refreshApex(this.wiredOpportunitiesResult);
    }
    get errorStyle () { //fonction error style qui permet de rendre dynamique le css du message d'erreur
        return this.error && this.error.includes('Vous n\'avez pas d\'opportunities associés au compte')
        ? 'slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_info' : 'slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error'
    }
}
