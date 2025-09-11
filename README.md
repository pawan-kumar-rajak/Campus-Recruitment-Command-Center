
# Campus Recruitment Command Center
---

### **Project Title: "Campus Recruitment Command Center - An Integrated System for Student Placements & Corporate Relations"**

**Industry:** Higher Education

**Project Type:** B2S (Business-to-Student) & B2B (Business-to-Business) Salesforce Platform

**Target Users:** Training & Placement (T&P) Officers, Students, and the Head of Placements

#### **Problem Statement**

A university's Training & Placement (T&P) cell manages hundreds of corporate relationships and thousands of student applications using disconnected tools like spreadsheets, Google Forms, and email. This manual process results in communication gaps, missed application deadlines for students, and an inability for T&P officers to efficiently match the right students with the right opportunities. Furthermore, the constant influx of student queries via email overwhelms the T&P staff, leading to slow response times for critical questions.

To address this, the university wants to implement a Salesforce platform to:
* Centralize company and job posting information.
* Automate the student application and notification process.
* Streamline and automate the resolution of common student queries.
* Provide real-time dashboards for the Head of Placements to track success metrics.

#### **Use Cases**

**1. Corporate & Recruiter Management**
* Maintain a unified database of all visiting companies and their recruiter contact information.
* Track the status of engagement with new companies (e.g., Approached, MoU Signed, Visit Scheduled).
* Log all interactions, such as calls and meetings, with company representatives.

**2. Job Posting & Application Management**
* Create and manage detailed Job Postings with specific eligibility criteria (e.g., Branch, GPA, Graduation Year).
* Automatically notify eligible students via email when a new relevant job is posted.
* Allow students to apply for jobs through a simple, guided interface (a Screen Flow).
* Track the status of each student's application (e.g., Applied, Shortlisted, Offer Extended).

**3. Automated Student Query Resolution**
* Automatically create a "Query" record in Salesforce when a student sends an email to a designated placement helpdesk address (e.g., `placements@university.edu`).
* Send an automated initial email response acknowledging receipt of the query.
* Use a Flow to scan the query's subject for keywords (e.g., "Resume," "Eligibility," "Deadline") and send back a templated email with helpful links or standard answers, closing common queries without manual intervention.

**4. Reporting & Analytics**
* A master dashboard for the Head of Placements showing key metrics like:
    * Number of Companies Visiting
    * Total Job Openings vs. Applications
    * Branch-wise Placement Percentage
* Reports that track the placement funnel and T&P officer activity.
