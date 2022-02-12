Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash
Config.DirtLevel = 0.1 -- carwash dirt level

ConsumeablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
}

ConsumeablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
}

ConsumeablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

Config.BlacklistedScenarios = {
    ["TYPES"] = {"WORLD_VEHICLE_MILITARY_PLANES_SMALL", "WORLD_VEHICLE_MILITARY_PLANES_BIG"},
    ["GROUPS"] = {2017590552, 2141866469, 1409640232, GetHashKey("ng_planes")},
}

Config.BlacklistedVehs = {
    [GetHashKey("SHAMAL")] = true,
    [GetHashKey("LUXOR")] = true,
    [GetHashKey("LUXOR2")] = true,
    [GetHashKey("JET")] = true,
    [GetHashKey("LAZER")] = true,
    [GetHashKey("BUZZARD")] = true,
    [GetHashKey("BUZZARD2")] = true,
    [GetHashKey("ANNIHILATOR")] = true,
    [GetHashKey("SAVAGE")] = true,
    [GetHashKey("TITAN")] = true,
    [GetHashKey("RHINO")] = true,
    [GetHashKey("FIRETRUK")] = true,
    [GetHashKey("MULE")] = true,
    [GetHashKey("MAVERICK")] = true,
    [GetHashKey("BLIMP")] = true,
    [GetHashKey("AIRTUG")] = true,
    [GetHashKey("CAMPER")] = true,
    [GetHashKey("HYDRA")] = true,
    [GetHashKey("OPPRESSOR")] = true,
    [GetHashKey("technical3")] = true,
    [GetHashKey("insurgent3")] = true,
    [GetHashKey("apc")] = true,
    [GetHashKey("tampa3")] = true,
    [GetHashKey("trailersmall2")] = true,
    [GetHashKey("halftrack")] = true,
    [GetHashKey("hunter")] = true,
    [GetHashKey("vigilante")] = true,
    [GetHashKey("akula")] = true,
    [GetHashKey("barrage")] = true,
    [GetHashKey("khanjali")] = true,
    [GetHashKey("caracara")] = true,
    [GetHashKey("blimp3")] = true,
    [GetHashKey("menacer")] = true,
    [GetHashKey("oppressor2")] = true,
    [GetHashKey("scramjet")] = true,
    [GetHashKey("strikeforce")] = true,
    [GetHashKey("cerberus")] = true,
    [GetHashKey("cerberus2")] = true,
    [GetHashKey("cerberus3")] = true,
    [GetHashKey("scarab")] = true,
    [GetHashKey("scarab2")] = true,
    [GetHashKey("scarab3")] = true,
    [GetHashKey("rrocket")] = true,
    [GetHashKey("ruiner2")] = true,
    [GetHashKey("deluxo")] = true,
}

Config.BlacklistedPeds = {
    [GetHashKey("s_m_y_ranger_01")] = true,
    [GetHashKey("s_m_y_sheriff_01")] = true,
    [GetHashKey("s_m_y_cop_01")] = true,
    [GetHashKey("s_f_y_sheriff_01")] = true,
    [GetHashKey("s_f_y_cop_01")] = true,
    [GetHashKey("s_m_y_hwaycop_01")] = true,
}

Config.Teleports = {}

Config.CarWash = { -- carwash
    [1] = {["label"] = "Lavage Auto", ["coords"] = vector3(25.29, -1391.96, 29.33)},
    [2] = {["label"] = "Lavage Auto", ["coords"] = vector3(174.18, -1736.66, 29.35)},
    [3] = {["label"] = "Lavage Auto", ["coords"] = vector3(-74.56, 6427.87, 31.44)},
    [5] = {["label"] = "Lavage Auto", ["coords"] = vector3(1363.22, 3592.7, 34.92)},
    [6] = {["label"] = "Lavage Auto", ["coords"] = vector3(-699.62, -932.7, 19.01)},
}