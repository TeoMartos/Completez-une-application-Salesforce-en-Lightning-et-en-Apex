@IsTest
private class AccountCasesSelectorTest {
    @TestSetup
    static void setup() {
        Account testAccount = TestDataFactory.createTestAccount();
        TestDataFactory.createTestCase(testAccount.Id);
    }

    @IsTest
    static void testGetCasesByAccountId() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Case> results = AccountCasesSelector.findCasesBySubject(testAccount.Id, 'Broken');
        Test.stopTest();
        System.assertNotEquals(0, results.size(), 'Should return at least one case');
    }

    @IsTest
    static void testGetNoCasesByAccountId() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Case> results = AccountCasesSelector.findCasesBySubject(testAccount.Id, 'Teo');
        Test.stopTest();
        System.assertEquals(0, results.size(), 'Should return 0 cases');
    }

    // Nouveau test pour couvrir le cas où accountId est null
    @IsTest
    static void testAccountIdIsNull() {
        Test.startTest();
        List<Case> results = AccountCasesSelector.findCasesBySubject(null, 'Broken');
        Test.stopTest();
        System.assertEquals(0, results.size(), 'Should return an empty list when accountId is null');
    }

    // Nouveau test pour couvrir le cas où subjectSearch est vide
    @IsTest
    static void testSubjectSearchIsBlank() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Case> results = AccountCasesSelector.findCasesBySubject(testAccount.Id, '');
        Test.stopTest();
        System.assertEquals(0, results.size(), 'Should return an empty list when subjectSearch is blank');
    }
}
