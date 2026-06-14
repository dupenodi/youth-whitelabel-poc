/// Controls which YOUTH health modules are enabled for this client.
///
/// Each flag maps to a full screen + navigation entry.
/// YOUTH ships all modules — clients opt in to what they need.
class YouthFeatures {
  /// Heart rate, blood pressure, SpO2, temperature cards.
  final bool showVitals;

  /// Doctor appointment list + booking CTA.
  final bool showAppointments;

  /// Live video consultation with a physician.
  /// Requires YOUTH Telemedicine add-on contract.
  final bool showTelemedicine;

  /// Prescription / supplement ordering.
  /// Requires YOUTH Marketplace add-on contract.
  final bool showPharmacy;

  const YouthFeatures({
    this.showVitals = true,
    this.showAppointments = true,
    this.showTelemedicine = false,
    this.showPharmacy = false,
  });

  Map<String, bool> toMap() => {
        'show_vitals': showVitals,
        'show_appointments': showAppointments,
        'show_telemedicine': showTelemedicine,
        'show_pharmacy': showPharmacy,
      };
}
