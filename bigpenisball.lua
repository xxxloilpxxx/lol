local s,e = pcall(function()
    if not(game.PlaceId == 3527629287) then return end
    repeat
		task.wait()
	until game:IsLoaded()
	getgenv().__mpho_1__loaded__ = true

    getgenv = getgenv

    --MODULES
	local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
	local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
    local ESPFramework = loadstring(game:HttpGet("https://raw.githubusercontent.com/NougatBitz/Femware-Leak/main/ESP.lua", true))()
	local Notify = AkaliNotif.Notify;
	local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)
	local Player = game:GetService("Players").LocalPlayer
	local settings = {
		autoLoadConfigs = nil,
	}
    local ESPSettings = {
        PlayerESP = {
            Enabled = getgenv()._esp,
            TracersOn = getgenv()._esptracers,
            BoxesOn = getgenv()._espboxes,
            NamesOn = getgenv()._espnames,
            DistanceOn = getgenv()._espdistance,
            AttachShift = getgenv()._esptracerattachshift,
            HealthOn = false,
            ToolOn = false,
            TeamMates = getgenv()._espteamcheck,
            FaceCamOn = false,
            Distance = 2000,
        },
        ScrapESP = {
            Enabled = false,
            Distance = 2000,
            LegendaryOnly = true,
            RareOnly = true,
            GoodOnly = true,
            BadOnly = true
        },
        SafeESP = {
            Enabled = false,
            Distance = 2000,
            BigOnly = true,
            SmallOnly = true
        },
        RegisterESP = {
            Enabled = false,
            Distance = 2000
        },
        ESPColor = Color3.fromRGB(255, 255, 255),
        ToolColor = Color3.fromRGB(255, 255, 255)
    }
    local game_client = {}

    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Mouse = Player:GetMouse()
    local RunService = game:GetService("RunService")

	local flying,bv,bav,h,c,cam,nc,Clip,rstr
	local p = game.Players.LocalPlayer
	local buttons = {W = false, S = false, A = false, D = false, Moving = false}

    --ENV
    getgenv().ESPFramework = ESPFramework
    getgenv()._esptracerattachshift = 1
    getgenv()._WINDOW = {
		Tabs = {},
	}

	--WINDOW CONFIG
	local _TABS = {
		"Weapon",
		"Visual",
		"Character",
		"Credits"
	}

    local _FUNCTIONS = {
        ["Weapon"] = {
			{
				Function = "CreateSection",
				Args = "━ Silent Aim  ━",
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Silent Aimbot",
					Flag = "_silentaimbot",
					Callback = function(Value)
						getgenv()._silentaimbot = Value
					end,
				}
			},
			{
                Function = "CreateParagraph",
                Args = {
                    Title = "Notes:",
                    Content = "! Silent Aimbot will also wallbang. !"
                }
            },
			--[[{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Wallbang",
					Flag = "_wallbang",
					Callback = function(Value)
						getgenv()._wallbang = Value
					end,
				}
			},]]
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Draw FOV",
					Flag = "_drawfov",
					Callback = function(Value)
						getgenv()._drawfov = Value
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 50,
				Args = {
					Name = "FOV",
					Flag = "fov",
					Range = {0, 360},
					Increment = 1,
					Suffix = "",
					CurrentValue = 80,
					Callback = function(Value)
						getgenv().fov = Value
					end,
				}
			},
            {
				Function = "CreateSection",
				Args = "━ Gun Mods ━",
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Automatic",
					Flag = "_automatic",
					Callback = function(Value)
						getgenv()._automatic = Value
                        if Value == true then
                            game_client:enableGunMod("automatic")
                        else
                            game_client:disableGunMod("automatic")
                        end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Rapid Fire",
					Flag = "_rapidfire",
					Callback = function(Value)
						getgenv()._rapidfire = Value
                        if Value == true then
                            game_client:enableGunMod("rapidfire")
                        else
                            game_client:disableGunMod("rapidfire")
                        end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Straight Shot",
					Flag = "_straightshot",
					Callback = function(Value)
						getgenv()._straightshot = Value
                        if Value == true then
                            game_client:enableGunMod("straightshot")
                        else
                            game_client:disableGunMod("straightshot")
                        end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "One Shot",
					Flag = "_oneshot",
					Callback = function(Value)
						getgenv()._oneshot = Value
                        if Value == true then
                            game_client:enableGunMod("damage")
                        else
                            game_client:disableGunMod("damage")
                        end
					end,
				}
			},
        },
        ["Visual"] = {
            {
				Function = "CreateSection",
				Args = "━ ESP ━",
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "ESP",
					Flag = "_esp",
					Callback = function(Value)
						getgenv()._esp = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Boxes",
					Flag = "_espboxes",
					Callback = function(Value)
						getgenv()._espboxes = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Tracers",
					Flag = "_esptracers",
					Callback = function(Value)
						getgenv()._esptracers = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateDropdown",
				_envState = "Bottom",
				Args = {
					Name = "Tracers Orientation",
					Flag = "_tracersorientation",
					Options = {"Bottom","Middle","Top"},
					CurrentOption = "Bottom",
					Callback = function(Value)
                        local v = 0

                        if Value == "Bottom" then
                            v = 1
                        elseif Value == "Middle" then
                            v = 2
                        elseif Value == "Top" then
                            v = 1000
                        end
						getgenv()._esptracerattachshift = v or 0
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Names",
					Flag = "_espnames",
					Callback = function(Value)
						getgenv()._espnames = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Distance",
					Flag = "_espdistance",
					Callback = function(Value)
						getgenv()._espdistance = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState = true,
				Args = {
					Name = "Team Check",
					Flag = "_espteamcheck",
					Callback = function(Value)
						getgenv()._espteamcheck = not Value
                        getgenv().updateespvalues()
					end,
				}
			},
        },
        ["Character"] = {
			{
				Function = "CreateSection",
				Args = "━ Infinite Jump ━"
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Infinite Jump",
					Flag = "_infjump",
					Callback = function(Value)
						getgenv()._infinitejump = Value
					end,
				}
			},
			{
				Function = "CreateSection",
				Args = "━ NoClip ━",
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "NoClip",
					Flag = "_noclip",
					Callback = function(Value)
						getgenv()._noclip = Value
						if Value == true then
							game_client:noclip()
						else
							game_client:clip()
						end
					end,
				}
			},
			{
				Function = "CreateSection",
				Args = "━ Speed Hack ━"
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Speed Hack",
					Flag = "_speedhack",
					Callback = function(Value)
						getgenv()._speedhack = Value
                        if Value == true then
                            game_client:enableGunMod("speed")
                        else
                            game_client:disableGunMod("speed")
                        end
					end,
				}
			},
            {
                Function = "CreateParagraph",
                Args = {
                    Title = "Notes:",
                    Content = "! Sprint once to apply the speed hack !"
                }
            },
        },
    }

    local _CREDITS = {
		["Developers"] = {
			{"ShyFlooo","Programmer"},
		},
	}

    --Functions | Source: some self made

    --CREATE WINDOW
	local Window = Rayfield:CreateWindow({
		Name = "BIG Paintball",
		LoadingTitle = "BIG Paintball",
		LoadingSubtitle = "by ShyFlooo",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "/notmopshubxd/.config", -- Create a custom folder for your hub/game
			FileName = "notmopshubxd_bigpaintball"
		}
	})

	--SETUP WINDOW
	for index, name in pairs(_TABS) do
		local w = Window:CreateTab(name)
		getgenv()._WINDOW.Tabs[name] = w
	end
    getgenv()._WINDOW.Tabs["Credits"]:CreateSection("━ Credits ━")
	for index, value in pairs(_CREDITS) do
		local content = ""
		for i,data in pairs(value) do
			if #data[2] > 0 then
				content = content.."\n"..data[1].." - ".. data[2]
			else
				content = content.."\n"..data[1]
			end
		end
		getgenv()._WINDOW.Tabs["Credits"]:CreateParagraph({Title = index, Content = content})
	end

	for index, funcs in pairs(_FUNCTIONS) do
		print("Loaded "..#funcs.." function(s) for ".. index)
		for i, func in pairs(funcs) do
			if func.Function and func.Args then
				local Tab = getgenv()._WINDOW.Tabs[index]
				if Tab then
					local s,e = pcall(function()
						local f,l = func.Function, true
						if f == "CreateSection" then
							Tab:CreateSection(func.Args)
						elseif f == "CreateButton" then
							Tab:CreateButton(func.Args)
						elseif f == "CreateToggle" then
							Tab:CreateToggle(func.Args)
						elseif f == "CreateDropdown" then
							Tab:CreateDropdown(func.Args)
						elseif f == "CreateInput" then
							Tab:CreateInput(func.Args)
						elseif f == "CreateSlider" then
							Tab:CreateSlider(func.Args)
						elseif f == "CreateParagraph" then
							Tab:CreateParagraph(func.Args)
						elseif f == "CreateLabel" then
							Tab:CreateLabel(func.Args)
						elseif f == "CreateKeybind" then
							Tab:CreateKeybind(func.Args)
						else
							l = false
						end; if l == true then
							--print("Created function "..tostring(func.Args.Flag or func.Args or "unknown").. " for ".. index.. " ["..string.gsub(func.Function, "Create", "").. "]")
						else
							print("Unable to create "..tostring(func.Function).. " function for ".. index .. " ["..i.."]")
						end
		
						if func.Args.Flag then
							--print("Creating env ".. tostring(func.Args.Flag) .. " with the value ".. tostring(func._envState))
							getgenv()[func.Args.Flag] = func._envState
						end
					end)
					if not s and e then
						print("[notmopshubxd UI Loader Error]: > "..e)
					end
				end
			end
		end
	end

    getgenv().updateespvalues = function()
        ESPFramework.Color = ESPSettings.ESPColor
        ESPFramework.ToolColor = ESPSettings.ToolColor
        ESPFramework.Tracers = getgenv()._esptracers
        ESPFramework.Names = getgenv()._espnames
        ESPFramework.Health = getgenv()._esphealth
        ESPFramework.Distance = getgenv()._espdistance
        ESPFramework.Tool = getgenv()._esptool
        ESPFramework.Boxes = getgenv()._espboxes
        ESPFramework.FaceCamera = ESPSettings.PlayerESP.FaceCamOn
        ESPFramework.TeamMates = getgenv()._espteamcheck
        ESPFramework.AttachShift = getgenv()._esptracerattachshift
        ESPFramework:Toggle(getgenv()._esp)
    end; getgenv().updateespvalues()

    --> Setup client stuff
    local g = getgc(true)

    if not getgenv().__mh_gunsbackup_ then
        getgenv().__mh_gunsbackup_ = true
        getgenv().gunsbackup = {}
        for _,v in pairs(g) do
            if typeof(v) == "table" then
                if rawget(v,"shotrate") then
                    pcall(function()
                        getgenv().gunsbackup[v.displayName] = {
                            shotrate = v.shotrate,
                            automatic = v.automatic,
                            velocity = v.velocity,
                            damage = v.damage,
                            additionalSpeed = v.additionalSpeed,
                        }
                    end)
                end
            end
        end
    end; function game_client:enableGunMod(mod)
        for _,v in pairs(g) do
            if typeof(v) == "table" then
                if rawget(v,"shotrate") then
                    if mod == "rapidfire" then
                        v.shotrate = 0.037
                    elseif mod == "automatic" then
                        v.automatic = true
                    elseif mod == "straightshot" then
                        v.velocity = 5 + 994
                    elseif mod == "damage" then
                        v.damage = 999
                    elseif mod == "speed" then
                        v.additionalSpeed = 50
                    elseif mod == "all" then
                        v.shotrate = 0.037
                        v.automatic = true
                        v.velocity = 5 + 994
                        v.damage = 999
                        v.additionalSpeed = 50
                    end
                end
            end
        end
    end; function game_client:disableGunMod(mod)
        for _,v in pairs(g) do
            if typeof(v) == "table" then
                if rawget(v,"shotrate") then
                    pcall(function()
                        if mod == "rapidfire" then
                            v.shotrate = getgenv().gunsbackup[v.displayName].shotrate
                        elseif mod == "automatic" then
                            v.automatic = getgenv().gunsbackup[v.displayName].automatic
                        elseif mod == "straightshot" then
                            v.velocity = getgenv().gunsbackup[v.displayName].velocity
                        elseif mod == "damage" then
                            v.damage = getgenv().gunsbackup[v.displayName].damage
                        elseif mod == "speed" then
                            v.additionalSpeed = getgenv().gunsbackup[v.displayName].additionalSpeed
                        elseif mod == "all" then
                            v.shotrate = getgenv().gunsbackup[v.displayName].shotrate
                            v.automatic = getgenv().gunsbackup[v.displayName].automatic
                            v.velocity = getgenv().gunsbackup[v.displayName].velocity
                            v.damage = getgenv().gunsbackup[v.displayName].damage
                            v.additionalSpeed = getgenv().gunsbackup[v.displayName].additionalSpeed
                        end
                    end)
                end
            end
        end
    end; function game_client:fly()
		if not p.Character or not p.Character.Head or flying then return end
		c = p.Character
		h = c.Humanoid
		h.PlatformStand = true
		cam = workspace:WaitForChild('Camera')
		bv = Instance.new("BodyVelocity")
		bav = Instance.new("BodyAngularVelocity")
		bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
		bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
		bv.Parent = c.Head
		bav.Parent = c.Head
		flying = true
		h.Died:Connect(function() flying = false end)
	end; function game_client:unfly()
		if not p.Character or not flying then return end
		h.PlatformStand = false
		bv:Destroy()
		bav:Destroy()
		flying = false
	end; function game_client:noclip()
		Clip = false
		local function ncl()
			if Clip == false and Player.Character ~= nil then
				for _, child in pairs(Player.Character:GetDescendants()) do
					if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= rstr then
						child.CanCollide = false
					end
				end
			end
		end
		nc = RunService.Stepped:Connect(ncl)
	end; function game_client:clip()
		if nc then
			nc:Disconnect()
		end
	end;

	--> MAIN

	--Infinite Jump | Source: idk

	function Action(Object, Function) if Object ~= nil then Function(Object); end end

	game:GetService('UserInputService').InputBegan:Connect(function(UserInput)
		if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
			if not getgenv()._infinitejump then return end
			Action(game:GetService('Players').LocalPlayer.Character.Humanoid, function(self)
				if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
					Action(self.Parent.HumanoidRootPart, function(self)
						self.Velocity = Vector3.new(0, getgenv()._infjumpheight or 50, 0);
					end)
				end
			end)
		end
	end)

	--Silent Aimbot

	local function indexExists(object, index)
		local _, value = pcall(function() return object[index] end)
		return value
	end

	local function get_character(player) return indexExists(player, 'Character') end
	local function get_mouse_location() return game:GetService("UserInputService"):GetMouseLocation() end
	local function is_alive(player) return player.Character and player.Character:FindFirstChild('Humanoid') and player.Character:FindFirstChild('Humanoid').Health > 0 end
	local function is_team(player) return #game:GetService("Teams"):GetChildren() > 0 and player.Team == Player.Team end

	local function isVisible(position, ignore)
		return #workspace.CurrentCamera:GetPartsObscuringTarget({ position }, ignore) == 0;
	end;

	local function getClosestPlayerToCursor(fov)
		local maxDistance = fov or math.huge
		local closestPlayer = nil
		local closestPlayerDistance = math.huge

		for _, player in pairs(Players:GetPlayers()) do
			if player ~= Player and not is_team(player) and get_character(player) and is_alive(player) then
				local pos, on_screen = workspace.CurrentCamera.WorldToViewportPoint(workspace.CurrentCamera, get_character(player).Head.Position)

				if not on_screen then continue end

				local distance = (get_mouse_location() - Vector2.new(pos.X, pos.Y)).Magnitude
				if distance <= maxDistance and distance < closestPlayerDistance then
					closestPlayer = player
					closestPlayerDistance = distance
				end
			end
		end

		return closestPlayer
	end

	local OldNamecall
	OldNamecall = hookmetamethod(workspace, '__namecall', newcclosure(function(...)
		local args = { ... }
		local method = string.lower(getnamecallmethod())
		local caller = getcallingscript()
		if method == 'findpartonraywithwhitelist' and tostring(caller) == 'First Person Controller' and getgenv()._silentaimbot then
			local HitPart = getgenv().target and getgenv().target.Character and getgenv().target.Character.Head or nil
			if HitPart then
				local Origin = HitPart.Position + Vector3.new(0, 5, 0)
				local Direction = (HitPart.Position - Origin)
				args[2] = Ray.new(Origin, Direction)
				return OldNamecall(unpack(args))
			else
				return OldNamecall(...)
			end
		end
		return OldNamecall(...)
	end))

	--FOV Circle Object
	local FOVCircle
    if Drawing then
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Thickness = 2
        FOVCircle.NumSides = 50
        FOVCircle.Filled = false
        FOVCircle.Transparency = 0.6
        FOVCircle.Radius = getgenv().fov;
        FOVCircle.Color = Color3.new(0, 1, 0.298039)
    else
        warn("[notmopshubxd Loader Error]: Missing function Drawing. Your executor might be too bad and doesn't support it! (Draw FOV disabled)")
    end

	RunService.Stepped:Connect(function()
		--FOV
		if Drawing and FOVCircle ~= nil then
            FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
            FOVCircle.Radius = getgenv().fov;
            FOVCircle.Visible = getgenv()._drawfov;
        end
        if getgenv()._rainbowgun then
            for _, v in pairs(game.Workspace.Camera.Arms:GetChildren()) do
				if v:IsA("BasePart") then
					v.Color = Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)
					v.Transparency = 0.5
					v.Material = "ForceField"
				end
			end
        end

		--Silent Aimbot Target
		getgenv().target = getClosestPlayerToCursor(getgenv().fov)
	end)
end)
if not s and e then
    print("[notmopshubxd Error]: "..e)
end
