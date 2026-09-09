
ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('nt_factions:addFactions')
AddEventHandler('nt_factions:addFactions', function (data)
    MySQL.insert.await('INSERT INTO jobs (name,label) VALUES (?,?)', {
        data.name,
        data.label
    })
    MySQL.insert.await('INSERT INTO job_grades (job_name, grade, name, label) VALUES (?,?,?,?)',{
        data.name,
        0,
        'boss',
        'Boss'
    })
end)

RegisterNetEvent('nt_factions:list')
AddEventHandler('nt_factions:list', function ()
    local src = source
    local query = MySQL.query.await('SELECT * FROM jobs')
    local label, name = {}, {}
    for k,v in pairs(query)do
        if v.name == 'unemployed' then
        else
            table.insert(label, v.label)
            table.insert(name, v.name)
        end
    end
    local obj = {
        label = label,
        name = name
    }
    TriggerClientEvent('nt_factions:listShow', src, obj)
end)

RegisterNetEvent('nt_factions:delete')
AddEventHandler('nt_factions:delete', function (data)
    local id = json.decode(json.encode(data.id))
    local src = source
    MySQL.query.await('DELETE FROM jobs WHERE name = ?',{id})
    TriggerClientEvent('nt_factions:delFactions', src, id)
end)

RegisterNetEvent('nt_factions:addDeposito')
AddEventHandler('nt_factions:addDeposito', function(data)
    local src = source
    local query = MySQL.scalar.await('SELECT name FROM jobs WHERE name = ?', {
        data.fazione
    })
    if query == nil then
        TriggerClientEvent('esx:showNotification',src, 'Questa fazione è inesistente' )
    else
        local ranNum = math.random(1,9999)
        local depositName = tostring(data.label)
        local slots = tonumber(data.slot)
        local weight = tonumber(data.peso) * 1000
        local coords = vector3(tonumber(data.x),tonumber(data.y),tonumber(data.z))
        local id = string.sub(depositName, 2, 2) .. string.sub(tostring(slots), 1, 1) .. string.sub(tostring(weight), 1, 1).. string.sub(tostring(coords), 1, 1).. tostring(ranNum)
        exports.ox_inventory:RegisterStash(id, depositName, slots, weight, data.fazione)
        TriggerClientEvent('nt_factions:addDepositoMarker', src, id, depositName, data.x, data.y, data.z, data.fazione)
        MySQL.insert.await('INSERT INTO factionsdeposit (id,x,y,z,depositName,weight,slots,faction) VALUES (?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE id = ?', {
            id,
            data.x,
            data.y,
            data.z,
            depositName,
            weight,
            slots,
            data.fazione, 
            id
        })
        TriggerClientEvent('nt_factions:addDepositoMarker', src, id,depositName,x,y,z, data.fazione)
    end
    
    
end)

RegisterNetEvent('nt_factions:addBoss')
AddEventHandler('nt_factions:addBoss', function (data)
    local src = source
    local query = MySQL.scalar.await('SELECT name FROM jobs WHERE name = ?', {
        data.name
    })
    if query == nil then
        TriggerClientEvent('esx:showNotification',src, 'Questa fazione è inesistente' )
    else
        local ranNum = math.random(1,9999)
        local fazione = data.name
        local x = tonumber(data.x)
        local y = tonumber(data.y)
        local z = tonumber(data.z)
        local id = string.sub(data.x, 2, 2) .. string.sub(data.y, 1, 1) .. string.sub(data.z, 1, 1).. string.sub(fazione, 1, 1) .. tostring(ranNum)
        MySQL.insert.await('INSERT INTO factionsboss (id,x,y,z,faction) VALUES (?,?,?,?,?) ON DUPLICATE KEY UPDATE id = ?', {
            id,
            data.x,
            data.y,
            data.z,
            fazione,
            id
        })
        TriggerClientEvent('nt_factions:addBossMarker', src, id,fazione,x,y,z)
    end
end)

RegisterNetEvent('nt_factions:addVestiti')
AddEventHandler('nt_factions:addVestiti', function (data)
    local src = source
    local query = MySQL.scalar.await('SELECT name FROM jobs WHERE name = ?', {
        data.name
    })
    if query == nil then
        TriggerClientEvent('esx:showNotification',src, 'Questa fazione è inesistente' )
    else
        local ranNum = math.random(1,9999)
        local fazione = data.name
        local x = tonumber(data.x)
        local y = tonumber(data.y)
        local z = tonumber(data.z)
        local id = string.sub(data.x, 2, 2) .. string.sub(data.y, 1, 1) .. string.sub(data.z, 1, 1).. string.sub(fazione, 1, 1) .. tostring(ranNum)
        MySQL.insert.await('INSERT INTO factionsvestiti (id,x,y,z,faction) VALUES (?,?,?,?,?) ON DUPLICATE KEY UPDATE id = ?', {
            id,
            data.x,
            data.y,
            data.z,
            fazione,
            id
        })
        TriggerClientEvent('nt_factions:addVestitiMarker', src, id,fazione,x,y,z)
    end
end)

RegisterNetEvent('nt_factions:addVeicoli')
AddEventHandler('nt_factions:addVeicoli', function(data)
    local src = source
    local query = MySQL.scalar.await('SELECT name FROM jobs WHERE name = ?', {
        data.name
    })
    local hash1 = MySQL.scalar.await('SELECT model FROM vehicles WHERE model = ?', {
        data.veh1
    })
    local hash2 = MySQL.scalar.await('SELECT model FROM vehicles WHERE model = ?', {
        data.veh2
    })
    local hash3 = MySQL.scalar.await('SELECT model FROM vehicles WHERE model = ?', {
        data.veh3
    })


    if query == nil then
        TriggerClientEvent('esx:showNotification',src, 'Questa fazione è inesistente' )
    else
        if hash1 == nil then
            TriggerClientEvent('esx:showNotification',src, 'Veicolo 1 inesistente' )
        elseif hash2 == nil then
            TriggerClientEvent('esx:showNotification',src, 'Veicolo 2 inesistente' )
        elseif hash3 == nil then
            TriggerClientEvent('esx:showNotification',src, 'Veicolo 3 inesistente' )
        else
            local ranNum = math.random(1,9999)
            local fazione = data.name
            local x = tonumber(data.x)
            local y = tonumber(data.y)
            local z = tonumber(data.z)
            local veh1 = data.veh1
            local veh2 = data.veh2
            local veh3 = data.veh3
            local id = string.sub(data.x, 2, 2) .. string.sub(data.y, 1, 1) .. string.sub(data.z, 1, 1).. string.sub(fazione, 1, 1) .. tostring(ranNum)
            MySQL.insert.await('INSERT INTO factionsveicoli (id,x,y,z,faction,veh1,veh2,veh3) VALUES (?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE id = ?', {
            id,
            data.x,
            data.y,
            data.z,
            fazione,
            veh1,
            veh2,
            veh3,
            id
        })
        TriggerClientEvent('nt_factions:addVeicoliMarker', src, id,fazione,x,y,z,veh1,veh2,veh3)
        end
end
end)

RegisterNetEvent('nt_factions:reAddDepositi')
AddEventHandler('nt_factions:reAddDepositi', function()
    local src = source
    local query = MySQL.query.await('SELECT * FROM factionsdeposit')
    for k, v in pairs(query) do
        TriggerClientEvent('nt_factions:reAddDepositiShow', src, v.id, v.depositName, v.x, v.y, v.z, v.faction)
    end
end)

RegisterNetEvent('nt_factions:reAddBoss')
AddEventHandler('nt_factions:reAddBoss', function()
    local src = source
    local query = MySQL.query.await('SELECT * FROM factionsboss')
    for k, v in pairs(query) do
        TriggerClientEvent('nt_factions:reAddBossShow', src, v.id,  v.faction,v.x, v.y, v.z )
    end
end)

RegisterNetEvent('nt_factions:reAddVestiti')
AddEventHandler('nt_factions:reAddVestiti', function()
    local src = source
    local query = MySQL.query.await('SELECT * FROM factionsvestiti')
    for k, v in pairs(query) do
        TriggerClientEvent('nt_factions:reAddVestitiShow', src, v.id,  v.faction,v.x, v.y, v.z )
    end
end)

RegisterNetEvent('nt_factions:reAddVeicoli')
AddEventHandler('nt_factions:reAddVeicoli', function()
    local src = source
    local query = MySQL.query.await('SELECT * FROM factionsveicoli')
    for k, v in pairs(query) do
        TriggerClientEvent('nt_factions:reAddVeicoliShow', src, v.id,v.faction,v.x,v.y,v.z,v.veh1,v.veh2,v.veh3 )
    end
end)

