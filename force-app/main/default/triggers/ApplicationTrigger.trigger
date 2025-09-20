/**
 * @description Trigger on the Application object to handle custom validation.
 */
trigger ApplicationTrigger on Application__c (before insert) {

    // Best Practice: Create a set to hold the IDs of all Job Postings and Contacts from the new applications.
    // A Set is a collection that does not allow duplicate values, which is efficient for queries.
    Set<Id> jobPostingIds = new Set<Id>();
    Set<Id> studentIds = new Set<Id>();

    // 1. COLLECT IDs: Loop through all the new Application records that are trying to be created.
    // Trigger.new is a special context variable that holds all the new records in the transaction.
    for (Application__c app : Trigger.new) {
        jobPostingIds.add(app.Job_Posting__c);
        studentIds.add(app.Student__c);
    }

    // 2. QUERY DATA: Use SOQL to get all the required data in one efficient query for Job Postings
    // and one for Contacts. This avoids running queries inside a loop, which is a major performance issue.
    Map<Id, Job_Posting__c> jobPostingsMap = new Map<Id, Job_Posting__c>([
        SELECT Id, Minimum_GPA__c FROM Job_Posting__c WHERE Id IN :jobPostingIds
    ]);

    Map<Id, Contact> studentsMap = new Map<Id, Contact>([
        SELECT Id, GPA__c FROM Contact WHERE Id IN :studentIds
    ]);


    // 3. VALIDATE LOGIC: Loop through the new applications again. This time, we have all the data we need.
    for (Application__c app : Trigger.new) {
        // Retrieve the specific Job Posting and Student for the current application from our Maps.
        Job_Posting__c relatedJob = jobPostingsMap.get(app.Job_Posting__c);
        Contact relatedStudent = studentsMap.get(app.Student__c);

        // Control Statement: Check if the student's GPA is less than the job's minimum requirement.
        // Also check that both values are not null to prevent errors.
        if (relatedStudent.GPA__c != null &&
            relatedJob.Minimum_GPA__c != null &&
            relatedStudent.GPA__c < relatedJob.Minimum_GPA__c) {

            // If the GPA is too low, add a custom error message to the record.
            // This prevents the record from being saved and displays the error to the user.
app.addError('You cannot apply for this job. Your GPA (' + relatedStudent.GPA__c + ') is below the minimum requirement of ' + relatedJob.Minimum_GPA__c + '.');        }
    }
}