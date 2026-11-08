# Portfolio 5: Distributed and Cloud Database Systems

## 1. Introduction

This portfolio explores distributed database concepts using the Hospital Management Information System (HMIS) case study. The practical implementation focuses on MongoDB replication to demonstrate data availability, consistency considerations, automatic failover, and recovery.

A three-member MongoDB replica set was configured locally to simulate a distributed database environment.

## 2. Objectives

The objectives of this portfolio are to:

- Understand how database replication supports availability and fault tolerance.
- Configure a MongoDB replica set with one primary and two secondary members.
- Demonstrate data replication between replica-set members.
- Test automatic failover when the primary node becomes unavailable.
- Examine consistency considerations in a distributed database environment.
- Discuss sharding and its potential application to the HMIS.

## 3. Technologies and Environment

| Component | Technology |
|---|---|
| Database | MongoDB Community Server 9.0.4 |
| Shell | MongoDB Shell 2.14.1 |
| Database interface | MongoDB Compass |
| Operating system | Windows |
| Development environment | Visual Studio Code |
| Case study | Hospital Management Information System |

## 4. Practical Implementation

A MongoDB replica set named `hmisRS` was configured using three database instances:

| Replica-set member | Port | Initial role |
|---|---:|---|
| Node 1 | 27018 | PRIMARY |
| Node 2 | 27019 | SECONDARY |
| Node 3 | 27020 | SECONDARY |

The implementation involved:

1. Creating separate database directories for the three instances.
2. Starting the three MongoDB server processes.
3. Initialising the replica set.
4. Inserting a sample patient record into the primary node.
5. Verifying that the record was replicated to a secondary node.
6. Stopping the original primary node to test automatic failover.
7. Restarting the stopped node and observing its rejoining as a secondary member.

## 5. Evidence and Documentation

The following files provide the implementation details and supporting evidence:

### Documentation

- `distributed-architecture.md` – Explains the proposed distributed architecture and its relevance to the HMIS, including sharding as a future scalability improvement.
- `replication-setup.md` – Documents the replica-set configuration, commands, data replication, failover, and recovery tests.
- `consistency-analysis.md` – Discusses replication, read preferences, write concerns, consistency, availability, and failover.

### Screenshots

The `screenshots/` directory contains the following practical evidence:

- `screenshots/node1.png` – Initial Node 1 status.
- `screenshots/node2.png` – Node 2 replica-set status.
- `screenshots/node3.png` – Node 3 replica-set status.
- `screenshots/staging_failover.png` – Process identification and stopping the original primary.
- `screenshots/automatic_failover.png` – Automatic election of Node 3 and verification of the patient record.
- `screenshots/node1_recovery.png` – Node 1 rejoining as a secondary and the final replica-set status.

## 6. Key Findings

The practical implementation demonstrated that:

- MongoDB can replicate data across multiple replica-set members.
- Secondary members can serve read operations when configured with an appropriate read preference.
- When the primary node became unavailable, another eligible member was elected as primary.
- The previously stopped node could rejoin the replica set after restarting.

These observations demonstrate how replication contributes to database availability and fault tolerance.

## 7. Limitations and Future Improvements

The three MongoDB instances were hosted on one physical computer and used localhost connections. Although this demonstrated replica-set behaviour, it did not provide physical or geographical fault isolation.

The implementation did not include a cloud deployment or an actual sharding configuration. These remain possible future improvements.

A production HMIS deployment would also require authentication, role-based access control, encrypted connections, backups, monitoring, and appropriate disaster-recovery procedures.

## 8. Conclusion

This portfolio demonstrated MongoDB replication through a practical three-member replica set based on the HMIS case study. The implementation provided evidence of data replication, secondary reads, automatic failover, and node recovery.

It also highlighted the importance of consistency, availability, and fault tolerance when designing distributed database systems for healthcare information management.