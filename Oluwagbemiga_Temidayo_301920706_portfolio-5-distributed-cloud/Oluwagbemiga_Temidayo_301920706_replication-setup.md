# MongoDB Replica Set Configuration and Implementation

## 1. Introduction

This practical exercise demonstrates database replication using MongoDB Replica Sets for the Hospital Management Information System (HMIS).

A three-node replica set named `hmisRS` was configured to demonstrate data replication, primary-secondary relationships, automatic failover, and node recovery.

## 2. Tools and Environment

The implementation used:

- MongoDB Community Server 9.0.4
- MongoDB Shell (mongosh) 2.14.1
- Windows operating system
- Visual Studio Code terminal
- MongoDB Compass

## 3. Creating the Replica Set Nodes

Three MongoDB instances were configured using separate database storage directories and ports.

The following directories were created:

- `C:\mongodb-replica\node1`
- `C:\mongodb-replica\node2`
- `C:\mongodb-replica\node3`

Each MongoDB instance was started with the replica set name `hmisRS`.

### Node 1 – Port 27018

```powershell
& "C:\Program Files\MongoDB\Server\9.0\bin\mongod.exe" --replSet hmisRS --port 27018 --dbpath "C:\mongodb-replica\node1" --bind_ip localhost
```

### Node 2 – Port 27019

```powershell
& "C:\Program Files\MongoDB\Server\9.0\bin\mongod.exe" --replSet hmisRS --port 27019 --dbpath "C:\mongodb-replica\node2" --bind_ip localhost
```

### Node 3 – Port 27020

```powershell
& "C:\Program Files\MongoDB\Server\9.0\bin\mongod.exe" --replSet hmisRS --port 27020 --dbpath "C:\mongodb-replica\node3" --bind_ip localhost
```

All three instances started successfully and listened on their respective ports.

## 4. Initialising the Replica Set

After starting all three instances, MongoDB Shell was connected to Node 1.

The following command was executed to initialise the replica set:

```javascript
rs.initiate({
  _id: "hmisRS",
  members: [
    { _id: 0, host: "localhost:27018" },
    { _id: 1, host: "localhost:27019" },
    { _id: 2, host: "localhost:27020" }
  ]
})
```

MongoDB returned:

```javascript
{ ok: 1 }
```

This confirmed that the replica set configuration was accepted.

## 5. Verifying Replica Set Status

The following command was used to inspect the roles of all members:

```javascript
rs.status().members.map(member => ({
  name: member.name,
  state: member.stateStr
}))
```

The initial configuration showed:

| Node | Port | State |
|---|---:|---|
| Node 1 | 27018 | PRIMARY |
| Node 2 | 27019 | SECONDARY |
| Node 3 | 27020 | SECONDARY |

The PRIMARY node was responsible for accepting write operations, while the SECONDARY nodes maintained replicated copies of the data.

## 6. Testing Data Replication

A separate database named `hmis_replication_demo` was created for the replication experiment.

The following document was inserted into the `patients` collection on the PRIMARY node:

```javascript
use hmis_replication_demo

db.patients.insertOne({
  patient_id: 501,
  first_name: "Femi",
  last_name: "Adebayo",
  gender: "Male",
  department: "Cardiology",
  record_type: "Replication Test"
})
```

The document was verified on the PRIMARY using:

```javascript
db.patients.findOne({ patient_id: 501 })
```

The same document was then retrieved from Node 2 after connecting directly to port `27019` and setting the read preference to secondary:

```javascript
db.getMongo().setReadPref("secondary")

use hmis_replication_demo

db.patients.findOne({ patient_id: 501 })
```

The document was successfully retrieved from Node 2, confirming that the data had been replicated to a SECONDARY member.

## 7. Testing Automatic Failover

To test fault tolerance, the PRIMARY node (Node 1) was deliberately stopped while Node 2 and Node 3 remained running.

The process associated with port `27018` was identified using PowerShell:

```powershell
Get-CimInstance Win32_Process |
Where-Object { $_.CommandLine -like '*27018*' } |
Select-Object ProcessId, CommandLine
```

The process was then stopped using its identified process ID:

```powershell
Stop-Process -Id <PID>
```

The replica set status was checked again:

```javascript
rs.status().members.map(member => ({
  name: member.name,
  state: member.stateStr
}))
```

The result showed:

| Node | State |
|---|---|
| Node 1 – 27018 | Not reachable/healthy |
| Node 2 – 27019 | SECONDARY |
| Node 3 – 27020 | PRIMARY |

Node 3 was automatically elected as the new PRIMARY after Node 1 became unavailable.

The patient record was also verified after the election to confirm that the replicated data remained accessible.

## 8. Testing Node Recovery

Node 1 was restarted using its original MongoDB startup command and storage directory.

After rejoining the replica set, the final status showed:

| Node | Port | State |
|---|---:|---|
| Node 1 | 27018 | SECONDARY |
| Node 2 | 27019 | PRIMARY |
| Node 3 | 27020 | SECONDARY |

This confirmed that the recovered node successfully rejoined the replica set and that the cluster continued operating with a new PRIMARY.

## 9. Conclusion

The practical implementation successfully demonstrated MongoDB replica set configuration, data replication, automatic failover, and node recovery.

The experiment showed how replica sets can reduce dependence on a single database server and improve the availability of hospital patient records.