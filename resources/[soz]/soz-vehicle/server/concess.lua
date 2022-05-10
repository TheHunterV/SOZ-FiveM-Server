local QBCore = exports["qb-core"]:GetCoreObject()

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.Sync.fetchScalar("SELECT plate FROM player_vehicles WHERE plate = ?", {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

QBCore.Functions.CreateCallback("soz-concess:server:getstock", function(source, cb, RpcCategorie)
    local vehiclestock = MySQL.Sync.fetchAll("SELECT * FROM concess_storage WHERE category = ?", {RpcCategorie})
    if vehiclestock[1] then
        cb(vehiclestock)
    end
end)

RegisterNetEvent("soz-concess:server:buyShowroomVehicle", function(concess, vehicle)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local money = pData.PlayerData.money["money"]
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]["price"]
    local plate = GeneratePlate()
    local depotprice = math.ceil(vehiclePrice / 100)
    if depotprice < 100 then
        depotprice = 100
    end
    local vehiclestock = MySQL.Sync.fetchAll("SELECT stock FROM concess_storage WHERE model = @model", {
        ["@model"] = vehicle,
    })
    if vehiclestock[1].stock > 0 then
        if money >= vehiclePrice then
            pData.Functions.RemoveMoney("money", vehiclePrice, "vehicle-bought-in-showroom")
            local garage
            if concess == "pdm" then
                garage = "airportpublic"
                TriggerClientEvent("hud:client:DrawNotification", src, "Merci pour votre achat! Le véhicule a été envoyé dans le Parking Public Sud")
            elseif concess == "velo" then
                garage = "airportpublic"
                TriggerClientEvent("hud:client:DrawNotification", src, "Merci pour votre achat! Le véhicule a été envoyé dans le Parking Public Sud")
            else
                garage = "haanparking"
                TriggerClientEvent("hud:client:DrawNotification", src, "Merci pour votre achat! Le véhicule a été envoyé dans le Parking Public Nord")
            end
            MySQL.Async.insert(
                "INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state, depotprice, boughttime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                {pData.PlayerData.license, cid, vehicle, GetHashKey(vehicle), "{}", plate, garage, 1, depotprice, os.time()})
            MySQL.Async.execute("UPDATE concess_storage SET stock = stock - 1 WHERE model = ?", {vehicle})
        else
            TriggerClientEvent("hud:client:DrawNotification", src, "Pas assez d'argent", "error")
        end
    else
        TriggerClientEvent("hud:client:DrawNotification", src, "Plus de stock", "error")
    end
end)
