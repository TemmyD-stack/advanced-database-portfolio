# NoSQL Data Model – Hospital Management Information System

## 1. Introduction

This document describes the NoSQL data model developed for the Hospital Management Information System (HMIS) using MongoDB.

The implementation uses MongoDB's document-oriented data model to store patient information, contact details, addresses, medical histories, and appointments in flexible BSON documents.

The objective is to demonstrate how a document database can complement the relational database developed in Portfolio 1.

## 2. Case Study Description: Hospital Management Information System (HMIS)

### Organisation and System Scenario

This project uses a simulated Hospital Management Information System (HMIS) as its case study. The system is designed to support the management of patient information and hospital activities, including patient registration, medical history management, appointment scheduling, diagnosis records, prescriptions, and laboratory services.

The HMIS provides a centralised way of organising patient-related information so that authorised hospital personnel can retrieve and manage records efficiently.

### Database Users

The major users of the system include:

- **Hospital Administrators:** Manage patient records and oversee hospital operations.
- **Doctors:** Access patient medical histories, review appointments, and record diagnoses.
- **Nurses:** Retrieve patient information and assist with patient care.
- **Laboratory Personnel:** Manage laboratory-related patient information and test records.
- **Receptionists:** Register patients and manage appointment information.

### Major Data Stored

The system manages information such as:

- Patient identification and personal details.
- Contact information and residential addresses.
- Medical histories and recorded conditions.
- Appointment dates and appointment statuses.
- Doctor information and treatment-related records.

### Key Database Operations

The HMIS supports operations such as:

1. Registering new patients.
2. Retrieving patient records using selected attributes.
3. Updating patient contact and address information.
4. Recording and retrieving medical history.
5. Managing appointment information.
6. Analysing recorded medical conditions.

The MongoDB implementation in this portfolio focuses on the patient information component of the wider HMIS.


## 3. NoSQL Database Environment

| Component | Configuration |
|---|---|
| Database | hospital_nosql |
| Collection | patients |
| Database System | MongoDB Community Server 9.0.4 |
| Graphical Interface | MongoDB Compass |
| Connection | mongodb://localhost:27017 |
| Data Model | Document-oriented |
| Number of Patient Documents | 20 |

## 4. Document Structure

Each patient is represented by an individual document in the `patients` collection.

The document contains the following fields:

| Field | Data Type | Description |
|---|---|---|
| `_id` | ObjectId | Automatically generated unique document identifier |
| `patient_id` | Integer | Patient identification number |
| `first_name` | String | Patient's first name |
| `last_name` | String | Patient's surname |
| `date_of_birth` | String | Patient's date of birth |
| `gender` | String | Patient's gender |
| `contact` | Embedded document | Contains phone number and email |
| `address` | Embedded document | Contains city and state |
| `medical_history` | Array | Contains one or more medical history records |
| `appointments` | Array | Contains one or more appointment records |

## 5. Sample MongoDB Document

The following example represents a patient record stored in the `patients` collection:

```json
{
  "patient_id": 101,
  "first_name": "Olivia",
  "last_name": "Adedayo",
  "date_of_birth": "1998-04-12",
  "gender": "Female",
  "contact": {
    "phone": "08012345678",
    "email": "olivia.james@hmis.test"
  },
  "address": {
    "city": "Ikeja",
    "state": "Lagos"
  },
  "medical_history": [
    {
      "condition": "Malaria",
      "diagnosed_date": "2025-08-10"
    }
  ],
  "appointments": [
    {
      "appointment_date": "2026-11-10",
      "status": "Scheduled",
      "doctor": "Dr. Adebayo"
    }
  ]
}
```

MongoDB automatically generates the `_id` field when a document is inserted.

## 6. Embedded Document Design

The HMIS implementation uses embedded documents and arrays to organize related information.

### Embedded Documents

The `contact` and `address` fields are embedded within the patient document.

This allows patient contact information and address details to be retrieved alongside the main patient record.

### Arrays

The `medical_history` and `appointments` fields are arrays containing embedded documents.

A patient can have multiple medical conditions and multiple appointments without requiring separate collections for every record.

## 7. Relationships and Modelling Decisions

The document model uses embedding for information that is frequently accessed together with the patient record.

| Patient Information | Modelling Approach |
|---|---|
| Contact details | Embedded document |
| Address | Embedded document |
| Medical history | Array of embedded documents |
| Appointments | Array of embedded documents |
| Patient identification | `patient_id` field and MongoDB `_id` |

Unlike the relational model, this implementation does not depend on foreign-key relationships between separate patient-related tables.

The `doctor` field in each appointment is currently stored as a doctor's name rather than a reference to a separate doctor document.

## 8. Suitability of the Document Model

MongoDB's document model is suitable for this part of the HMIS for several reasons:

- **Flexible structure:** Patient documents can accommodate different numbers of medical history records and appointments.
- **Embedded information:** Related patient information can be stored together in one document.
- **Efficient retrieval:** Frequently accessed patient details can be retrieved without joining multiple relational tables.
- **Scalability:** MongoDB supports the development of applications that require flexible document structures and horizontal scaling.
- **Adaptability:** Additional patient-related fields can be introduced as system requirements evolve.

## 9. Conclusion

The MongoDB document model provides an alternative approach to storing patient information in the HMIS.

The implementation demonstrates the use of embedded documents, arrays, and flexible document structures. It complements the relational database by providing a document-oriented approach to managing patient-centred information.