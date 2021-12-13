ESX                           = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    LoadMarkers()
end) 

function Notification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function LoadMarkers()
    Citizen.CreateThread(function()
    
        while true do
            Citizen.Wait(5)

            local locjoueur = GetEntityCoords(PlayerPedId())

            for location, val in pairs(redirection.functionloc) do
                
                --Configurer dans le config.lua Entrer/Quitter

                local Entrer = val['Entrer']
                local Quitter = val['Quitter']

                --Localiser la position du joueur avec celle du marker

                local EntrerLoc, Quitterloc = GetDistanceBetweenCoords(locjoueur, Entrer['x'], Entrer['y'], Entrer['z'], true), GetDistanceBetweenCoords(locjoueur, Quitter['x'], Quitter['y'], Quitter['z'], true)

                if EntrerLoc <= 4.0 then
                    
                    --Monter 1
                    CouleurVert(Entrer['Entrer'], 27, Entrer['x'], Entrer['y'], Entrer['z'])

                        if EntrerLoc <= 1.2 then
                            if IsControlJustPressed(0, 18) then
                                Teleport(val, 'entrer')
                            end
                        end
                else
                        --Distance couleur entrer
                    CouleurBlue(Entrer['Information'], 27, Entrer['x'], Entrer['y'], Entrer['z'])

                        if EntrerLoc <= 0.25 then

                            if IsControlJustPressed(0, 18) then
                                Teleport(val, 'entrer')
                            end

                        end
                end

                if Quitterloc <= 4.0 then
                        --Quitter 1
                    CouleurRouge(Quitter['Quitter'], 27, Quitter['x'], Quitter['y'], Quitter['z'])

                        if Quitterloc <= 1.2 then
                            if IsControlJustPressed(0, 0) then
                                Teleport(val, 'quitter')
                            end
                        end
                else
                        --Distance couleur quitter
                    CouleurBlue(Quitter['Information'], 27, Quitter['x'], Quitter['y'], Quitter['z'])

                        if Quitterloc <= 0.25 then

                            if IsControlJustPressed(0, 0) then
                                Teleport(val, 'quitter')
                            end

                        end
                end

            end

        end

    end)
end

function Teleport(table, location)
    if location == 'entrer' then
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Quitter'])
        Notification("~g~Téléportation pour rentrer ~s~~h~réussit~s~~g~ avec succès !")
        DoScreenFadeIn(100)
    else
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Entrer'])

        Notification("~g~Téléportation pour sortir ~s~~h~réussit~s~~g~ avec succès !")

        DoScreenFadeIn(100)
    end
end

---Couleur du point pour retourner dans la téléportation"entrer"(Il est de la couleur que quand vous en êtes proche)

function CouleurRouge(hint, type, x, y, z)
    --ESX.Game.Utils.DrawText3D(coords, text, size, font)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.00}, hint, 0.8, 4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.00, 1.00, 1.00, 255, 0, 0, 150, false, false, 2, true, false, false, false)
end

---Couleur du point pour entrer dans la téléportation(Il est de la couleur que quand vous en êtes proche)

function CouleurVert(hint, type, x, y, z)
    --ESX.Game.Utils.DrawText3D(coords, text, size, font)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.00}, hint, 0.8, 4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.00, 1.00, 1.00, 0, 255, 0, 150, false, false, 2, true, false, false, false)
end

---Couleur de la distance entre vous est le point(il devient bleu à partir de 0.5 mètres IG)

function CouleurBlue(hint, type, x, y, z)
    --ESX.Game.Utils.DrawText3D(coords, text, size, font)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.00}, hint, 0.8, 4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.00, 1.00, 1.00, 0, 0, 255, 150, false, false, 2, true, false, false, false)
end