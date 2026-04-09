package FilterExample {
    private import RiskMetadata::*;
    metadata def FlightCritical;

    part def DroneSystem {
        part sensor;
        #FlightCritical part controller;
        part camera { @Risk { technicalRisk = RiskLevelEnum::high; } }
        part radio { @Risk { technicalRisk = RiskLevelEnum::medium; } }
        #FlightCritical part battery { @Risk { technicalRisk = RiskLevelEnum::low; } }

        action processData;
        connection dataLink connect sensor to controller;
        allocate processData to controller;
        connect camera to controller;
    }
}