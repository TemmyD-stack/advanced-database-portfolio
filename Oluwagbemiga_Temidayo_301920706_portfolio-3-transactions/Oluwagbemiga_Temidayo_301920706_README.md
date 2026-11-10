# Portfolio 3: Transactions and Concurrency

## 1. Overview

This portfolio demonstrates transaction management, transaction isolation, and concurrency control using MySQL/MariaDB and the InnoDB storage engine.

The practical exercises were performed using the Hospital Management Information System (HMIS), a simulated hospital database developed for the MIT 8103 Advanced Database Systems assessment.

The database is named `hospital_management` and contains patient, doctor, appointment, diagnosis, prescription, and laboratory records.

## 2. Objectives

The objectives of this portfolio were to:

- Demonstrate transaction management using COMMIT and ROLLBACK.
- Examine transaction isolation using READ COMMITTED.
- Demonstrate concurrency control through row-level locking.
- Understand lock contention and lock wait timeouts.
- Apply advanced database concepts to a realistic hospital management scenario.

## 3. Database Environment

| Component | Technology |
|---|---|
| Database management system | MySQL/MariaDB |
| Storage engine | InnoDB |
| Local development environment | XAMPP |
| Database interface | phpMyAdmin |
| Command-line interface | MariaDB through XAMPP Shell |
| Database | hospital_management |

All seven existing relational tables were verified to use the InnoDB storage engine.

## 4. Practical Experiments

### Experiment 1: Transaction COMMIT

A fictional patient, Olivia James, was registered in the database within a transaction.

The COMMIT command permanently saved the new patient record.

The record was verified using a SELECT query, confirming that the transaction was committed.

### Experiment 2: Transaction ROLLBACK

A temporary patient record was inserted within a transaction.

The ROLLBACK command reversed the insertion before it was committed.

A verification query returned zero matching records, confirming that the temporary insertion had been reversed.

### Experiment 3: Transaction Isolation

Two independent MariaDB sessions were used to demonstrate the READ COMMITTED isolation level.

Session A updated Olivia James's address without immediately committing the change.

Session B initially retrieved the previously committed value, which was NULL.

After Session A executed COMMIT, Session B retrieved the updated address, `Isolation Test Address`.

This demonstrated the prevention of dirty reads.

### Experiment 4: Concurrency Control

Two independent MariaDB sessions were used to demonstrate row-level locking.

Session A acquired a lock on Olivia James's record using SELECT ... FOR UPDATE.

Session B attempted to update the same record but encountered a lock wait timeout.

MariaDB returned error 1205. Session B then executed ROLLBACK, and a verification query confirmed that the previously committed address remained unchanged.

## 5. Project Files

| File | Description |
|---|---|
| `transactions.sql` | SQL examples for COMMIT and ROLLBACK |
| `isolation-tests.sql` | SQL commands for the READ COMMITTED experiment |
| `concurrency-tests.sql` | SQL commands for the row-level locking experiment |
| `transaction-analysis.md` | Transaction management analysis |
| `isolation-analysis.md` | Transaction isolation analysis |
| `concurrency-analysis.md` | Concurrency control analysis |
| `screenshots/` | Practical outputs and supporting evidence |

## 6. How to Reproduce the Experiments

1. Start Apache and MySQL from the XAMPP Control Panel.
2. Open phpMyAdmin and select the `hospital_management` database.
3. Confirm that the relevant tables use InnoDB.
4. Execute the COMMIT and ROLLBACK examples in the transaction script, following the documented execution order.
5. Open two independent MariaDB command-line sessions through XAMPP Shell for the isolation experiment.
6. Execute the Session A and Session B commands in their documented order.
7. Repeat the two-session process for the concurrency experiment.
8. Compare the resulting database outputs with the screenshots and analysis documents.

**Important:** The isolation and concurrency experiments require two independent database connections. Their SQL statements must be executed in the specified order rather than as one continuous script in a single session.

## 7. Key Findings

The practical exercises demonstrated that:

- COMMIT permanently saves successful transaction changes.
- ROLLBACK reverses uncommitted changes.
- READ COMMITTED prevents transactions from reading uncommitted changes made by other sessions.
- SELECT ... FOR UPDATE acquires a row-level lock.
- Concurrent updates to a locked record may wait and eventually encounter a lock wait timeout.
- Proper transaction management and concurrency control help maintain database consistency.

## 8. Conclusion

Portfolio 3 applied advanced database transaction and concurrency concepts to the HMIS case study.

The experiments demonstrated transaction management, isolation between independent sessions, and row-level locking using InnoDB.

The practical results highlighted the importance of managing database transactions correctly, particularly in hospital systems where multiple users may access and modify shared patient information.

## 9. AI Use and Learning Support

ChatGPT was used as a learning and documentation support tool to help  structure SQL experiments, and review technical documentation.

The SQL commands were executed and tested in the local XAMPP/MariaDB environment. The practical observations and conclusions were reviewed against the actual database outputs.