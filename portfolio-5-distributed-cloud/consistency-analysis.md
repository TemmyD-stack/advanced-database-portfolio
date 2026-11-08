# Consistency Analysis – Hospital Management Information System (HMIS)

## 1. Introduction

Data consistency is an important requirement in distributed database systems. It helps ensure that database operations maintain reliable and accurate information across multiple database nodes.

In the Hospital Management Information System (HMIS), consistency is particularly important because patient records, diagnoses, prescriptions, and laboratory results must remain reliable and accessible.

This exercise examines consistency in the three-node MongoDB replica set named `hmisRS`, focusing on replication, read operations, write operations, and primary-node failure.

## 2. How MongoDB Maintains Consistency

MongoDB replica sets use a primary-secondary architecture to maintain copies of data across multiple database nodes.

The PRIMARY node receives write operations. These operations are recorded in the operation log (oplog), which secondary nodes use to replicate changes to their own databases.

The secondary nodes continuously replicate operations from the primary. However, replication is asynchronous, meaning that a secondary node may temporarily lag behind the primary.

This means that data written to the primary may not become immediately visible on every secondary node.

## 3. Read Preference and Consistency

Read preference determines which replica-set members MongoDB uses to serve read operations.

In this practical exercise, a secondary read preference was used to verify that patient data had been replicated to another node.

The following operation was used:

```javascript
db.getMongo().setReadPref("secondary");

db.patients.findOne({ patient_id: 501 });
```

The query returned the patient record for Femi Adebayo from a secondary node.

This demonstrated that the patient record inserted through the primary node had been replicated and was available for reading from a secondary node.

### Read Preference Options

MongoDB provides different read preference modes:

- **Primary:** Reads are directed to the primary node. This is the default read preference.
- **PrimaryPreferred:** Reads use the primary when available and may use a secondary when the primary is unavailable.
- **Secondary:** Reads are directed to secondary nodes.
- **SecondaryPreferred:** Reads use secondary nodes when available, falling back to the primary when necessary.
- **Nearest:** Reads are directed to an eligible member with relatively low network latency.

For an HMIS, reading critical patient information from the primary may be preferable when the application requires the latest available data. Secondary reads can help distribute read workloads but may return slightly outdated information because of replication lag.

Read preference determines which node handles a read, while read concern determines the consistency guarantees associated with the data returned. They are related but serve different purposes.

## 4. Write Concern and Data Reliability

Write concern determines the level of acknowledgement MongoDB requires before reporting a write operation as successful.

For example, MongoDB supports a write concern of `majority`, which requires acknowledgement from a majority of voting replica-set members.

In this three-member replica set, a majority means at least two voting members.

A majority write concern can be specified as follows:

```javascript
db.patients.insertOne(
  {
    patient_id: 502,
    first_name: "Grace",
    last_name: "Okafor",
    record_type: "Write Concern Example"
  },
  {
    writeConcern: { w: "majority" }
  }
);
```

This is an illustrative example of how a write could be configured. A majority write concern helps protect acknowledged writes against certain node failures. It does not mean that every secondary has necessarily applied the write at the exact moment the acknowledgement is returned.

The practical replication test did not explicitly configure a custom write concern. Therefore, the example above represents a recommended configuration rather than a separately tested operation.

## 5. Failover and Data Availability

A replica set uses automatic elections to select a new primary when the existing primary becomes unavailable.

During the practical exercise, Node 1, running on port `27018`, was stopped while it was the primary node.

The replica set detected the failure and elected Node 3, running on port `27020`, as the new primary. Node 2 remained a secondary.

The previously inserted patient record was still accessible after the election.

This demonstrated that the replica set could continue operating after the failure of one database instance.

When Node 1 was restarted, it rejoined the replica set as a secondary node. Node 2 remained the primary, while Node 3 returned to secondary status.

These tests demonstrated automatic primary election, continued availability of the tested patient record, and node recovery.

## 6. Consistency Considerations in the HMIS

The HMIS handles information that must be accurate and dependable. Different operations may therefore require different consistency levels.

Examples include:

- **Patient record updates:** Applications should use suitable write concerns to improve the reliability of important updates.
- **Prescriptions:** Users should avoid relying on potentially stale secondary reads when making decisions that require the latest prescription information.
- **Laboratory results:** Critical result verification should use an appropriate read strategy to reduce the risk of displaying outdated information.
- **General reporting:** Secondary reads may be suitable for reports and analytics where a small replication delay is acceptable.

The choice of read preference, read concern, and write concern should depend on the importance of the operation and the consistency requirements of the application.

## 7. Limitations of the Experiment

The consistency experiment was conducted using three MongoDB instances running on one physical Windows computer.

Although replication and failover were successfully demonstrated, the experiment did not include:

- A benchmark measuring replication lag.
- A separate test of custom majority write concern.
- A comparison of different read concern levels.
- Deployment across separate physical servers or cloud availability zones.

These limitations mean that the experiment demonstrates the basic consistency and availability behaviour of a MongoDB replica set rather than a complete production-level consistency evaluation.

## 8. Conclusion

The MongoDB replica-set experiment demonstrated how data is replicated between primary and secondary nodes and how secondary reads can be used to verify replicated records.

The failover test further demonstrated that the database could elect a new primary and retain access to the tested patient record after the original primary became unavailable.

The exercise also highlighted the importance of read preference, read concern, write concern, and replication lag when designing distributed database systems.

For a production HMIS, appropriate consistency settings should be selected to protect critical patient information while maintaining database availability and performance.