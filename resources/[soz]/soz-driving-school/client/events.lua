AddEventHandler("soz-driving-license:client:start_exam", function(data)
    Citizen.CreateThread(function()
        -- Check if spawn location is free
        local licenseType = data.license
        local vData = Config.Licenses[licenseType].vehicle
        if not vData then
            return
        end

        -- Check if vehicle spawn point free
        if not IsSpawnPointFree(vData.x, vData.y, vData.z) then
            TriggerEvent("hud:client:DrawNotification", "~r~Parking encombré, l'instructeur ne peut pas garer le véhicule d'examen.")
            return
        end

        -- Make player pay
        TriggerServerEvent("soz-driving-license:server:pay", licenseType)
    end)
end)

RegisterNetEvent("soz-driving-license:client:spawn_vehicle", function(licenseType)
    SetupDrivingSchoolExam(licenseType)
end)
