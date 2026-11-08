# Distributed Database Architecture – Hospital Management Information System (HMIS)

## 1. Introduction

A distributed database system stores and manages data across multiple interconnected database servers. Instead of relying on a single database server, multiple nodes work together to provide data availability, reliability, and improved fault tolerance.

For this exercise, a distributed database architecture was implemented for the Hospital Management Information System (HMIS) using MongoDB Replica Sets.

The implementation demonstrates how patient records can be replicated across multiple database nodes and how the system responds when the primary database server becomes unavailable.

## 2. Proposed Architecture

The HMIS distributed database uses a three-node MongoDB replica set named `hmisRS`.

The nodes operate on the same Windows computer but use separate ports and database storage directories.

| Node | Port | Initial role |
|---|---:|---|
| Node 1 | 27018 | PRIMARY |
| Node 2 | 27019 | SECONDARY |
| Node 3 | 27020 | SECONDARY |

MongoDB automatically elects one node as the PRIMARY, while the remaining two operate as SECONDARY nodes. These roles can change following an election if the current primary becomes unavailable.

The PRIMARY node handles write operations. The SECONDARY nodes maintain copies of the database through replication.

## 3. Architecture Components

### Primary Node

The primary node receives write operations, including inserting, updating, and deleting patient records. Changes are recorded in the replica set's operation log (oplog) and replicated to secondary nodes.

### Secondary Nodes

Secondary nodes maintain copies of the primary node's data. They can serve read operations when configured with an appropriate read preference.

If the primary node becomes unavailable, eligible secondary nodes can participate in an election to select a new primary.

### Replica Set

The replica set coordinates communication, replication, and elections among the three MongoDB instances.

The replica set identifier used in this exercise is `hmisRS`.

## 4. Data Flow

The distributed architecture follows this process:

1. An application sends a patient-record write operation to the PRIMARY node.
2. MongoDB records the operation in its oplog.
3. The changes are replicated to the SECONDARY nodes.
4. Secondary nodes apply the replicated changes to their local databases.
5. If the PRIMARY becomes unavailable, the remaining eligible members conduct an election.
6. A new PRIMARY is selected, allowing the replica set to continue accepting writes.

## 5. Benefits to the HMIS

The architecture provides the following benefits:

- **High availability:** The database can continue operating after an eligible primary node fails.
- **Data redundancy:** Multiple nodes maintain copies of patient records.
- **Fault tolerance:** Failure of one database instance does not necessarily make the entire database unavailable.
- **Read scalability:** Secondary nodes can support configured read operations.
- **Recovery:** A previously unavailable node can rejoin the replica set and synchronize with the current primary.

## 6. Implementation Limitations

Although three MongoDB instances were configured, all three nodes ran on one physical computer using localhost.

This demonstrates replica-set behaviour but does not provide complete physical fault isolation. For example, a failure of the computer itself could affect all three nodes.

In a production hospital environment, the nodes should be deployed on separate servers or cloud availability zones. Authentication, authorization, encrypted network communication, backups, and monitoring would also be required.

## 7. Sharding: Proposed Future Scalability Improvement

Sharding is a database scaling technique that divides a large dataset into smaller portions called shards. Each shard stores a different portion of the data, and the shards are distributed across multiple servers.

In the Hospital Management Information System (HMIS), sharding could become useful as the number of patients, appointments, prescriptions, and laboratory records increases across multiple hospital branches.

For example, the system could distribute patient records across different database servers using a suitable shard key. A possible approach would be to use a hashed `patient_id` as the shard key to distribute records more evenly.

This would allow different servers to store and process different portions of the patient database, reducing the storage and workload pressure on a single server.

### Sharding and Replication

Sharding and replication solve different database challenges:

- **Sharding** distributes different portions of a dataset across multiple servers to improve scalability.
- **Replication** maintains copies of the same dataset across multiple servers to improve availability and fault tolerance.

MongoDB can combine both approaches. Each shard can be configured as a replica set, providing both data distribution and redundancy.

MongoDB replica sets provide consistency through replication, but secondary nodes may temporarily lag behind the primary node. Consequently, reading from a secondary node may return slightly outdated data. Applications that require stronger read consistency should select appropriate read and write concerns based on their requirements.

### Proposed Benefits

- Improved horizontal scalability as the hospital's database grows.
- Distribution of storage and query workloads across multiple servers.
- Better capacity to support multiple hospital branches.
- Potentially improved query performance when queries target the relevant shard.

### Considerations

The shard key must be selected carefully because a poor choice can create uneven data distribution or workload bottlenecks. Queries that do not include the shard key may also need to access multiple shards.

Sharding was not implemented in this practical exercise. It is documented as a proposed future improvement. The practical implementation focused on MongoDB replica-set replication and automatic failover.

## 8. Conclusion

The three-node MongoDB replica set demonstrates how distributed database techniques can improve the reliability and availability of the Hospital Management Information System.

The practical implementation provides evidence of replica-set configuration, data replication, automatic primary election, failover, and node recovery.

Although the implementation was conducted on a single physical computer, it demonstrates important distributed database concepts. For a larger production environment, deploying nodes across separate servers or cloud availability zones would provide stronger fault isolation.

Sharding has also been identified as a potential future improvement for distributing large volumes of hospital records across multiple servers as the system grows.