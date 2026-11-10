/**
 * PORTFOLIO 4: NoSQL AND ADVANCED DATA MODELS
 * Case Study: Hospital Management Information System (HMIS)
 * Database: hospital_nosql
 * Collection: patients
 *
 * These operations can be executed in MongoDB Compass
 * using the mongosh interface.
 */

// Select the HMIS NoSQL database in mongosh
db = db.getSiblingDB("hospital_nosql");

// 1. CREATE: Insert a patient document
db.patients.insertOne({
    patient_id: 121,
    first_name: "Test",
    last_name: "CRUD",
    date_of_birth: "1996-05-12",
    gender: "Female",
    contact: {
        phone: "08020001121",
        email: "test.crud@hmis.test"
    },
    address: {
        city: "Ibadan",
        state: "Oyo"
    },
    medical_history: [
        {
            condition: "Malaria",
            diagnosed_date: "2026-10-15"
        }
    ],
    appointments: [
        {
            appointment_date: "2026-11-30",
            status: "Scheduled",
            doctor: "Dr. Adebayo"
        }
    ]
});

// 2. READ: Retrieve all female patients
db.patients.find({
    gender: "Female"
});

// 3. READ: Find patients living in Ibadan
db.patients.find({
    "address.city": "Ibadan"
});

// 4. READ: Find patients with hypertension
db.patients.find({
    "medical_history.condition": "Hypertension"
});

// 5. UPDATE: Modify a patient's surname and address
db.patients.updateOne(
    { patient_id: 101 },
    {
        $set: {
            last_name: "Adedayo",
            "address.city": "Ikeja",
            "address.state": "Lagos"
        }
    }
);

// Verify the updated patient information
db.patients.findOne(
    { patient_id: 101 },
    {
        first_name: 1,
        last_name: 1,
        address: 1
    }
);

// Verify the updated patient address
db.patients.findOne(
    { patient_id: 101 },
    {
        first_name: 1,
        last_name: 1,
        address: 1
    }
);

// 6. DELETE: Remove the temporary CRUD test document
db.patients.deleteOne({
    patient_id: 999
});

// Verify that the temporary document was deleted
db.patients.findOne({
    patient_id: 999
});

// 7. VERIFY: Display the total number of patient documents
db.patients.countDocuments();
