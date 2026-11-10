# Portfolio 4: NoSQL and Advanced Data Models

## 1. Introduction

This portfolio demonstrates the design and implementation of a NoSQL database using a Hospital Management Information System (HMIS) as the case study.

The practical exercise uses MongoDB to store and manage patient information through a document-oriented data model. It demonstrates how NoSQL databases support flexible data structures, embedded documents, arrays, CRUD operations, and data aggregation.

## 2. Database Environment

The implementation was carried out using:

- **Database:** MongoDB
- **MongoDB Version:** Community Server 9.0.4
- **Interface:** MongoDB Compass
- **Database Name:** `hospital_nosql`
- **Collection:** `patients`
- **Dataset:** 20 patient documents

## 3. NoSQL Data Model

The HMIS patient collection uses a document-based structure.

Each patient document contains:

- Patient identification and personal information.
- Contact information stored as an embedded document.
- Address information stored as an embedded document.
- Medical history stored as an array of embedded documents.
- Appointment information stored as an array of embedded documents.

This structure allows related patient information to be stored together within a single document.

## 4. Practical Implementation

The following operations were implemented and tested:

### A. Database and Collection Creation
Created the `hospital_nosql` database and `patients` collection using MongoDB Compass.

### B. CRUD Operations
- **Create:** Inserted a new patient document.
- **Read:** Retrieved patients using gender, address, and medical-history filters.
- **Update:** Modified a patient's address.
- **Delete:** Removed a temporary test document.
- **Verification:** Checked the updated document, confirmed deletion, and counted the documents in the collection.

### C. Embedded Document Queries
Used dot notation to retrieve patients based on fields inside embedded documents, including their city.

### D. Array Queries
Queried the `medical_history` array to identify patients with a particular medical condition.

### E. Aggregation Pipeline
Implemented a MongoDB aggregation pipeline using:

1. `$unwind` to separate medical-history entries.
2. `$group` to group entries by medical condition and count occurrences.
3. `$sort` to arrange the results in descending order.

The aggregation showed the frequency of recorded medical conditions in the patient collection.

## 5. Files and Evidence

| File | Description |
|---|---|
| `nosql-model.md` | Explains the document model and database design. |
| `nosql-analysis.md` | Documents implementation, queries, results, and analysis. |
| `nosql-operations.js` | Contains the CRUD and verification operations. |
| `aggregation-pipeline.js` | Contains the aggregation pipeline. |
| `screenshots/` | Contains screenshots showing implementation and test results. |

## 6. Suitability of MongoDB for HMIS

MongoDB is suitable for this exercise because patient records can contain different types of information and nested data structures.

Its document-oriented model makes it possible to store contact details, addresses, medical histories, and appointment information within patient documents.

The flexible schema also allows additional fields to be introduced as the system evolves.

However, a production HMIS would still require careful data validation, access control, security, backup procedures, and appropriate handling of relationships between patients, doctors, appointments, and other hospital records.

## 7. Conclusion

This practical exercise demonstrated how MongoDB can be used to implement a document-oriented database for a hospital management system.

The implementation covered document creation, retrieval, updating, deletion, embedded-document queries, array queries, and aggregation.

It also provided practical experience in understanding how NoSQL databases differ from relational databases and how document-based modelling can support applications with flexible and nested data structures.