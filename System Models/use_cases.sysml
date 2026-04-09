package MedicalDeviceUseCases {

    // ---------------------------------------------------------
    //  SUBJECT (the system under consideration)
    // ---------------------------------------------------------

    part def PatientMonitor {
        doc /* The portable patient monitoring device. */
    }

    // ---------------------------------------------------------
    //  ACTORS
    // ---------------------------------------------------------

    part def Clinician {
        doc /* Healthcare professional who operates the device
               and acts on clinical data. */
    }

    part def Patient {
        doc /* Person whose vital signs are being monitored. */
    }

    part def Administrator {
        doc /* IT or clinical-engineering staff responsible for
               device configuration and user management. */
    }

    // ---------------------------------------------------------
    //  USE CASES
    // ---------------------------------------------------------

    use case def MonitorVitalSigns {
        doc /* Continuously acquire and display heart rate,
               SpO2 and respiration rate in real time. */
        subject sys      : PatientMonitor;
        actor   clinician : Clinician;
        actor   patient   : Patient;
    }

    use case def AcknowledgeAlarm {
        doc /* Review an active alarm triggered by an
               out-of-range measurement and silence it. */
        subject sys      : PatientMonitor;
        actor   clinician : Clinician;
    }

    use case def ConfigureAlarmThresholds {
        doc /* Set the upper and lower alarm limits for
               each monitored parameter. */
        subject sys      : PatientMonitor;
        actor   clinician : Clinician;
    }

    use case def ViewTrendData {
        doc /* Browse historical waveforms and parameter
               trends for the current patient session. */
        subject sys      : PatientMonitor;
        actor   clinician : Clinician;
        actor   patient   : Patient;
    }

    use case def ManageDeviceSettings {
        doc /* Configure network, software, and user-account
               settings on the device. */
        subject sys   : PatientMonitor;
        actor   admin : Administrator;
    }

}
