# NoSQL Implementation and Technical Analysis

## 1. Introduction

This portfolio implements a document-oriented NoSQL database for the Hospital Management Information System (HMIS) using MongoDB Community Server 9.0.4 and MongoDB Compass.

The implementation demonstrates document insertion, retrieval, updating, deletion, nested document queries, and aggregation operations.

## 2. Implementation Summary

The MongoDB database was created with the name `hospital_nosql` and a collection named `patients`.

A total of 20 patient documents were inserted successfully.

Each document stores patient identification details, contact information, address, medical history, and appointment information.

## 3. CRUD Operations

The following CRUD operations were implemented and tested.

| Operation | Implementation | Result |
|---|---|---|
| Create | Inserted patient documents | Successful |
| Read | Retrieved patients using gender filters | Successful |
| Update | Changed Olivia's surname from James to Adedayo and updated her address to Ikeja, Lagos (patient ID 101) | Successful |
| Delete | Removed a temporary test document (patient ID 999) | Successful |

The CRUD experiments demonstrated how MongoDB manages individual documents within a collection.

## 4. Query Processing

Several queries were executed to demonstrate MongoDB's document query capabilities.

### 4.1 Filtering by Gender

```javascript
{ gender: "Female" }
```

This query retrieves patient documents where the gender field is Female.

The initial dataset returned two female patients before the additional records were imported.

### 4.2 Querying Embedded Documents

```javascript
{ "address.city": "Ibadan" }
```

This query uses dot notation to retrieve patients whose city field inside the embedded address document is Ibadan.

The query returned four patient documents.

### 4.3 Querying Arrays of Embedded Documents

```javascript
{ "medical_history.condition": "Hypertension" }
```

This query searches the medical_history array for embedded documents containing the specified medical condition.

The query demonstrates MongoDB's ability to search nested array elements.

## 5. Aggregation Pipeline

An aggregation pipeline was implemented to summarize the medical conditions recorded in the patient documents.

The pipeline consisted of three stages.

### Stage 1: $unwind

```javascript
{
  $unwind: "$medical_history"
}
```

This stage separates medical history array entries into individual pipeline documents.

### Stage 2: $group

```javascript
{
  $group: {
    _id: "$medical_history.condition",
    totalPatients: { $sum: 1 }
  }
}
```

This stage groups medical history entries by condition and counts the entries in each group.

### Stage 3: $sort

```javascript
{
  $sort: {
    totalPatients: -1
  }
}
```

This stage sorts the grouped results in descending order based on the calculated count.

### Aggregation Results

The executed pipeline returned seven medical-condition groups.

| Medical Condition | Count |
|---|---:|
| Hypertension | 4 |
| Malaria | 4 |
| Asthma | 4 |
| Type 2 Diabetes | 3 |
| Sickle Cell Disease | 2 |
| Peptic Ulcer Disease | 2 |
| Migraine | 2 |

The counts represent medical history entries grouped by condition. They are not necessarily counts of unique patients if a patient has multiple entries for the same condition.

## 6. Relational Database and NoSQL Comparison

The HMIS was initially implemented using MySQL as a relational database in Portfolio 1.

MongoDB was subsequently used to demonstrate a document-oriented approach to storing patient information.

| Feature | MySQL | MongoDB |
|---|---|---|
| Data model | Relational | Document-oriented |
| Storage structure | Tables and rows | Collections and documents |
| Schema | Structured relational schema | Flexible document structure |
| Relationships | Primary and foreign keys | Embedding and references |
| Related information | Often distributed across tables | Can be embedded in documents |
| Query language | SQL | MongoDB Query Language |
| Aggregation | SQL aggregate functions and GROUP BY | Aggregation pipeline |

### 6.1 Document Modelling Decisions

The MongoDB patient collection uses embedded documents and arrays to organise related information within each patient record.

**Embedded Contact and Address Documents**

Contact details and residential addresses were embedded within patient documents because they are directly associated with individual patients and are commonly retrieved alongside patient information.

**Embedded Medical History Array**

Medical history was modelled as an array of embedded documents because a patient may have multiple recorded medical conditions. Each entry can store information such as the condition and diagnosis date.

**Embedded Appointments Array**

Appointment information was also represented as an array because a patient may have multiple appointments. Each appointment entry stores its date, status, and doctor name.

**Design Trade-offs**

Embedding reduces the need for separate queries when retrieving related patient information. However, it can introduce duplicated information and make updates more difficult when embedded data is shared across multiple records.

For example, storing doctor names directly inside appointment records may result in repeated doctor information. A separate doctor collection with references could be more appropriate in a larger production system.

## 7. Suitability for the HMIS

MongoDB is useful for patient-centred information because related data can be embedded within patient documents.

For example, a patient's contact details, address, medical history, and appointments can be retrieved together.

The flexible document structure also accommodates patients with different numbers of medical history records and appointments.

However, a relational database remains useful for highly structured records and relationships that require strong referential integrity, such as linking appointments to doctors and patients.

A hybrid approach could therefore use MySQL for core transactional records and MongoDB for selected patient-centred document data, provided that data synchronization and consistency are properly managed.

The choice of MongoDB for this exercise was influenced by the need to represent patient information that contains nested and potentially variable records. Embedding contact details, addresses, medical history, and appointments allows related information to be retrieved as part of a single patient document. Nevertheless, not all HMIS data should necessarily be embedded. Records shared by multiple patients or requiring independent management may be better represented through separate collections and references. The choice of data model should therefore depend on access patterns, data relationships, and consistency requirements.

## 8. Limitations and Considerations

Although the MongoDB implementation successfully demonstrated document-oriented data modelling, several limitations were identified.

1. Dataset Size and Scalability

The implementation used 20 patient documents to demonstrate MongoDB document modelling, CRUD operations, nested queries, and aggregation. Although this dataset was sufficient for the practical objectives of the portfolio, it is relatively small compared with the volume of records expected in a production hospital information system. Further testing with a larger dataset would be necessary to evaluate query performance, indexing effectiveness, and scalability under realistic workloads.

2. Date Representation

Dates were stored as strings rather than MongoDB Date values. Using native date values would support more reliable date comparisons, sorting, and date-based aggregation.

3. Embedded Doctor Information

Doctor names were stored directly inside appointment records instead of referencing a separate doctors collection. This can introduce duplicated information and create update difficulties when doctor details change.

4. Data Validation

The implementation did not establish a comprehensive validation schema. A production HMIS would require rules to enforce required fields, acceptable data types, and valid patient information.

5. Indexing

Indexes were not extensively evaluated in this NoSQL exercise. Appropriate indexes on frequently queried fields, such as patient identification, gender, and medical conditions, could improve retrieval performance as the dataset grows.

6. Aggregation Counting

The aggregation pipeline counted medical history entries rather than distinct patients. A patient with repeated entries for the same condition could therefore contribute more than once to the count.

7. Data Consistency and Security

A production HMIS would require suitable access controls, data protection, backup procedures, and consistency mechanisms to protect sensitive patient records and maintain reliable information across hospital operations.

These limitations identify areas for improvement if the prototype were extended into a production-ready hospital information system.


## 9. Conclusion

The MongoDB implementation demonstrated the practical application of NoSQL concepts within the HMIS case study.

The experiments covered CRUD operations, nested document queries, array queries, and aggregation pipelines.

The comparison with MySQL showed that relational and document-oriented databases offer different advantages and can complement each other when appropriately designed.