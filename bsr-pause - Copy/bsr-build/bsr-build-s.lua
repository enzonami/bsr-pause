if bsr_config.framework == 'QB' then
    local QBCore = exports[bsr_config.QB]:GetCoreObject()

    CreateThread(function()
        while true do
            local players = QBCore.Functions.GetQBPlayers()

            if players and #players > 0 then
                if bsr_config.jobs then
                    for _, job in pairs(bsr_config.jobs) do
                        job.count = 0

                        for _, player in pairs(players) do
                            if player.PlayerData and player.PlayerData.job and player.PlayerData.job.name == job.name and player.PlayerData.job.onduty then
                                job.count = job.count + 1
                            end
                        end
                    end
                else
                    print("Error: bsr_config.jobs is not defined.")
                end
            end

            Wait(10000)
        end
    end)

    QBCore.Functions.CreateCallback('bsr-pausemenu:GetData', function(source, cb)
        local Player = QBCore.Functions.GetPlayer(source)
        cb({
            bsr_data = {
                bsr_firstName = Player.PlayerData.charinfo.firstname,
                bsr_lastName = Player.PlayerData.charinfo.lastname,
                bsr_birthdate = Player.PlayerData.charinfo.birthdate,
                bsr_job = Player.PlayerData.job.label,
                bsr_grade = Player.PlayerData.job.grade.name,
                bsr_gender = Player.PlayerData.charinfo.gender,
                bsr_cash = Player.PlayerData.money['cash'],
                bsr_bank = Player.PlayerData.money['bank']
            },
            bsr_jobs = bsr_config.jobs
        })
    end)
elseif bsr_config.framework == 'ESX' then
    local ESX = exports[bsr_config.ESX]:getSharedObject()

    CreateThread(function()
        while true do
            local players = ESX.GetExtendedPlayers()

            if players and #players > 0 then
                if bsr_config.jobs then
                    for _, job in pairs(bsr_config.jobs) do
                        job.count = 0

                        for _, player in pairs(players) do
                            if player.job and player.job.name == job.name and player.job.onduty then
                                job.count = job.count + 1
                            end
                        end
                    end
                else
                    print("Error: bsr_config.jobs is not defined.")
                end
            end

            Wait(10000)
        end
    end)

    ESX.RegisterServerCallback('bsr-pausemenu:GetData', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        cb({
            bsr_data = {
                bsr_firstName = xPlayer.get('firstName'),
                bsr_lastName = xPlayer.get('lastName'),
                bsr_birthdate = xPlayer.get('dateofbirth'),
                bsr_job = xPlayer.job.label,
                bsr_grade = xPlayer.job.grade_label,
                bsr_gender = xPlayer.get('sex'),
                bsr_cash = xPlayer.getAccount('money').money,
                bsr_bank = xPlayer.getAccount('bank').money
            },
            bsr_jobs = bsr_config.jobs
        })
    end)
end

RegisterNetEvent('bsr-pausemenu:Disconnect', function()
    local src = source
    DropPlayer(src, bsr_config.disconnect)
end)
