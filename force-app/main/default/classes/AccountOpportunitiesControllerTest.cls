@IsTest
private class AccountOpportunitiesControllerTest {
    @TestSetup
    static void setup() {
        Account testAccount = TestDataFactory.createTestAccount();
        Account testAccount2 = TestDataFactory.createTestAccount();
        TestDataFactory.createTestOpportunity(testAccount.Id);
    }

    @IsTest
    static void testGetOpportunities() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Opportunity> results = AccountOpportunitiesController.getOpportunities(testAccount.Id);
        Test.stopTest();
        Assert.areEqual(1, results.size(), 'Should return one opportunity');
    }

    @IsTest
    static void testGetNoOpportunities() {
        Account testAccount2 = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        List<Opportunity> results = AccountOpportunitiesController.getOpportunities(testAccount2.Id);
        Test.stopTest();
        Assert.areEqual(0, results.size(), 'Should not return opportunity');
    }
}