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
  String hospital, aadharUID, specialization;
  DateTime appointmentTime;

  // * Constructor
  AppointmentDataModel(
    this.hospital,
    this.aadharUID,
    this.specialization,
    this.appointmentTime,
  );
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Data Model: Prescription
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionDataModel {
  // * Variables
  String aadharUID, timestamp, submitterName, submitterOrg;
  bool submitterVerified;
  List<String> medicineList;
  List<List<bool>> medicineStats;

  // * Constructor
  PrescriptionDataModel(
    this.aadharUID,
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
  String aadharUID, temp, weight, height, bpS, bpD, notes;

  // * Constructor
  NotesDataModel(
    this.aadharUID,
    this.temp,
    this.weight,
    this.height,
    this.bpS,
    this.bpD,
    this.notes,
  );
}
