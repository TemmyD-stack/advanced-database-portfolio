/**
 * PORTFOLIO 4: NoSQL AND ADVANCED DATA MODELS
 * Case Study: Hospital Management Information System (HMIS)
 * Database: hospital_nosql
 * Collection: patients
 *
 * Aggregation Pipeline:
 * Analyzes the frequency of medical conditions recorded
 * in patients' medical history.
 *
 * Execute using MongoDB Shell (mongosh).
 */

// Select the HMIS NoSQL database
db = db.getSiblingDB("hospital_nosql");

// 1. UNWIND: Separate medical history entries into individual documents
// 2. GROUP: Count occurrences of each medical condition
// 3. SORT: Arrange conditions from highest to lowest frequency

db.patients.aggregate([
    {
        $unwind: "$medical_history"
    },
    {
        $group: {
            _id: "$medical_history.condition",
            totalPatients: {
                $sum: 1
            }
        }
    },
    {
        $sort: {
            totalPatients: -1
        }
    }
]);