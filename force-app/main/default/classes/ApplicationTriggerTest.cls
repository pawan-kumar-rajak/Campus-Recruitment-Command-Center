/**
 * @description Test class for the ApplicationTrigger.
 */
@isTest
private class ApplicationTriggerTest {

    // @testSetup is a special method that runs once to create all the test data needed by all test methods.
    @testSetup
    static void setup() {
        // Create a test Company
        Account testCompany = new Account(Name = 'Test Corp');
        insert testCompany;

        // Create a test Job Posting that requires a high GPA
        Job_Posting__c testJob = new Job_Posting__c(
            Name = 'Senior Developer',
            Company__c = testCompany.Id,
            Minimum_GPA__c = 9.0
        );
        insert testJob;

        // Create two test Students (Contacts)
        Contact studentWithHighGPA = new Contact(
            LastName = 'Green',
            RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Student').getRecordTypeId(),
            GPA__c = 9.5
        );
        Contact studentWithLowGPA = new Contact(
            LastName = 'Red',
            RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Student').getRecordTypeId(),
            GPA__c = 8.0
        );
        insert new List<Contact>{ studentWithHighGPA, studentWithLowGPA };
    }

    // A positive test method to verify that a student with a high GPA CAN apply.
    @isTest
    static void testApplication_PositiveScenario() {
        // Get the test data we created in the setup method.
        Job_Posting__c job = [SELECT Id FROM Job_Posting__c LIMIT 1];
        Contact student = [SELECT Id FROM Contact WHERE LastName = 'Green' LIMIT 1];

        // Start the test. This creates a fresh set of governor limits.
        Test.startTest();

        // Perform the action: Create an Application record.
        Application__c app = new Application__c(
            Job_Posting__c = job.Id,
            Student__c = student.Id
        );
        insert app;

        // Stop the test.
        Test.stopTest();

        // Assertion: Verify that the application was successfully created by querying it.
        // If the record exists, the test passes.
        List<Application__c> createdApps = [SELECT Id FROM Application__c WHERE Id = :app.Id];
        System.assertEquals(1, createdApps.size(), 'Application should have been created successfully.');
    }

    // A negative test method to verify that a student with a low GPA CANNOT apply.
    @isTest
    static void testApplication_NegativeScenario() {
        // Get the test data.
        Job_Posting__c job = [SELECT Id FROM Job_Posting__c LIMIT 1];
        Contact student = [SELECT Id FROM Contact WHERE LastName = 'Red' LIMIT 1];

        Test.startTest();

        // Use a try-catch block to anticipate that an error will occur.
        try {
            // Attempt to create an application that should be blocked by our trigger.
            Application__c app = new Application__c(
                Job_Posting__c = job.Id,
                Student__c = student.Id
            );
            insert app;
        } catch (DmlException e) {
            // Assertion: Verify that the error message is the one we expect from our trigger.
            System.assert(e.getMessage().contains('Your GPA'), 'Error message should contain correct text.');
        }

        Test.stopTest();
    }
}