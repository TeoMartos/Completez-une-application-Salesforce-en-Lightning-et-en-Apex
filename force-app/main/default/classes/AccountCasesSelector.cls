public with sharing class AccountCasesSelector {
    public static List<Case> findCasesBySubject(Id accountId, String subjectSearch) {
        //Verifiaction si accountId et le champ de recherche sont vide
        if (accountId == null || String.isBlank(subjectSearch)) {
            return new List<Case>();
        }

        //requete pour récuperer Id, sujet, status et priority de l'objet case
        return [
                SELECT Id, Subject, Status, Priority FROM Case WHERE AccountId = :accountId AND Subject LIKE :('%' + subjectSearch + '%')
                //recherche par l'utilisateur, si je rentre juste un mot la recherche se fait
        ];
    }
}