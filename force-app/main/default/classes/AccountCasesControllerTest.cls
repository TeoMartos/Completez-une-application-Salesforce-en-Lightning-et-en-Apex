@IsTest
private class AccountCasesControllerTest {
    @TestSetup
    static void setup() {
        Account testAccount = TestDataFactory.createTestAccount();
        Account testAccount2 = TestDataFactory.createTestAccount();
        TestDataFactory.createTestCase(testAccount.Id);
    }

    @IsTest
    static void testGetCases() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Case> results = AccountCasesController.findCasesBySubject(testAccount.Id, 'Broken');
        Test.stopTest();
        Assert.areEqual(1, results.size(), 'Should return 1 cases');
    }

    @IsTest
    static void testGetNoCases() {
        Account testAccount2 = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Case> results = AccountCasesController.findCasesBySubject(testAccount2.Id, 'Teo');
        Test.stopTest();
        Assert.areEqual(0, results.size(), 'Should not return cases');
    }
}