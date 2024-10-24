import { LightningElement, track, api } from 'lwc';
import findCasesBySubject from '@salesforce/apex/AccountCasesController.findCasesBySubject';

const COLUMNS = [
    { label: 'Sujet', fieldName: 'Subject', type: 'text' },
    { label: 'Statut', fieldName: 'Status', type: 'text' },
    { label: 'Priorité', fieldName: 'Priority', type: 'text' },
];

export default class AccountCaseSearchComponent extends LightningElement {
    @api recordId; //les @ permettent d'etre appelé ailleurs
    @track cases;
    @track error;
    searchTerm = '';
    columns = COLUMNS;

    updateSearchTerm(event) {
        this.searchTerm = event.target.value;
    }

    handleSearch() {
        findCasesBySubject({ accountId: this.recordId, subjectSearchTerm: this.searchTerm })
            .then(result => {
                if (result.length === 0) {
                // check si la recherche n'existe pas
                    this.error = 'Le sujet que vous recherchez n\'existe pas.';
                    this.cases = undefined; //pas de recherche -> on affiche rien
                } else {
                    this.cases = result; // Si des résultats sont trouvés, les afficher
                    this.error = undefined;
                }
            })
            .catch(error => {
                this.error = 'Une erreur est survenue lors de la recherche des cases.';
                this.cases = undefined;
            });
    }
}