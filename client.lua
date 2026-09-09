local display = false
ESX = nil
ESX = exports["es_extended"]:getSharedObject()

function car(veh)
    local car = GetHashKey(veh)
    RequestModel(car)
    while not HasModelLoaded(car)do
        RequestModel(car)
        Wait(0)
    end
    local coords = GetEntityCoords(PlayerPedId(), false)
    print(coords.x)
    local vehicle = CreateVehicle(car,coords.x+3,coords.y+3,coords.z+1, 0.0,true,false)
    SetEntityAsMissionEntity(vehicle,true,true)
    TaskWarpPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('nt_factions:SetDisplay')
AddEventHandler('nt_factions:SetDisplay', function(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end)
function disableControl(display)
    DisableControlAction(0,1, display)
    DisableControlAction(0,142, display)
    DisableControlAction(0,18, display)
    DisableControlAction(0,322, display)
    DisableControlAction(0,2, display)
    DisableControlAction(0,106, display)
end


--GUARDAROBA
TriggerServerEvent('nt_factions:reAddVestiti')
RegisterNUICallback('add-vestiti',function (data)
    TriggerServerEvent('nt_factions:addVestiti', data)
end)
RegisterNetEvent('nt_factions:addVestitiMarker')
AddEventHandler('nt_factions:addVestitiMarker', function(id,fazione,x,y,z)
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = 'Guardaroba',
            permission = fazione,
            action = function()
                exports['fivem-appearance']:startPlayerCustomization()
            end
        })
    end)
end)
RegisterNetEvent('nt_factions:reAddVestitiShow')
AddEventHandler('nt_factions:reAddVestitiShow', function(id,fazione,x,y,z)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = 'Guardaroba',
            permission = fazione,
            action = function()
                exports['fivem-appearance']:startPlayerCustomization()
            end
        })
    end)
end)

--BOSSMENU
TriggerServerEvent('nt_factions:reAddBoss')
RegisterNUICallback('add-boss', function (data)
    TriggerServerEvent('nt_factions:addBoss', data)
end)
RegisterNetEvent('nt_factions:addBossMarker')
AddEventHandler('nt_factions:addBossMarker', function(id,fazione,x,y,z)
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = 'Boss Menu',
            permission = fazione,
            action = function()
            exports.esx_society:OpenBossMenu(fazione)
            end
        })
    end)
end)
RegisterNetEvent('nt_factions:reAddBossShow')
AddEventHandler('nt_factions:reAddBossShow', function(id,fazione,x,y,z)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = 'Boss Menu',
            permission = fazione,
            action = function()
                exports.esx_society:OpenBossMenu(fazione)
            end
        })
    end)
end)

--DEPOSITO
TriggerServerEvent('nt_factions:reAddDepositi')
RegisterNUICallback('add-deposito', function(data)
    TriggerServerEvent('nt_factions:addDeposito',data)
end)
RegisterNetEvent('nt_factions:addDepositoMarker')
AddEventHandler('nt_factions:addDepositoMarker', function(id, depositName, x,y,z, fazione)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = depositName,
            permission = fazione,
            action = function()
            exports.ox_inventory:openInventory('stash', {id=id})
            end
        })
    end)
end)
RegisterNetEvent('nt_factions:reAddDepositiShow')
AddEventHandler('nt_factions:reAddDepositiShow', function(id,depositName,x,y,z, fazione)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = depositName,
            permission = fazione,
            action = function()
                exports.ox_inventory:openInventory('stash', {id=id})
            end
        })
    end)
end)

--LIST
RegisterNUICallback('list',function ()
    TriggerServerEvent('nt_factions:list')
end)
RegisterNetEvent('nt_factions:listShow')
AddEventHandler('nt_factions:listShow', function (data)
    SendNUIMessage({
        type = "list",
        data = data,
    })
end)
RegisterNetEvent('nt_factions:delFactions')
AddEventHandler('nt_factions:delFactions', function(data) 
    SendNUIMessage{
        type="delStats",
        data = data
    }
end)
RegisterNUICallback('delete', function(data) 
    TriggerServerEvent('nt_factions:delete', data)
end)

--VEICOLI
TriggerServerEvent('nt_factions:reAddVeicoli')
RegisterNUICallback('add-veicoli', function(data)
    TriggerServerEvent('nt_factions:addVeicoli',data)
end)
RegisterNetEvent('nt_factions:addVeicoliMarker')
AddEventHandler('nt_factions:addVeicoliMarker', function ( id,fazione,x,y,z,veh1,veh2,veh3)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    Elements = {
        {label = veh1:gsub("^%l", string.upper), name = "element1", hash=veh1},
        {label = veh2:gsub("^%l", string.upper), name = "element2",hash=veh2},
        {label = veh3:gsub("^%l", string.upper), name = "element3",hash=veh3},
        {label = 'Deposita Veicolo', name="deposit"}

    }
    CreateThread(
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            permission = fazione,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = 'Garage',
            action = function()
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Example_Menu", {
                    title = "Garage", -- The Name of Menu to show to users,
                    align    = Config.TextAlignGarage, -- top-left | top-right | bottom-left | bottom-right | center |
                    elements = Elements -- define elements as the pre-created table
                  }, function(data,menu) -- OnSelect Function
                    --- for a simple element
                    if data.current.name == "element1" then
                      car(data.current.hash)
                      menu.close()
                    end
                    if data.current.name == "element2" then
                        car(data.current.hash)
                        menu.close()
                      end
                    if data.current.name == "element3" then
                        car(data.current.hash)
                        menu.close()
                      end
                      if data.current.name == "deposit" then
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        DeleteEntity(veh)
                        menu.close()
                    end
                  end, function(data, menu) -- Cancel Function
                    
                    menu.close() -- close menu
                  end)
            end
        })
    )
end)
RegisterNetEvent('nt_factions:reAddVeicoliShow')
AddEventHandler('nt_factions:reAddVeicoliShow', function(id,fazione,x,y,z,veh1,veh2,veh3)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    Elements = {
        {label = veh1:gsub("^%l", string.upper), name = "element1", hash=veh1},
        {label = veh2:gsub("^%l", string.upper), name = "element2",hash=veh2},
        {label = veh3:gsub("^%l", string.upper), name = "element3",hash=veh3},
        {label = 'Deposita Veicolo', name="deposit"}
    }
    CreateThread(function ()
        TriggerEvent('gridsystem:registerMarker', {
            name = id,
            pos = vector3(x,y,z) ,
            size = vector3(1.2, 1.2, 1.2),
            scale = vector3(0.8, 0.8, 0.8),
            control = 'E',
            rotate = 0.0,
            rotate2 = 0.0,
            shouldBob = false,
            shouldRotate = true,
            trasparent = 255,
            color =  { r = 130, g = 120, b = 110 },
            type = 21,
            msg = 'Garage',
            permission = fazione,
            action = function()
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Example_Menu", {
                    title = "Garage", -- The Name of Menu to show to users,
                    align    = Config.TextAlignGarage, -- top-left | top-right | bottom-left | bottom-right | center |
                    elements = Elements -- define elements as the pre-created table
                  }, function(data,menu) -- OnSelect Function
                    --- for a simple element
                    if data.current.name == "element1" then
                      car(data.current.hash)
                      menu.close()
                    end
                    if data.current.name == "element2" then
                        car(data.current.hash)
                        menu.close()
                      end
                    if data.current.name == "element3" then
                        car(data.current.hash)
                        menu.close()
                      end
                    if data.current.name == "deposit" then
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                            DeleteEntity(veh)
                        menu.close()
                    end
                  end, function(data, menu) -- Cancel Function
                    
                    menu.close() -- close menu
                  end)
            end
        })
    end)
end)

RegisterNUICallback("exit", function(data)
    TriggerEvent('nt_factions:SetDisplay', false)
 end)
 RegisterNUICallback("discord", function()
    TriggerEvent('nt_factions:discord')
 end)
 RegisterNUICallback('add-fazione', function (data)
    TriggerServerEvent('nt_factions:addFactions', data)
    TriggerEvent('esx:showNotification', 'Fazione Aggiunta')
 end)




RegisterNetEvent('nt_factions:discord')
AddEventHandler('nt_factions:discord', function()
    TriggerEvent('esx:showNotification', 'https://discord.gg/r2zgnnC8Tq')
end)



RegisterCommand('factions', function (source, args, raw)
        CreateThread(function()
            TriggerEvent('nt_factions:SetDisplay', true)
            while display do 
                disableControl(display)
                Wait(0)
            end
        end)
end)

RegisterKeyMapping('factions', 'Open Factions Menu', 'keyboard', 'g')