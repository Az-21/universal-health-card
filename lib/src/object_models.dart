// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Data Model: Health Card
// ⸻⸻⸻⸻⸻⸻⸻⸻
class HealthCardDataModel {
  // * Variables
  String key, name, aadharUID, bloodGroup, healthCondition;

  // * Constructor
  HealthCardDataModel(
    this.key,
    this.name,
    this.aadharUID,
    this.bloodGroup,
    this.healthCondition,
  );
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Data Model: Appointment
// ⸻⸻⸻⸻⸻⸻⸻⸻
class AppointmentDataModel {
  // * Variables
  String hospital, identifier, specialization;
  DateTime appointmentTime;

  // * Constructor
  AppointmentDataModel(
    this.hospital,
    this.identifier,
    this.specialization,
    this.appointmentTime,
  );
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Data Model: Prescription
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionDataModel {
  // * Variables
  String identifier, timestamp, submitterName, submitterOrg;
  bool submitterVerified;
  List<String> medicineList;
  List<List<bool>> medicineStats;

  // * Constructor
  PrescriptionDataModel(
    this.identifier,
    this.timestamp,
    this.submitterName,
    this.submitterOrg,
    this.submitterVerified,
    this.medicineList,
    this.medicineStats,
  );
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Data Model: Notes
// ⸻⸻⸻⸻⸻⸻⸻⸻
class NotesDataModel {
  // * Variables
  String identifier, temp, weight, height, bpS, bpD, notes;

  // * Constructor
  NotesDataModel(
    this.identifier,
    this.temp,
    this.weight,
    this.height,
    this.bpS,
    this.bpD,
    this.notes,
  );
}
