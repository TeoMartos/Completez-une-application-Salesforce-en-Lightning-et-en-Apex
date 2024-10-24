public with sharing class AccountCasesController {
    @AuraEnabled //rend la méthode disponible cote front
    public static List<Case> findCasesBySubject(Id accountId, String subjectSearchTerm) {
        // appel de la class AccountCasesSelector qui contient ma méthode findCasesBySubject
        return AccountCasesSelector.findCasesBySubject(accountId, subjectSearchTerm);
    }
}
