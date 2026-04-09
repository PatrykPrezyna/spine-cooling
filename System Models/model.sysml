// =============================================================
//  SysML v2 — Simple Medical Device Model
//  Device: Portable Patient Monitor
// =============================================================

package MedicalDeviceModel {

    // ---------------------------------------------------------
    //  1. USER NEEDS
    // ---------------------------------------------------------

    requirement def UserNeed;

    package UserNeeds {

        requirement <'UN-01'> measureVitalSigns : UserNeed {
            doc /* The device shall allow clinicians to measure
                   patient vital signs continuously. */
        }

        requirement <'UN-02'> displayRealTimeData : UserNeed {
            doc /* The device shall display real-time measurements
                   in a clear, readable format. */
        }

        requirement <'UN-03'> alertAbnormalValues : UserNeed {
            doc /* The device shall alert the clinician when a
                   measurement exceeds safe thresholds. */
        }

        requirement <'UN-04'> portableAndBatteryPowered : UserNeed {
            doc /* The device shall be portable and operate on
                   battery power for at least 8 hours. */
        }

        requirement <'UN-05'> safeForPatient : UserNeed {
            doc /* The device shall not cause harm to the patient
                   during normal use. */
        }
    }

    // ---------------------------------------------------------
    //  2. FUNCTIONAL REQUIREMENTS
    // ---------------------------------------------------------

    requirement def FunctionalRequirement;

    package FunctionalRequirements {

        requirement <'FR-01'> measureHeartRate : FunctionalRequirement {
            doc /* The device shall measure heart rate in the range
                   30-300 bpm with +/-2 bpm accuracy.
                   Traces to: UN-01 */
        }

        requirement <'FR-02'> measureSpO2 : FunctionalRequirement {
            doc /* The device shall measure blood oxygen saturation
                   (SpO2) in the range 70-100% with +/-2% accuracy.
                   Traces to: UN-01 */
        }

        requirement <'FR-03'> measureRespirationRate : FunctionalRequirement {
            doc /* The device shall measure respiration rate in the
                   range 4-60 breaths/min with +/-1 breath/min accuracy.
                   Traces to: UN-01 */
        }

        requirement <'FR-04'> showLiveWaveforms : FunctionalRequirement {
            doc /* The device shall display live waveforms and numeric
                   values updated at least once per second.
                   Traces to: UN-02 */
        }

        requirement <'FR-05'> triggerAudioVisualAlarm : FunctionalRequirement {
            doc /* The device shall trigger an audible (>=65 dB) and
                   visual alarm within 5 s of detecting an out-of-range
                   value.
                   Traces to: UN-03 */
        }

        requirement <'FR-06'> configurableAlarmThresholds : FunctionalRequirement {
            doc /* Clinicians shall be able to configure alarm
                   thresholds per parameter within prescribed limits.
                   Traces to: UN-03 */
        }

        requirement <'FR-07'> batteryLifeEightHours : FunctionalRequirement {
            doc /* The internal battery shall sustain full operation
                   for a minimum of 8 continuous hours.
                   Traces to: UN-04 */
        }

        requirement <'FR-08'> electricalIsolation : FunctionalRequirement {
            doc /* All patient-contact parts shall be electrically
                   isolated to meet IEC 60601-1 Type CF requirements.
                   Traces to: UN-05 */
        }
    }

    // ---------------------------------------------------------
    //  3. LOGICAL ARCHITECTURE
    // ---------------------------------------------------------

    part def Sensor;
    part def Actuator;
    part def Controller;
    part def EnergyStore;

    port def SignalPort;
    port def DataPort;
    port def AlarmPort;
    port def PowerPort;
    port def ConfigPort;

    part def SensingSubsystem {
        doc /* Acquires raw physiological signals from the patient. */
        part ecgSensor  : Sensor { doc /* Heart rate / ECG */      }
        part spo2Sensor : Sensor { doc /* Pulse oximetry (SpO2) */ }
        part respSensor : Sensor { doc /* Respiration rate */      }
        port rawSignalOut : ~SignalPort;
        port powerIn      :  PowerPort;
    }

    part def ProcessingUnit {
        doc /* Filters, computes parameters, detects alarm conditions. */
        port rawSignalIn      :  SignalPort;
        port processedDataOut : ~DataPort;
        port alarmEventOut    : ~AlarmPort;
        port configIn         :  ConfigPort;
        port powerIn          :  PowerPort;
    }

    part def DisplaySubsystem {
        doc /* Renders waveforms and numeric values on screen. */
        port dataIn  :  DataPort;
        port powerIn :  PowerPort;
    }

    part def AlarmSubsystem {
        doc /* Generates audible and visual alarms. */
        part buzzer     : Actuator { doc /* Audio alarm >= 65 dB */ }
        part alarmLight : Actuator { doc /* Visual alarm LED */     }
        port alarmEventIn : AlarmPort;
        port powerIn      : PowerPort;
    }

    part def PowerSubsystem {
        doc /* Manages battery charging, regulation and distribution. */
        part battery      : EnergyStore { doc /* Li-Ion, >= 8 h */   }
        part powerManager : Controller  { doc /* Voltage regulator */ }
        port powerOut : ~PowerPort;
    }

    part def UserInterface {
        doc /* Touch-screen and buttons for clinician interaction. */
        port dataIn    :  DataPort;
        port configOut : ~ConfigPort;
        port powerIn   :  PowerPort;
    }

    part def PatientMonitor {
        doc /* Top-level logical block for the portable patient monitor. */

        part sensingSubsystem : SensingSubsystem;
        part processingUnit   : ProcessingUnit;
        part displaySubsystem : DisplaySubsystem;
        part alarmSubsystem   : AlarmSubsystem;
        part powerSubsystem   : PowerSubsystem;
        part userInterface    : UserInterface;

        flow sensingSubsystem.rawSignalOut   to processingUnit.rawSignalIn;
        flow processingUnit.processedDataOut to displaySubsystem.dataIn;
        flow processingUnit.alarmEventOut    to alarmSubsystem.alarmEventIn;        flow processingUnit.processedDataOut to userInterface.dataIn;
        flow userInterface.configOut         to processingUnit.configIn;
        flow powerSubsystem.powerOut         to sensingSubsystem.powerIn;
        flow powerSubsystem.powerOut         to processingUnit.powerIn;
        flow powerSubsystem.powerOut         to displaySubsystem.powerIn;
        flow powerSubsystem.powerOut         to alarmSubsystem.powerIn;
    }

    // ---------------------------------------------------------
    //  4. REQUIREMENT SATISFACTION
    //     Section A — User Needs satisfied by Functional Requirements
    // ---------------------------------------------------------

    satisfy UserNeeds::measureVitalSigns
        by FunctionalRequirements::measureHeartRate;

    satisfy UserNeeds::measureVitalSigns
        by FunctionalRequirements::measureSpO2;

    satisfy UserNeeds::measureVitalSigns
        by FunctionalRequirements::measureRespirationRate;

    satisfy UserNeeds::displayRealTimeData
        by FunctionalRequirements::showLiveWaveforms;

    satisfy UserNeeds::alertAbnormalValues
        by FunctionalRequirements::triggerAudioVisualAlarm;

    satisfy UserNeeds::alertAbnormalValues
        by FunctionalRequirements::configurableAlarmThresholds;

    satisfy UserNeeds::portableAndBatteryPowered
        by FunctionalRequirements::batteryLifeEightHours;

    satisfy UserNeeds::safeForPatient
        by FunctionalRequirements::electricalIsolation;

    // ---------------------------------------------------------
    //  5. VIEWS
    // ---------------------------------------------------------

    view def RequirementsView {
        doc /* View showing only requirements */
        include UserNeeds::*;
        include FunctionalRequirements::*;
    }

    view requirementsView : RequirementsView;

}
