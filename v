if not owner then owner = game:GetService("Players"):GetPlayerFromCharacter(script.Parent) end

--local storage = game:GetService("ServerStorage")
local mapObjs = Instance.new("Folder")
mapObjs.Name, mapObjs.Parent = "Map", script
local map = Instance.new("Folder")
map.Name, map.Parent = "Map", script
local ground = Instance.new("Folder")
ground.Name, ground.Parent = "Ground", map
local maptiles = Instance.new("Folder")
maptiles.Name, maptiles.Parent = "Tiles", map
-- basic tiles --
local BasicTiles = Instance.new("Folder")
BasicTiles.Name = "Basic Tiles"

local LargeRoom = Instance.new("Model")
LargeRoom.Name = "LargeRoom"
LargeRoom.WorldPivot = CFrame.new(-135, 0, -90)
LargeRoom.Parent = BasicTiles

local Cell6 = Instance.new("SpawnLocation")
Cell6.Name = "Cell"
Cell6.Anchored, Enabled = true, false
Cell6.BottomSurface = Enum.SurfaceType.Smooth
Cell6.TopSurface = Enum.SurfaceType.Smooth
Cell6.Color = Color3.fromRGB(99, 95, 98)
Cell6.Material = Enum.Material.Wood
Cell6.Size = Vector3.new(15, 1, 15)
Cell6.CFrame = CFrame.new(-150, 0, -90)
Cell6.Parent = LargeRoom

local Boundaries2 = Instance.new("Folder")
Boundaries2.Name = "Boundaries"
Boundaries2.Parent = LargeRoom

local Boundary5 = Instance.new("SpawnLocation")
Boundary5.Name = "Boundary"
Boundary5.Anchored, Enabled = true, false
Boundary5.BottomSurface = Enum.SurfaceType.Smooth
Boundary5.CanCollide = false
Boundary5.Transparency = 0.8
Boundary5.TopSurface = Enum.SurfaceType.Smooth
Boundary5.Color = Color3.fromRGB(180, 128, 255)
Boundary5.Material = Enum.Material.Wood
Boundary5.Size = Vector3.new(13, 12, 1)
Boundary5.CFrame = CFrame.new(-157, 5.5, -90, -2.9802322387695312e-08, 0, 1, 0, 1, 0, -1, 0, -2.9802322387695312e-08)
Boundary5.CanTouch = false
Boundary5.Parent = Boundaries2

local Boundary6 = Instance.new("SpawnLocation")
Boundary6.Name = "Boundary"
Boundary6.Anchored, Enabled = true, false
Boundary6.BottomSurface = Enum.SurfaceType.Smooth
Boundary6.CanCollide = false
Boundary6.Transparency = 0.8
Boundary6.TopSurface = Enum.SurfaceType.Smooth
Boundary6.Color = Color3.fromRGB(180, 128, 255)
Boundary6.Material = Enum.Material.Wood
Boundary6.Size = Vector3.new(13, 12, 1)
Boundary6.CFrame = CFrame.new(-135, 5.5, -112, 1, 0, 2.9802322387695312e-08, 0, 1, 0, -2.9802322387695312e-08, 0, 1)
Boundary6.CanTouch = false
Boundary6.Parent = Boundaries2

local Boundary7 = Instance.new("SpawnLocation")
Boundary7.Name = "Boundary"
Boundary7.Anchored, Enabled = true, false
Boundary7.BottomSurface = Enum.SurfaceType.Smooth
Boundary7.CanCollide = false
Boundary7.Transparency = 0.8
Boundary7.TopSurface = Enum.SurfaceType.Smooth
Boundary7.Color = Color3.fromRGB(180, 128, 255)
Boundary7.Material = Enum.Material.Wood
Boundary7.Size = Vector3.new(13, 12, 1)
Boundary7.CFrame = CFrame.new(-135, 5.5, -68, -1, 0, -2.9802322387695312e-08, 0, 1, 0, 2.9802322387695312e-08, 0, -1)
Boundary7.CanTouch = false
Boundary7.Parent = Boundaries2

local Boundary8 = Instance.new("SpawnLocation")
Boundary8.Name = "Boundary"
Boundary8.Anchored, Enabled = true, false
Boundary8.BottomSurface = Enum.SurfaceType.Smooth
Boundary8.CanCollide = false
Boundary8.Transparency = 0.8
Boundary8.TopSurface = Enum.SurfaceType.Smooth
Boundary8.Color = Color3.fromRGB(180, 128, 255)
Boundary8.Material = Enum.Material.Wood
Boundary8.Size = Vector3.new(13, 12, 1)
Boundary8.CFrame = CFrame.new(-113, 5.5, -90, 2.9802322387695312e-08, 0, -1, 0, 1, 0, 1, 0, 2.9802322387695312e-08)
Boundary8.CanTouch = false
Boundary8.Parent = Boundaries2

local Cell7 = Instance.new("SpawnLocation")
Cell7.Name = "Cell"
Cell7.Anchored, Enabled = true, false
Cell7.BottomSurface = Enum.SurfaceType.Smooth
Cell7.TopSurface = Enum.SurfaceType.Smooth
Cell7.Color = Color3.fromRGB(99, 95, 98)
Cell7.Material = Enum.Material.Wood
Cell7.Size = Vector3.new(15, 1, 15)
Cell7.CFrame = CFrame.new(-150, 0, -105)
Cell7.Parent = LargeRoom

local Floor3 = Instance.new("SpawnLocation")
Floor3.Name = "Floor"
Floor3.Anchored, Enabled = true, false
Floor3.BottomSurface = Enum.SurfaceType.Smooth
Floor3.TopSurface = Enum.SurfaceType.Smooth
Floor3.Color = Color3.fromRGB(99, 95, 98)
Floor3.Material = Enum.Material.Wood
Floor3.Size = Vector3.new(45, 1, 45)
Floor3.CFrame = CFrame.new(-135, 0, -90)
Floor3.Parent = LargeRoom

local Cell8 = Instance.new("SpawnLocation")
Cell8.Name = "Cell"
Cell8.Anchored, Enabled = true, false
Cell8.BottomSurface = Enum.SurfaceType.Smooth
Cell8.TopSurface = Enum.SurfaceType.Smooth
Cell8.Color = Color3.fromRGB(99, 95, 98)
Cell8.Material = Enum.Material.Wood
Cell8.Size = Vector3.new(15, 1, 15)
Cell8.CFrame = CFrame.new(-135, 0, -105)
Cell8.Parent = LargeRoom

local Cell9 = Instance.new("SpawnLocation")
Cell9.Name = "Cell"
Cell9.Anchored, Enabled = true, false
Cell9.BottomSurface = Enum.SurfaceType.Smooth
Cell9.TopSurface = Enum.SurfaceType.Smooth
Cell9.Color = Color3.fromRGB(99, 95, 98)
Cell9.Material = Enum.Material.Wood
Cell9.Size = Vector3.new(15, 1, 15)
Cell9.CFrame = CFrame.new(-120, 0, -90)
Cell9.Parent = LargeRoom

local Cell10 = Instance.new("SpawnLocation")
Cell10.Name = "Cell"
Cell10.Anchored, Enabled = true, false
Cell10.BottomSurface = Enum.SurfaceType.Smooth
Cell10.TopSurface = Enum.SurfaceType.Smooth
Cell10.Color = Color3.fromRGB(99, 95, 98)
Cell10.Material = Enum.Material.Wood
Cell10.Size = Vector3.new(15, 1, 15)
Cell10.CFrame = CFrame.new(-120, 0, -105)
Cell10.Parent = LargeRoom

local Cell11 = Instance.new("SpawnLocation")
Cell11.Name = "Cell"
Cell11.Anchored, Enabled = true, false
Cell11.BottomSurface = Enum.SurfaceType.Smooth
Cell11.TopSurface = Enum.SurfaceType.Smooth
Cell11.Color = Color3.fromRGB(99, 95, 98)
Cell11.Material = Enum.Material.Wood
Cell11.Size = Vector3.new(15, 1, 15)
Cell11.CFrame = CFrame.new(-150, 0, -75)
Cell11.Parent = LargeRoom

local Cell12 = Instance.new("SpawnLocation")
Cell12.Name = "Cell"
Cell12.Anchored, Enabled = true, false
Cell12.BottomSurface = Enum.SurfaceType.Smooth
Cell12.TopSurface = Enum.SurfaceType.Smooth
Cell12.Color = Color3.fromRGB(99, 95, 98)
Cell12.Material = Enum.Material.Wood
Cell12.Size = Vector3.new(15, 1, 15)
Cell12.CFrame = CFrame.new(-135, 0, -75)
Cell12.Parent = LargeRoom

local Cell13 = Instance.new("SpawnLocation")
Cell13.Name = "Cell"
Cell13.Anchored, Enabled = true, false
Cell13.BottomSurface = Enum.SurfaceType.Smooth
Cell13.TopSurface = Enum.SurfaceType.Smooth
Cell13.Color = Color3.fromRGB(99, 95, 98)
Cell13.Material = Enum.Material.Wood
Cell13.Size = Vector3.new(15, 1, 15)
Cell13.CFrame = CFrame.new(-120, 0, -75)
Cell13.Parent = LargeRoom

local Cell14 = Instance.new("SpawnLocation")
Cell14.Name = "Cell"
Cell14.Anchored, Enabled = true, false
Cell14.BottomSurface = Enum.SurfaceType.Smooth
Cell14.TopSurface = Enum.SurfaceType.Smooth
Cell14.Color = Color3.fromRGB(99, 95, 98)
Cell14.Material = Enum.Material.Wood
Cell14.Size = Vector3.new(15, 1, 15)
Cell14.CFrame = CFrame.new(-135, 0, -90)
Cell14.Parent = LargeRoom

local Part7 = Instance.new("SpawnLocation")
Part7.Anchored, Enabled = true, false
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Material = Enum.Material.WoodPlanks
Part7.Size = Vector3.new(15, 11, 1)
Part7.CFrame = CFrame.new(-113, 6, -76, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Part7.Parent = LargeRoom

local Part8 = Instance.new("SpawnLocation")
Part8.Anchored, Enabled = true, false
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Material = Enum.Material.WoodPlanks
Part8.Size = Vector3.new(15, 11, 1)
Part8.CFrame = CFrame.new(-157, 6, -76, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part8.Parent = LargeRoom

local Part9 = Instance.new("SpawnLocation")
Part9.Anchored, Enabled = true, false
Part9.BottomSurface = Enum.SurfaceType.Smooth
Part9.TopSurface = Enum.SurfaceType.Smooth
Part9.Material = Enum.Material.WoodPlanks
Part9.Size = Vector3.new(15, 11, 1)
Part9.CFrame = CFrame.new(-157, 6, -104, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part9.Parent = LargeRoom

local Part10 = Instance.new("SpawnLocation")
Part10.Anchored, Enabled = true, false
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Material = Enum.Material.WoodPlanks
Part10.Size = Vector3.new(15, 11, 1)
Part10.CFrame = CFrame.new(-113, 6, -104, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Part10.Parent = LargeRoom

local Part11 = Instance.new("SpawnLocation")
Part11.Anchored, Enabled = true, false
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Material = Enum.Material.WoodPlanks
Part11.Size = Vector3.new(16, 11, 1)
Part11.CFrame = CFrame.new(-149.5, 6, -112)
Part11.Parent = LargeRoom

local Part12 = Instance.new("SpawnLocation")
Part12.Anchored, Enabled = true, false
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Material = Enum.Material.WoodPlanks
Part12.Size = Vector3.new(16, 11, 1)
Part12.CFrame = CFrame.new(-120.5, 6, -112)
Part12.Parent = LargeRoom

local Part13 = Instance.new("SpawnLocation")
Part13.Anchored, Enabled = true, false
Part13.BottomSurface = Enum.SurfaceType.Smooth
Part13.TopSurface = Enum.SurfaceType.Smooth
Part13.Material = Enum.Material.WoodPlanks
Part13.Size = Vector3.new(16, 11, 1)
Part13.CFrame = CFrame.new(-120.5, 6, -68, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Part13.Parent = LargeRoom

local Part14 = Instance.new("SpawnLocation")
Part14.Anchored, Enabled = true, false
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.TopSurface = Enum.SurfaceType.Smooth
Part14.Material = Enum.Material.WoodPlanks
Part14.Size = Vector3.new(16, 11, 1)
Part14.CFrame = CFrame.new(-149.5, 6, -68, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Part14.Parent = LargeRoom

local ShortHall1 = Instance.new("Model")
ShortHall1.Name = "ShortHall"
ShortHall1.WorldPivot = CFrame.new(-105, 0, 90)
ShortHall1.Parent = BasicTiles

local Cell33 = Instance.new("SpawnLocation")
Cell33.Name = "Cell"
Cell33.Anchored, Enabled = true, false
Cell33.BottomSurface = Enum.SurfaceType.Smooth
Cell33.TopSurface = Enum.SurfaceType.Smooth
Cell33.Color = Color3.fromRGB(99, 95, 98)
Cell33.Material = Enum.Material.Wood
Cell33.Size = Vector3.new(15, 1, 15)
Cell33.CFrame = CFrame.new(-105, 0, 90)
Cell33.Parent = ShortHall1

local Floor10 = Instance.new("SpawnLocation")
Floor10.Name = "Floor"
Floor10.Anchored, Enabled = true, false
Floor10.BottomSurface = Enum.SurfaceType.Smooth
Floor10.TopSurface = Enum.SurfaceType.Smooth
Floor10.Color = Color3.fromRGB(99, 95, 98)
Floor10.Material = Enum.Material.Wood
Floor10.Size = Vector3.new(15, 1, 45)
Floor10.CFrame = CFrame.new(-105, 0, 90)
Floor10.Parent = ShortHall1

local Cell34 = Instance.new("SpawnLocation")
Cell34.Name = "Cell"
Cell34.Anchored, Enabled = true, false
Cell34.BottomSurface = Enum.SurfaceType.Smooth
Cell34.TopSurface = Enum.SurfaceType.Smooth
Cell34.Color = Color3.fromRGB(99, 95, 98)
Cell34.Material = Enum.Material.Wood
Cell34.Size = Vector3.new(15, 1, 15)
Cell34.CFrame = CFrame.new(-105, 0, 75)
Cell34.Parent = ShortHall1

local Boundaries5 = Instance.new("Folder")
Boundaries5.Name = "Boundaries"
Boundaries5.Parent = ShortHall1

local Boundary15 = Instance.new("SpawnLocation")
Boundary15.Name = "Boundary"
Boundary15.Anchored, Enabled = true, false
Boundary15.BottomSurface = Enum.SurfaceType.Smooth
Boundary15.CanCollide = false
Boundary15.Transparency = 0.8
Boundary15.TopSurface = Enum.SurfaceType.Smooth
Boundary15.Color = Color3.fromRGB(180, 128, 255)
Boundary15.Material = Enum.Material.Wood
Boundary15.Size = Vector3.new(13, 12, 1)
Boundary15.CFrame = CFrame.new(-105, 5.5, 68, 0.9999999403953552, 0, 7.450580596923828e-08, 0, 1, 0, -7.450580596923828e-08, 0, 0.9999999403953552)
Boundary15.CanTouch = false
Boundary15.Parent = Boundaries5

local Boundary16 = Instance.new("SpawnLocation")
Boundary16.Name = "Boundary"
Boundary16.Anchored, Enabled = true, false
Boundary16.BottomSurface = Enum.SurfaceType.Smooth
Boundary16.CanCollide = false
Boundary16.Transparency = 0.8
Boundary16.TopSurface = Enum.SurfaceType.Smooth
Boundary16.Color = Color3.fromRGB(180, 128, 255)
Boundary16.Material = Enum.Material.Wood
Boundary16.Size = Vector3.new(13, 12, 1)
Boundary16.CFrame = CFrame.new(-105, 5.5, 112, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Boundary16.CanTouch = false
Boundary16.Parent = Boundaries5

local Boundary17 = Instance.new("SpawnLocation")
Boundary17.Name = "Boundary"
Boundary17.Anchored, Enabled = true, false
Boundary17.BottomSurface = Enum.SurfaceType.Smooth
Boundary17.CanCollide = false
Boundary17.Transparency = 0.8
Boundary17.TopSurface = Enum.SurfaceType.Smooth
Boundary17.Color = Color3.fromRGB(180, 128, 255)
Boundary17.Material = Enum.Material.Wood
Boundary17.Size = Vector3.new(13, 12, 1)
Boundary17.CFrame = CFrame.new(-112, 5.5, 90, -7.450580596923828e-08, 0, 0.9999999403953552, 0, 1, 0, -0.9999999403953552, 0, -7.450580596923828e-08)
Boundary17.CanTouch = false
Boundary17.Parent = Boundaries5

local Boundary18 = Instance.new("SpawnLocation")
Boundary18.Name = "Boundary"
Boundary18.Anchored, Enabled = true, false
Boundary18.BottomSurface = Enum.SurfaceType.Smooth
Boundary18.CanCollide = false
Boundary18.Transparency = 0.8
Boundary18.TopSurface = Enum.SurfaceType.Smooth
Boundary18.Color = Color3.fromRGB(180, 128, 255)
Boundary18.Material = Enum.Material.Wood
Boundary18.Size = Vector3.new(13, 12, 1)
Boundary18.CFrame = CFrame.new(-98, 5.5, 90, 7.450580596923828e-08, 0, -0.9999999403953552, 0, 1, 0, 0.9999999403953552, 0, 7.450580596923828e-08)
Boundary18.CanTouch = false
Boundary18.Parent = Boundaries5

local Part33 = Instance.new("SpawnLocation")
Part33.Anchored, Enabled = true, false
Part33.BottomSurface = Enum.SurfaceType.Smooth
Part33.TopSurface = Enum.SurfaceType.Smooth
Part33.Material = Enum.Material.WoodPlanks
Part33.Size = Vector3.new(16, 11, 1)
Part33.CFrame = CFrame.new(-112, 6, 104.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part33.Parent = ShortHall1

local Part34 = Instance.new("SpawnLocation")
Part34.Anchored, Enabled = true, false
Part34.BottomSurface = Enum.SurfaceType.Smooth
Part34.TopSurface = Enum.SurfaceType.Smooth
Part34.Material = Enum.Material.WoodPlanks
Part34.Size = Vector3.new(16, 11, 1)
Part34.CFrame = CFrame.new(-98, 6, 104.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part34.Parent = ShortHall1

local Cell35 = Instance.new("SpawnLocation")
Cell35.Name = "Cell"
Cell35.Anchored, Enabled = true, false
Cell35.BottomSurface = Enum.SurfaceType.Smooth
Cell35.TopSurface = Enum.SurfaceType.Smooth
Cell35.Color = Color3.fromRGB(99, 95, 98)
Cell35.Material = Enum.Material.Wood
Cell35.Size = Vector3.new(15, 1, 15)
Cell35.CFrame = CFrame.new(-105, 0, 105)
Cell35.Parent = ShortHall1

local Part35 = Instance.new("SpawnLocation")
Part35.Anchored, Enabled = true, false
Part35.BottomSurface = Enum.SurfaceType.Smooth
Part35.TopSurface = Enum.SurfaceType.Smooth
Part35.Material = Enum.Material.WoodPlanks
Part35.Size = Vector3.new(16, 11, 1)
Part35.CFrame = CFrame.new(-112, 6, 75.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part35.Parent = ShortHall1

local Part36 = Instance.new("SpawnLocation")
Part36.Anchored, Enabled = true, false
Part36.BottomSurface = Enum.SurfaceType.Smooth
Part36.TopSurface = Enum.SurfaceType.Smooth
Part36.Material = Enum.Material.WoodPlanks
Part36.Size = Vector3.new(16, 11, 1)
Part36.CFrame = CFrame.new(-98, 6, 75.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part36.Parent = ShortHall1

LargeRoom.PrimaryPart = Floor3

ShortHall1.PrimaryPart = Cell33

BasicTiles.Parent = mapObjs
-- main tiles --
local MainTiles = Instance.new("Folder")
MainTiles.Name = "Main Tiles"

local idk = Instance.new("Model")
idk.Name = "idk"
idk.WorldPivot = CFrame.new(75, 0, -30)
idk.Parent = MainTiles

local Part11 = Instance.new("SpawnLocation")
Part11.Anchored, Enabled = true, false
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Material = Enum.Material.WoodPlanks
Part11.Size = Vector3.new(60, 11, 1)
Part11.CFrame = CFrame.new(68, 6, -52.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part11.Parent = idk

local Part12 = Instance.new("SpawnLocation")
Part12.Anchored, Enabled = true, false
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Material = Enum.Material.WoodPlanks
Part12.Size = Vector3.new(45, 11, 1)
Part12.CFrame = CFrame.new(82, 6, -45, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part12.Parent = idk

local Cell10 = Instance.new("SpawnLocation")
Cell10.Name = "Cell"
Cell10.Anchored, Enabled = true, false
Cell10.BottomSurface = Enum.SurfaceType.Smooth
Cell10.TopSurface = Enum.SurfaceType.Smooth
Cell10.Color = Color3.fromRGB(99, 95, 98)
Cell10.Material = Enum.Material.Wood
Cell10.Size = Vector3.new(15, 1, 15)
Cell10.CFrame = CFrame.new(75, 0, -30)
Cell10.Parent = idk

local Floor2 = Instance.new("SpawnLocation")
Floor2.Name = "Floor"
Floor2.Anchored, Enabled = true, false
Floor2.BottomSurface = Enum.SurfaceType.Smooth
Floor2.TopSurface = Enum.SurfaceType.Smooth
Floor2.Color = Color3.fromRGB(99, 95, 98)
Floor2.Material = Enum.Material.Wood
Floor2.Size = Vector3.new(15, 1, 15)
Floor2.CFrame = CFrame.new(75, 0, -30)
Floor2.Parent = idk

local Cell11 = Instance.new("SpawnLocation")
Cell11.Name = "Cell"
Cell11.Anchored, Enabled = true, false
Cell11.BottomSurface = Enum.SurfaceType.Smooth
Cell11.TopSurface = Enum.SurfaceType.Smooth
Cell11.Color = Color3.fromRGB(99, 95, 98)
Cell11.Material = Enum.Material.Wood
Cell11.Size = Vector3.new(15, 1, 15)
Cell11.CFrame = CFrame.new(75, 0, -45)
Cell11.Parent = idk

local Boundaries1 = Instance.new("Folder")
Boundaries1.Name = "Boundaries"
Boundaries1.Parent = idk

local Boundary3 = Instance.new("SpawnLocation")
Boundary3.Name = "Boundary"
Boundary3.Anchored, Enabled = true, false
Boundary3.BottomSurface = Enum.SurfaceType.Smooth
Boundary3.CanCollide = false
Boundary3.Transparency = 0.8
Boundary3.TopSurface = Enum.SurfaceType.Smooth
Boundary3.Color = Color3.fromRGB(180, 128, 255)
Boundary3.Material = Enum.Material.Wood
Boundary3.Size = Vector3.new(13, 12, 1)
Boundary3.CFrame = CFrame.new(75, 5.5, -23, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Boundary3.CanTouch = false
Boundary3.Parent = Boundaries1

local Boundary4 = Instance.new("SpawnLocation")
Boundary4.Name = "Boundary"
Boundary4.Anchored, Enabled = true, false
Boundary4.BottomSurface = Enum.SurfaceType.Smooth
Boundary4.CanCollide = false
Boundary4.Transparency = 0.8
Boundary4.TopSurface = Enum.SurfaceType.Smooth
Boundary4.Color = Color3.fromRGB(180, 128, 255)
Boundary4.Material = Enum.Material.Wood
Boundary4.Size = Vector3.new(13, 12, 1)
Boundary4.CFrame = CFrame.new(98, 5.5, -165, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Boundary4.CanTouch = false
Boundary4.Parent = Boundaries1

local Boundary5 = Instance.new("SpawnLocation")
Boundary5.Name = "Boundary"
Boundary5.Anchored, Enabled = true, false
Boundary5.BottomSurface = Enum.SurfaceType.Smooth
Boundary5.CanCollide = false
Boundary5.Transparency = 0.8
Boundary5.TopSurface = Enum.SurfaceType.Smooth
Boundary5.Color = Color3.fromRGB(180, 128, 255)
Boundary5.Material = Enum.Material.Wood
Boundary5.Size = Vector3.new(13, 12, 1)
Boundary5.CFrame = CFrame.new(172, 5.5, -120, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Boundary5.CanTouch = false
Boundary5.Parent = Boundaries1

local Boundary6 = Instance.new("SpawnLocation")
Boundary6.Name = "Boundary"
Boundary6.Anchored, Enabled = true, false
Boundary6.BottomSurface = Enum.SurfaceType.Smooth
Boundary6.CanCollide = false
Boundary6.Transparency = 0.8
Boundary6.TopSurface = Enum.SurfaceType.Smooth
Boundary6.Color = Color3.fromRGB(180, 128, 255)
Boundary6.Material = Enum.Material.Wood
Boundary6.Size = Vector3.new(13, 12, 1)
Boundary6.CFrame = CFrame.new(113, 5.5, -120, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Boundary6.CanTouch = false
Boundary6.Parent = Boundaries1

local Cell12 = Instance.new("SpawnLocation")
Cell12.Name = "Cell"
Cell12.Anchored, Enabled = true, false
Cell12.BottomSurface = Enum.SurfaceType.Smooth
Cell12.TopSurface = Enum.SurfaceType.Smooth
Cell12.Color = Color3.fromRGB(99, 95, 98)
Cell12.Material = Enum.Material.Wood
Cell12.Size = Vector3.new(15, 1, 15)
Cell12.CFrame = CFrame.new(75, 0, -60)
Cell12.Parent = idk

local Cell13 = Instance.new("SpawnLocation")
Cell13.Name = "Cell"
Cell13.Anchored, Enabled = true, false
Cell13.BottomSurface = Enum.SurfaceType.Smooth
Cell13.TopSurface = Enum.SurfaceType.Smooth
Cell13.Color = Color3.fromRGB(99, 95, 98)
Cell13.Material = Enum.Material.Wood
Cell13.Size = Vector3.new(15, 1, 15)
Cell13.CFrame = CFrame.new(75, 0, -75)
Cell13.Parent = idk

local Cell14 = Instance.new("SpawnLocation")
Cell14.Name = "Cell"
Cell14.Anchored, Enabled = true, false
Cell14.BottomSurface = Enum.SurfaceType.Smooth
Cell14.TopSurface = Enum.SurfaceType.Smooth
Cell14.Color = Color3.fromRGB(99, 95, 98)
Cell14.Material = Enum.Material.Wood
Cell14.Size = Vector3.new(15, 1, 15)
Cell14.CFrame = CFrame.new(90, 0, -75)
Cell14.Parent = idk

local Cell15 = Instance.new("SpawnLocation")
Cell15.Name = "Cell"
Cell15.Anchored, Enabled = true, false
Cell15.BottomSurface = Enum.SurfaceType.Smooth
Cell15.TopSurface = Enum.SurfaceType.Smooth
Cell15.Color = Color3.fromRGB(99, 95, 98)
Cell15.Material = Enum.Material.Wood
Cell15.Size = Vector3.new(15, 1, 15)
Cell15.CFrame = CFrame.new(120, 0, -75)
Cell15.Parent = idk

local Cell16 = Instance.new("SpawnLocation")
Cell16.Name = "Cell"
Cell16.Anchored, Enabled = true, false
Cell16.BottomSurface = Enum.SurfaceType.Smooth
Cell16.TopSurface = Enum.SurfaceType.Smooth
Cell16.Color = Color3.fromRGB(99, 95, 98)
Cell16.Material = Enum.Material.Wood
Cell16.Size = Vector3.new(15, 1, 15)
Cell16.CFrame = CFrame.new(105, 0, -75)
Cell16.Parent = idk

local Cell17 = Instance.new("SpawnLocation")
Cell17.Name = "Cell"
Cell17.Anchored, Enabled = true, false
Cell17.BottomSurface = Enum.SurfaceType.Smooth
Cell17.TopSurface = Enum.SurfaceType.Smooth
Cell17.Color = Color3.fromRGB(99, 95, 98)
Cell17.Material = Enum.Material.Wood
Cell17.Size = Vector3.new(15, 1, 15)
Cell17.CFrame = CFrame.new(120, 0, -90)
Cell17.Parent = idk

local Cell18 = Instance.new("SpawnLocation")
Cell18.Name = "Cell"
Cell18.Anchored, Enabled = true, false
Cell18.BottomSurface = Enum.SurfaceType.Smooth
Cell18.TopSurface = Enum.SurfaceType.Smooth
Cell18.Color = Color3.fromRGB(99, 95, 98)
Cell18.Material = Enum.Material.Wood
Cell18.Size = Vector3.new(15, 1, 15)
Cell18.CFrame = CFrame.new(120, 0, -105)
Cell18.Parent = idk

local Cell19 = Instance.new("SpawnLocation")
Cell19.Name = "Cell"
Cell19.Anchored, Enabled = true, false
Cell19.BottomSurface = Enum.SurfaceType.Smooth
Cell19.TopSurface = Enum.SurfaceType.Smooth
Cell19.Color = Color3.fromRGB(99, 95, 98)
Cell19.Material = Enum.Material.Wood
Cell19.Size = Vector3.new(15, 1, 15)
Cell19.CFrame = CFrame.new(120, 0, -150)
Cell19.Parent = idk

local Cell20 = Instance.new("SpawnLocation")
Cell20.Name = "Cell"
Cell20.Anchored, Enabled = true, false
Cell20.BottomSurface = Enum.SurfaceType.Smooth
Cell20.TopSurface = Enum.SurfaceType.Smooth
Cell20.Color = Color3.fromRGB(99, 95, 98)
Cell20.Material = Enum.Material.Wood
Cell20.Size = Vector3.new(15, 1, 15)
Cell20.CFrame = CFrame.new(120, 0, -120)
Cell20.Parent = idk

local Cell21 = Instance.new("SpawnLocation")
Cell21.Name = "Cell"
Cell21.Anchored, Enabled = true, false
Cell21.BottomSurface = Enum.SurfaceType.Smooth
Cell21.TopSurface = Enum.SurfaceType.Smooth
Cell21.Color = Color3.fromRGB(99, 95, 98)
Cell21.Material = Enum.Material.Wood
Cell21.Size = Vector3.new(15, 1, 15)
Cell21.CFrame = CFrame.new(120, 0, -135)
Cell21.Parent = idk

local Cell22 = Instance.new("SpawnLocation")
Cell22.Name = "Cell"
Cell22.Anchored, Enabled = true, false
Cell22.BottomSurface = Enum.SurfaceType.Smooth
Cell22.TopSurface = Enum.SurfaceType.Smooth
Cell22.Color = Color3.fromRGB(99, 95, 98)
Cell22.Material = Enum.Material.Wood
Cell22.Size = Vector3.new(15, 1, 15)
Cell22.CFrame = CFrame.new(105, 0, -165)
Cell22.Parent = idk

local Cell23 = Instance.new("SpawnLocation")
Cell23.Name = "Cell"
Cell23.Anchored, Enabled = true, false
Cell23.BottomSurface = Enum.SurfaceType.Smooth
Cell23.TopSurface = Enum.SurfaceType.Smooth
Cell23.Color = Color3.fromRGB(99, 95, 98)
Cell23.Material = Enum.Material.Wood
Cell23.Size = Vector3.new(15, 1, 15)
Cell23.CFrame = CFrame.new(120, 0, -165)
Cell23.Parent = idk

local Cell24 = Instance.new("SpawnLocation")
Cell24.Name = "Cell"
Cell24.Anchored, Enabled = true, false
Cell24.BottomSurface = Enum.SurfaceType.Smooth
Cell24.TopSurface = Enum.SurfaceType.Smooth
Cell24.Color = Color3.fromRGB(99, 95, 98)
Cell24.Material = Enum.Material.Wood
Cell24.Size = Vector3.new(15, 1, 15)
Cell24.CFrame = CFrame.new(135, 0, -90)
Cell24.Parent = idk

local Cell25 = Instance.new("SpawnLocation")
Cell25.Name = "Cell"
Cell25.Anchored, Enabled = true, false
Cell25.BottomSurface = Enum.SurfaceType.Smooth
Cell25.TopSurface = Enum.SurfaceType.Smooth
Cell25.Color = Color3.fromRGB(99, 95, 98)
Cell25.Material = Enum.Material.Wood
Cell25.Size = Vector3.new(15, 1, 15)
Cell25.CFrame = CFrame.new(135, 0, -120)
Cell25.Parent = idk

local Cell26 = Instance.new("SpawnLocation")
Cell26.Name = "Cell"
Cell26.Anchored, Enabled = true, false
Cell26.BottomSurface = Enum.SurfaceType.Smooth
Cell26.TopSurface = Enum.SurfaceType.Smooth
Cell26.Color = Color3.fromRGB(99, 95, 98)
Cell26.Material = Enum.Material.Wood
Cell26.Size = Vector3.new(15, 1, 15)
Cell26.CFrame = CFrame.new(135, 0, -105)
Cell26.Parent = idk

local Cell27 = Instance.new("SpawnLocation")
Cell27.Name = "Cell"
Cell27.Anchored, Enabled = true, false
Cell27.BottomSurface = Enum.SurfaceType.Smooth
Cell27.TopSurface = Enum.SurfaceType.Smooth
Cell27.Color = Color3.fromRGB(99, 95, 98)
Cell27.Material = Enum.Material.Wood
Cell27.Size = Vector3.new(15, 1, 15)
Cell27.CFrame = CFrame.new(135, 0, -150)
Cell27.Parent = idk

local Cell28 = Instance.new("SpawnLocation")
Cell28.Name = "Cell"
Cell28.Anchored, Enabled = true, false
Cell28.BottomSurface = Enum.SurfaceType.Smooth
Cell28.TopSurface = Enum.SurfaceType.Smooth
Cell28.Color = Color3.fromRGB(99, 95, 98)
Cell28.Material = Enum.Material.Wood
Cell28.Size = Vector3.new(15, 1, 15)
Cell28.CFrame = CFrame.new(135, 0, -135)
Cell28.Parent = idk

local Cell29 = Instance.new("SpawnLocation")
Cell29.Name = "Cell"
Cell29.Anchored, Enabled = true, false
Cell29.BottomSurface = Enum.SurfaceType.Smooth
Cell29.TopSurface = Enum.SurfaceType.Smooth
Cell29.Color = Color3.fromRGB(99, 95, 98)
Cell29.Material = Enum.Material.Wood
Cell29.Size = Vector3.new(15, 1, 15)
Cell29.CFrame = CFrame.new(150, 0, -90)
Cell29.Parent = idk

local Cell30 = Instance.new("SpawnLocation")
Cell30.Name = "Cell"
Cell30.Anchored, Enabled = true, false
Cell30.BottomSurface = Enum.SurfaceType.Smooth
Cell30.TopSurface = Enum.SurfaceType.Smooth
Cell30.Color = Color3.fromRGB(99, 95, 98)
Cell30.Material = Enum.Material.Wood
Cell30.Size = Vector3.new(15, 1, 15)
Cell30.CFrame = CFrame.new(150, 0, -120)
Cell30.Parent = idk

local Cell31 = Instance.new("SpawnLocation")
Cell31.Name = "Cell"
Cell31.Anchored, Enabled = true, false
Cell31.BottomSurface = Enum.SurfaceType.Smooth
Cell31.TopSurface = Enum.SurfaceType.Smooth
Cell31.Color = Color3.fromRGB(99, 95, 98)
Cell31.Material = Enum.Material.Wood
Cell31.Size = Vector3.new(15, 1, 15)
Cell31.CFrame = CFrame.new(150, 0, -105)
Cell31.Parent = idk

local Cell32 = Instance.new("SpawnLocation")
Cell32.Name = "Cell"
Cell32.Anchored, Enabled = true, false
Cell32.BottomSurface = Enum.SurfaceType.Smooth
Cell32.TopSurface = Enum.SurfaceType.Smooth
Cell32.Color = Color3.fromRGB(99, 95, 98)
Cell32.Material = Enum.Material.Wood
Cell32.Size = Vector3.new(15, 1, 15)
Cell32.CFrame = CFrame.new(150, 0, -135)
Cell32.Parent = idk

local Cell33 = Instance.new("SpawnLocation")
Cell33.Name = "Cell"
Cell33.Anchored, Enabled = true, false
Cell33.BottomSurface = Enum.SurfaceType.Smooth
Cell33.TopSurface = Enum.SurfaceType.Smooth
Cell33.Color = Color3.fromRGB(99, 95, 98)
Cell33.Material = Enum.Material.Wood
Cell33.Size = Vector3.new(15, 1, 15)
Cell33.CFrame = CFrame.new(150, 0, -150)
Cell33.Parent = idk

local Cell34 = Instance.new("SpawnLocation")
Cell34.Name = "Cell"
Cell34.Anchored, Enabled = true, false
Cell34.BottomSurface = Enum.SurfaceType.Smooth
Cell34.TopSurface = Enum.SurfaceType.Smooth
Cell34.Color = Color3.fromRGB(99, 95, 98)
Cell34.Material = Enum.Material.Wood
Cell34.Size = Vector3.new(15, 1, 15)
Cell34.CFrame = CFrame.new(165, 0, -90)
Cell34.Parent = idk

local Cell35 = Instance.new("SpawnLocation")
Cell35.Name = "Cell"
Cell35.Anchored, Enabled = true, false
Cell35.BottomSurface = Enum.SurfaceType.Smooth
Cell35.TopSurface = Enum.SurfaceType.Smooth
Cell35.Color = Color3.fromRGB(99, 95, 98)
Cell35.Material = Enum.Material.Wood
Cell35.Size = Vector3.new(15, 1, 15)
Cell35.CFrame = CFrame.new(165, 0, -120)
Cell35.Parent = idk

local Cell36 = Instance.new("SpawnLocation")
Cell36.Name = "Cell"
Cell36.Anchored, Enabled = true, false
Cell36.BottomSurface = Enum.SurfaceType.Smooth
Cell36.TopSurface = Enum.SurfaceType.Smooth
Cell36.Color = Color3.fromRGB(99, 95, 98)
Cell36.Material = Enum.Material.Wood
Cell36.Size = Vector3.new(15, 1, 15)
Cell36.CFrame = CFrame.new(165, 0, -105)
Cell36.Parent = idk

local Cell37 = Instance.new("SpawnLocation")
Cell37.Name = "Cell"
Cell37.Anchored, Enabled = true, false
Cell37.BottomSurface = Enum.SurfaceType.Smooth
Cell37.TopSurface = Enum.SurfaceType.Smooth
Cell37.Color = Color3.fromRGB(99, 95, 98)
Cell37.Material = Enum.Material.Wood
Cell37.Size = Vector3.new(15, 1, 15)
Cell37.CFrame = CFrame.new(165, 0, -135)
Cell37.Parent = idk

local Cell38 = Instance.new("SpawnLocation")
Cell38.Name = "Cell"
Cell38.Anchored, Enabled = true, false
Cell38.BottomSurface = Enum.SurfaceType.Smooth
Cell38.TopSurface = Enum.SurfaceType.Smooth
Cell38.Color = Color3.fromRGB(99, 95, 98)
Cell38.Material = Enum.Material.Wood
Cell38.Size = Vector3.new(15, 1, 15)
Cell38.CFrame = CFrame.new(165, 0, -150)
Cell38.Parent = idk

local Part13 = Instance.new("SpawnLocation")
Part13.Anchored, Enabled = true, false
Part13.BottomSurface = Enum.SurfaceType.Smooth
Part13.TopSurface = Enum.SurfaceType.Smooth
Part13.Material = Enum.Material.WoodPlanks
Part13.Size = Vector3.new(31, 11, 1)
Part13.CFrame = CFrame.new(113, 6, -98, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part13.Parent = idk

local Part14 = Instance.new("SpawnLocation")
Part14.Anchored, Enabled = true, false
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.TopSurface = Enum.SurfaceType.Smooth
Part14.Material = Enum.Material.WoodPlanks
Part14.Size = Vector3.new(31, 11, 1)
Part14.CFrame = CFrame.new(113, 6, -142, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part14.Parent = idk

local Part15 = Instance.new("SpawnLocation")
Part15.Anchored, Enabled = true, false
Part15.BottomSurface = Enum.SurfaceType.Smooth
Part15.TopSurface = Enum.SurfaceType.Smooth
Part15.Material = Enum.Material.WoodPlanks
Part15.Size = Vector3.new(31, 11, 1)
Part15.CFrame = CFrame.new(172, 6, -98, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part15.Parent = idk

local Part16 = Instance.new("SpawnLocation")
Part16.Anchored, Enabled = true, false
Part16.BottomSurface = Enum.SurfaceType.Smooth
Part16.TopSurface = Enum.SurfaceType.Smooth
Part16.Material = Enum.Material.WoodPlanks
Part16.Size = Vector3.new(31, 11, 1)
Part16.CFrame = CFrame.new(172, 6, -142, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part16.Parent = idk

local Part17 = Instance.new("SpawnLocation")
Part17.Anchored, Enabled = true, false
Part17.BottomSurface = Enum.SurfaceType.Smooth
Part17.TopSurface = Enum.SurfaceType.Smooth
Part17.Material = Enum.Material.WoodPlanks
Part17.Size = Vector3.new(1, 11, 46)
Part17.CFrame = CFrame.new(104.5, 6, -68, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part17.Parent = idk

local Part18 = Instance.new("SpawnLocation")
Part18.Anchored, Enabled = true, false
Part18.BottomSurface = Enum.SurfaceType.Smooth
Part18.TopSurface = Enum.SurfaceType.Smooth
Part18.Material = Enum.Material.WoodPlanks
Part18.Size = Vector3.new(1, 11, 45)
Part18.CFrame = CFrame.new(91, 6, -82, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part18.Parent = idk

local Part19 = Instance.new("SpawnLocation")
Part19.Anchored, Enabled = true, false
Part19.BottomSurface = Enum.SurfaceType.Smooth
Part19.TopSurface = Enum.SurfaceType.Smooth
Part19.Material = Enum.Material.WoodPlanks
Part19.Size = Vector3.new(14, 11, 1)
Part19.CFrame = CFrame.new(127, 6, -75.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part19.Parent = idk

local Part20 = Instance.new("SpawnLocation")
Part20.Anchored, Enabled = true, false
Part20.BottomSurface = Enum.SurfaceType.Smooth
Part20.TopSurface = Enum.SurfaceType.Smooth
Part20.Material = Enum.Material.WoodPlanks
Part20.Size = Vector3.new(1, 11, 45)
Part20.CFrame = CFrame.new(149, 6, -83, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part20.Parent = idk

local Part21 = Instance.new("SpawnLocation")
Part21.Anchored, Enabled = true, false
Part21.BottomSurface = Enum.SurfaceType.Smooth
Part21.TopSurface = Enum.SurfaceType.Smooth
Part21.Material = Enum.Material.WoodPlanks
Part21.Size = Vector3.new(1, 11, 44)
Part21.CFrame = CFrame.new(149.5, 6, -157, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part21.Parent = idk

local Part22 = Instance.new("SpawnLocation")
Part22.Anchored, Enabled = true, false
Part22.BottomSurface = Enum.SurfaceType.Smooth
Part22.TopSurface = Enum.SurfaceType.Smooth
Part22.Material = Enum.Material.WoodPlanks
Part22.Size = Vector3.new(1, 11, 30)
Part22.CFrame = CFrame.new(112.5, 6, -172, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part22.Parent = idk

local Part23 = Instance.new("SpawnLocation")
Part23.Anchored, Enabled = true, false
Part23.BottomSurface = Enum.SurfaceType.Smooth
Part23.TopSurface = Enum.SurfaceType.Smooth
Part23.Material = Enum.Material.WoodPlanks
Part23.Size = Vector3.new(15, 11, 1)
Part23.CFrame = CFrame.new(127, 6, -164, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part23.Parent = idk

local Part24 = Instance.new("SpawnLocation")
Part24.Anchored, Enabled = true, false
Part24.BottomSurface = Enum.SurfaceType.Smooth
Part24.TopSurface = Enum.SurfaceType.Smooth
Part24.Material = Enum.Material.WoodPlanks
Part24.Size = Vector3.new(1, 11, 16)
Part24.CFrame = CFrame.new(105.5, 6, -158, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Part24.Parent = idk

local Floor3 = Instance.new("SpawnLocation")
Floor3.Name = "Floor"
Floor3.Anchored, Enabled = true, false
Floor3.BottomSurface = Enum.SurfaceType.Smooth
Floor3.TopSurface = Enum.SurfaceType.Smooth
Floor3.Color = Color3.fromRGB(99, 95, 98)
Floor3.Material = Enum.Material.Wood
Floor3.Size = Vector3.new(60, 1, 75)
Floor3.CFrame = CFrame.new(142.5, 0, -120)
Floor3.Parent = idk

local Floor4 = Instance.new("SpawnLocation")
Floor4.Name = "Floor"
Floor4.Anchored, Enabled = true, false
Floor4.BottomSurface = Enum.SurfaceType.Smooth
Floor4.TopSurface = Enum.SurfaceType.Smooth
Floor4.Color = Color3.fromRGB(99, 95, 98)
Floor4.Material = Enum.Material.Wood
Floor4.Size = Vector3.new(30, 1, 15)
Floor4.CFrame = CFrame.new(112.5, 0, -165)
Floor4.Parent = idk

local Floor5 = Instance.new("SpawnLocation")
Floor5.Name = "Floor"
Floor5.Anchored, Enabled = true, false
Floor5.BottomSurface = Enum.SurfaceType.Smooth
Floor5.TopSurface = Enum.SurfaceType.Smooth
Floor5.Color = Color3.fromRGB(99, 95, 98)
Floor5.Material = Enum.Material.Wood
Floor5.Size = Vector3.new(60, 1, 15)
Floor5.CFrame = CFrame.new(97.5, 0, -75)
Floor5.Parent = idk

local Floor6 = Instance.new("SpawnLocation")
Floor6.Name = "Floor"
Floor6.Anchored, Enabled = true, false
Floor6.BottomSurface = Enum.SurfaceType.Smooth
Floor6.TopSurface = Enum.SurfaceType.Smooth
Floor6.Color = Color3.fromRGB(99, 95, 98)
Floor6.Material = Enum.Material.Wood
Floor6.Size = Vector3.new(15, 1, 45)
Floor6.CFrame = CFrame.new(75, 0, -45)
Floor6.Parent = idk

idk.PrimaryPart = Cell10

MainTiles.Parent = mapObjs
-- middle --
local Middle = Instance.new("Model")
Middle.Name = "Middle"
Middle.WorldPivot = CFrame.new(16, 0, 15)

local Cell = Instance.new("SpawnLocation")
Cell.Name = "Cell"
Cell.Anchored, Enabled = true, false
Cell.BottomSurface = Enum.SurfaceType.Smooth
Cell.TopSurface = Enum.SurfaceType.Smooth
Cell.Color = Color3.fromRGB(99, 95, 98)
Cell.Material = Enum.Material.Wood
Cell.Size = Vector3.new(15, 1, 15)
Cell.CFrame = CFrame.new(-14, 0, 30)
Cell.Parent = Middle

local Floor = Instance.new("SpawnLocation")
Floor.Name = "Floor"
Floor.Anchored, Enabled = true, false
Floor.BottomSurface = Enum.SurfaceType.Smooth
Floor.TopSurface = Enum.SurfaceType.Smooth
Floor.Color = Color3.fromRGB(75, 72, 74)
Floor.Material = Enum.Material.Wood
Floor.Size = Vector3.new(60, 1, 15)
Floor.CFrame = CFrame.new(23.5, 0, -15)
Floor.Parent = Middle

local SpawnLocation = Instance.new("SpawnLocation")
SpawnLocation.Anchored, Enabled = true, false
SpawnLocation.BottomSurface = Enum.SurfaceType.Smooth
SpawnLocation.CanCollide = false
SpawnLocation.Transparency = 1
SpawnLocation.TopSurface = Enum.SurfaceType.Smooth
SpawnLocation.Size = Vector3.new(5, 0.0010000000474974513, 5)
SpawnLocation.CFrame = CFrame.new(24.000015258789062, 1.000499963760376, 49)
SpawnLocation.CanTouch = false
SpawnLocation.Parent = Middle

local Cell1 = Instance.new("SpawnLocation")
Cell1.Name = "Cell"
Cell1.Anchored, Enabled = true, false
Cell1.BottomSurface = Enum.SurfaceType.Smooth
Cell1.TopSurface = Enum.SurfaceType.Smooth
Cell1.Color = Color3.fromRGB(99, 95, 98)
Cell1.Material = Enum.Material.Wood
Cell1.Size = Vector3.new(15, 1, 15)
Cell1.CFrame = CFrame.new(1, 0, 15)
Cell1.Parent = Middle

local Cell2 = Instance.new("SpawnLocation")
Cell2.Name = "Cell"
Cell2.Anchored, Enabled = true, false
Cell2.BottomSurface = Enum.SurfaceType.Smooth
Cell2.TopSurface = Enum.SurfaceType.Smooth
Cell2.Color = Color3.fromRGB(99, 95, 98)
Cell2.Material = Enum.Material.Wood
Cell2.Size = Vector3.new(15, 1, 15)
Cell2.CFrame = CFrame.new(16, 0, 30)
Cell2.Parent = Middle

local Cell3 = Instance.new("SpawnLocation")
Cell3.Name = "Cell"
Cell3.Anchored, Enabled = true, false
Cell3.BottomSurface = Enum.SurfaceType.Smooth
Cell3.TopSurface = Enum.SurfaceType.Smooth
Cell3.Color = Color3.fromRGB(99, 95, 98)
Cell3.Material = Enum.Material.Wood
Cell3.Size = Vector3.new(15, 1, 15)
Cell3.CFrame = CFrame.new(16, 0, 15)
Cell3.Parent = Middle

local Cell4 = Instance.new("SpawnLocation")
Cell4.Name = "Cell"
Cell4.Anchored, Enabled = true, false
Cell4.BottomSurface = Enum.SurfaceType.Smooth
Cell4.TopSurface = Enum.SurfaceType.Smooth
Cell4.Color = Color3.fromRGB(99, 95, 98)
Cell4.Material = Enum.Material.Wood
Cell4.Size = Vector3.new(15, 1, 15)
Cell4.CFrame = CFrame.new(-14, 0, 15)
Cell4.Parent = Middle

local Cell5 = Instance.new("SpawnLocation")
Cell5.Name = "Cell"
Cell5.Anchored, Enabled = true, false
Cell5.BottomSurface = Enum.SurfaceType.Smooth
Cell5.TopSurface = Enum.SurfaceType.Smooth
Cell5.Color = Color3.fromRGB(99, 95, 98)
Cell5.Material = Enum.Material.Wood
Cell5.Size = Vector3.new(15, 1, 15)
Cell5.CFrame = CFrame.new(16, 0, -15)
Cell5.Parent = Middle

local Cell6 = Instance.new("SpawnLocation")
Cell6.Name = "Cell"
Cell6.Anchored, Enabled = true, false
Cell6.BottomSurface = Enum.SurfaceType.Smooth
Cell6.TopSurface = Enum.SurfaceType.Smooth
Cell6.Color = Color3.fromRGB(99, 95, 98)
Cell6.Material = Enum.Material.Wood
Cell6.Size = Vector3.new(15, 1, 15)
Cell6.CFrame = CFrame.new(16, 0, 45)
Cell6.Parent = Middle

local Boundaries = Instance.new("Folder")
Boundaries.Name = "Boundaries"
Boundaries.Parent = Middle

local Boundary = Instance.new("SpawnLocation")
Boundary.Name = "Boundary"
Boundary.Anchored, Enabled = true, false
Boundary.BottomSurface = Enum.SurfaceType.Smooth
Boundary.CanCollide = false
Boundary.Transparency = 0.8
Boundary.TopSurface = Enum.SurfaceType.Smooth
Boundary.Color = Color3.fromRGB(180, 128, 255)
Boundary.Material = Enum.Material.Wood
Boundary.Size = Vector3.new(13, 12, 1)
Boundary.CFrame = CFrame.new(-6, 5.5, -15, 0, 0, 1, 0, 1, -0, -1, 0, 0)
Boundary.CanTouch = false
Boundary.Parent = Boundaries

local Boundary1 = Instance.new("SpawnLocation")
Boundary1.Name = "Boundary"
Boundary1.Anchored, Enabled = true, false
Boundary1.BottomSurface = Enum.SurfaceType.Smooth
Boundary1.CanCollide = false
Boundary1.Transparency = 0.8
Boundary1.TopSurface = Enum.SurfaceType.Smooth
Boundary1.Color = Color3.fromRGB(180, 128, 255)
Boundary1.Material = Enum.Material.Wood
Boundary1.Size = Vector3.new(13, 12, 1)
Boundary1.CFrame = CFrame.new(53, 5.5, -15, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Boundary1.CanTouch = false
Boundary1.Parent = Boundaries

local Cell7 = Instance.new("SpawnLocation")
Cell7.Name = "Cell"
Cell7.Anchored, Enabled = true, false
Cell7.BottomSurface = Enum.SurfaceType.Smooth
Cell7.TopSurface = Enum.SurfaceType.Smooth
Cell7.Color = Color3.fromRGB(99, 95, 98)
Cell7.Material = Enum.Material.Wood
Cell7.Size = Vector3.new(15, 1, 15)
Cell7.CFrame = CFrame.new(1, 0, 30)
Cell7.Parent = Middle

local Cell8 = Instance.new("SpawnLocation")
Cell8.Name = "Cell"
Cell8.Anchored, Enabled = true, false
Cell8.BottomSurface = Enum.SurfaceType.Smooth
Cell8.TopSurface = Enum.SurfaceType.Smooth
Cell8.Color = Color3.fromRGB(99, 95, 98)
Cell8.Material = Enum.Material.Wood
Cell8.Size = Vector3.new(15, 1, 15)
Cell8.CFrame = CFrame.new(1, 0, 0)
Cell8.Parent = Middle

local Cell9 = Instance.new("SpawnLocation")
Cell9.Name = "Cell"
Cell9.Anchored, Enabled = true, false
Cell9.BottomSurface = Enum.SurfaceType.Smooth
Cell9.TopSurface = Enum.SurfaceType.Smooth
Cell9.Color = Color3.fromRGB(99, 95, 98)
Cell9.Material = Enum.Material.Wood
Cell9.Size = Vector3.new(15, 1, 15)
Cell9.CFrame = CFrame.new(61, 0, 0)
Cell9.Parent = Middle

local Cell10 = Instance.new("SpawnLocation")
Cell10.Name = "Cell"
Cell10.Anchored, Enabled = true, false
Cell10.BottomSurface = Enum.SurfaceType.Smooth
Cell10.TopSurface = Enum.SurfaceType.Smooth
Cell10.Color = Color3.fromRGB(99, 95, 98)
Cell10.Material = Enum.Material.Wood
Cell10.Size = Vector3.new(15, 1, 15)
Cell10.CFrame = CFrame.new(1, 0, 45)
Cell10.Parent = Middle

local Cell11 = Instance.new("SpawnLocation")
Cell11.Name = "Cell"
Cell11.Anchored, Enabled = true, false
Cell11.BottomSurface = Enum.SurfaceType.Smooth
Cell11.TopSurface = Enum.SurfaceType.Smooth
Cell11.Color = Color3.fromRGB(99, 95, 98)
Cell11.Material = Enum.Material.Wood
Cell11.Size = Vector3.new(15, 1, 15)
Cell11.CFrame = CFrame.new(31, 0, 15)
Cell11.Parent = Middle

local Cell12 = Instance.new("SpawnLocation")
Cell12.Name = "Cell"
Cell12.Anchored, Enabled = true, false
Cell12.BottomSurface = Enum.SurfaceType.Smooth
Cell12.TopSurface = Enum.SurfaceType.Smooth
Cell12.Color = Color3.fromRGB(99, 95, 98)
Cell12.Material = Enum.Material.Wood
Cell12.Size = Vector3.new(15, 1, 15)
Cell12.CFrame = CFrame.new(46, 0, -15)
Cell12.Parent = Middle

local Cell13 = Instance.new("SpawnLocation")
Cell13.Name = "Cell"
Cell13.Anchored, Enabled = true, false
Cell13.BottomSurface = Enum.SurfaceType.Smooth
Cell13.TopSurface = Enum.SurfaceType.Smooth
Cell13.Color = Color3.fromRGB(99, 95, 98)
Cell13.Material = Enum.Material.Wood
Cell13.Size = Vector3.new(15, 1, 15)
Cell13.CFrame = CFrame.new(46, 0, 0)
Cell13.Parent = Middle

local Cell14 = Instance.new("SpawnLocation")
Cell14.Name = "Cell"
Cell14.Anchored, Enabled = true, false
Cell14.BottomSurface = Enum.SurfaceType.Smooth
Cell14.TopSurface = Enum.SurfaceType.Smooth
Cell14.Color = Color3.fromRGB(99, 95, 98)
Cell14.Material = Enum.Material.Wood
Cell14.Size = Vector3.new(15, 1, 15)
Cell14.CFrame = CFrame.new(31, 0, 0)
Cell14.Parent = Middle

local Cell15 = Instance.new("SpawnLocation")
Cell15.Name = "Cell"
Cell15.Anchored, Enabled = true, false
Cell15.BottomSurface = Enum.SurfaceType.Smooth
Cell15.TopSurface = Enum.SurfaceType.Smooth
Cell15.Color = Color3.fromRGB(99, 95, 98)
Cell15.Material = Enum.Material.Wood
Cell15.Size = Vector3.new(15, 1, 15)
Cell15.CFrame = CFrame.new(31, 0, -15)
Cell15.Parent = Middle

local Cell16 = Instance.new("SpawnLocation")
Cell16.Name = "Cell"
Cell16.Anchored, Enabled = true, false
Cell16.BottomSurface = Enum.SurfaceType.Smooth
Cell16.TopSurface = Enum.SurfaceType.Smooth
Cell16.Color = Color3.fromRGB(99, 95, 98)
Cell16.Material = Enum.Material.Wood
Cell16.Size = Vector3.new(15, 1, 15)
Cell16.CFrame = CFrame.new(1, 0, -15)
Cell16.Parent = Middle

local Cell17 = Instance.new("SpawnLocation")
Cell17.Name = "Cell"
Cell17.Anchored, Enabled = true, false
Cell17.BottomSurface = Enum.SurfaceType.Smooth
Cell17.TopSurface = Enum.SurfaceType.Smooth
Cell17.Color = Color3.fromRGB(99, 95, 98)
Cell17.Material = Enum.Material.Wood
Cell17.Size = Vector3.new(15, 1, 15)
Cell17.CFrame = CFrame.new(61, 0, 30)
Cell17.Parent = Middle

local Cell18 = Instance.new("SpawnLocation")
Cell18.Name = "Cell"
Cell18.Anchored, Enabled = true, false
Cell18.BottomSurface = Enum.SurfaceType.Smooth
Cell18.TopSurface = Enum.SurfaceType.Smooth
Cell18.Color = Color3.fromRGB(99, 95, 98)
Cell18.Material = Enum.Material.Wood
Cell18.Size = Vector3.new(15, 1, 15)
Cell18.CFrame = CFrame.new(16, 0, 0)
Cell18.Parent = Middle

local Cell19 = Instance.new("SpawnLocation")
Cell19.Name = "Cell"
Cell19.Anchored, Enabled = true, false
Cell19.BottomSurface = Enum.SurfaceType.Smooth
Cell19.TopSurface = Enum.SurfaceType.Smooth
Cell19.Color = Color3.fromRGB(99, 95, 98)
Cell19.Material = Enum.Material.Wood
Cell19.Size = Vector3.new(15, 1, 15)
Cell19.CFrame = CFrame.new(61, 0, 15)
Cell19.Parent = Middle

local Cell20 = Instance.new("SpawnLocation")
Cell20.Name = "Cell"
Cell20.Anchored, Enabled = true, false
Cell20.BottomSurface = Enum.SurfaceType.Smooth
Cell20.TopSurface = Enum.SurfaceType.Smooth
Cell20.Color = Color3.fromRGB(99, 95, 98)
Cell20.Material = Enum.Material.Wood
Cell20.Size = Vector3.new(15, 1, 15)
Cell20.CFrame = CFrame.new(46, 0, 15)
Cell20.Parent = Middle

local Cell21 = Instance.new("SpawnLocation")
Cell21.Name = "Cell"
Cell21.Anchored, Enabled = true, false
Cell21.BottomSurface = Enum.SurfaceType.Smooth
Cell21.TopSurface = Enum.SurfaceType.Smooth
Cell21.Color = Color3.fromRGB(99, 95, 98)
Cell21.Material = Enum.Material.Wood
Cell21.Size = Vector3.new(15, 1, 15)
Cell21.CFrame = CFrame.new(46, 0, 30)
Cell21.Parent = Middle

local Cell22 = Instance.new("SpawnLocation")
Cell22.Name = "Cell"
Cell22.Anchored, Enabled = true, false
Cell22.BottomSurface = Enum.SurfaceType.Smooth
Cell22.TopSurface = Enum.SurfaceType.Smooth
Cell22.Color = Color3.fromRGB(99, 95, 98)
Cell22.Material = Enum.Material.Wood
Cell22.Size = Vector3.new(15, 1, 15)
Cell22.CFrame = CFrame.new(46, 0, 45)
Cell22.Parent = Middle

local Cell23 = Instance.new("SpawnLocation")
Cell23.Name = "Cell"
Cell23.Anchored, Enabled = true, false
Cell23.BottomSurface = Enum.SurfaceType.Smooth
Cell23.TopSurface = Enum.SurfaceType.Smooth
Cell23.Color = Color3.fromRGB(99, 95, 98)
Cell23.Material = Enum.Material.Wood
Cell23.Size = Vector3.new(15, 1, 15)
Cell23.CFrame = CFrame.new(31, 0, 45)
Cell23.Parent = Middle

local Cell24 = Instance.new("SpawnLocation")
Cell24.Name = "Cell"
Cell24.Anchored, Enabled = true, false
Cell24.BottomSurface = Enum.SurfaceType.Smooth
Cell24.TopSurface = Enum.SurfaceType.Smooth
Cell24.Color = Color3.fromRGB(99, 95, 98)
Cell24.Material = Enum.Material.Wood
Cell24.Size = Vector3.new(15, 1, 15)
Cell24.CFrame = CFrame.new(31, 0, 30)
Cell24.Parent = Middle

local Cell25 = Instance.new("SpawnLocation")
Cell25.Name = "Cell"
Cell25.Anchored, Enabled = true, false
Cell25.BottomSurface = Enum.SurfaceType.Smooth
Cell25.TopSurface = Enum.SurfaceType.Smooth
Cell25.Color = Color3.fromRGB(99, 95, 98)
Cell25.Material = Enum.Material.Wood
Cell25.Size = Vector3.new(15, 1, 15)
Cell25.CFrame = CFrame.new(-14, 0, 15)
Cell25.Parent = Middle

local Cell26 = Instance.new("SpawnLocation")
Cell26.Name = "Cell"
Cell26.Anchored, Enabled = true, false
Cell26.BottomSurface = Enum.SurfaceType.Smooth
Cell26.TopSurface = Enum.SurfaceType.Smooth
Cell26.Color = Color3.fromRGB(99, 95, 98)
Cell26.Material = Enum.Material.Wood
Cell26.Size = Vector3.new(15, 1, 15)
Cell26.CFrame = CFrame.new(1, 0, 15)
Cell26.Parent = Middle

local Part = Instance.new("SpawnLocation")
Part.Anchored, Enabled = true, false
Part.BottomSurface = Enum.SurfaceType.Smooth
Part.Transparency = 1
Part.TopSurface = Enum.SurfaceType.Smooth
Part.Color = Color3.fromRGB(17, 17, 17)
Part.Material = Enum.Material.Granite
Part.Size = Vector3.new(10, 16, 1)
Part.CFrame = CFrame.new(23.5, 8.5, 52)
Part.Parent = Middle

local Part1 = Instance.new("SpawnLocation")
Part1.Anchored, Enabled = true, false
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Color = Color3.fromRGB(99, 95, 98)
Part1.Material = Enum.Material.WoodPlanks
Part1.Size = Vector3.new(60, 1, 13)
Part1.CFrame = CFrame.new(23.500001907348633, 16, -15)
Part1.Parent = Middle

local Part2 = Instance.new("SpawnLocation")
Part2.Anchored, Enabled = true, false
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Color = Color3.fromRGB(99, 95, 98)
Part2.Material = Enum.Material.WoodPlanks
Part2.Size = Vector3.new(88, 1, 46)
Part2.CFrame = CFrame.new(23.5, 16, 14.5)
Part2.Parent = Middle

local Cell27 = Instance.new("SpawnLocation")
Cell27.Name = "Cell"
Cell27.Anchored, Enabled = true, false
Cell27.BottomSurface = Enum.SurfaceType.Smooth
Cell27.TopSurface = Enum.SurfaceType.Smooth
Cell27.Color = Color3.fromRGB(99, 95, 98)
Cell27.Material = Enum.Material.Wood
Cell27.Size = Vector3.new(15, 1, 15)
Cell27.CFrame = CFrame.new(-14, 0, 0)
Cell27.Parent = Middle

local Part3 = Instance.new("SpawnLocation")
Part3.Anchored, Enabled = true, false
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Color = Color3.fromRGB(99, 95, 98)
Part3.Material = Enum.Material.WoodPlanks
Part3.Size = Vector3.new(10, 1, 14)
Part3.CFrame = CFrame.new(23.5, 16, 59.5)
Part3.Parent = Middle

local Part4 = Instance.new("SpawnLocation")
Part4.Anchored, Enabled = true, false
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Color = Color3.fromRGB(99, 95, 98)
Part4.Material = Enum.Material.WoodPlanks
Part4.Size = Vector3.new(58, 1, 15)
Part4.CFrame = CFrame.new(23.5, 16, 45)
Part4.Parent = Middle

local Floor1 = Instance.new("SpawnLocation")
Floor1.Name = "Floor"
Floor1.Anchored, Enabled = true, false
Floor1.BottomSurface = Enum.SurfaceType.Smooth
Floor1.TopSurface = Enum.SurfaceType.Smooth
Floor1.Color = Color3.fromRGB(75, 72, 74)
Floor1.Material = Enum.Material.Wood
Floor1.Size = Vector3.new(60, 1, 15)
Floor1.CFrame = CFrame.new(23.5, 0, 45)
Floor1.Parent = Middle

local Floor2 = Instance.new("SpawnLocation")
Floor2.Name = "Floor"
Floor2.Anchored, Enabled = true, false
Floor2.BottomSurface = Enum.SurfaceType.Smooth
Floor2.TopSurface = Enum.SurfaceType.Smooth
Floor2.Color = Color3.fromRGB(75, 72, 74)
Floor2.Material = Enum.Material.Wood
Floor2.Size = Vector3.new(90, 1, 45)
Floor2.CFrame = CFrame.new(23.5, 0, 15)
Floor2.Parent = Middle

local Cell28 = Instance.new("SpawnLocation")
Cell28.Name = "Cell"
Cell28.Anchored, Enabled = true, false
Cell28.BottomSurface = Enum.SurfaceType.Smooth
Cell28.TopSurface = Enum.SurfaceType.Smooth
Cell28.Color = Color3.fromRGB(99, 95, 98)
Cell28.Material = Enum.Material.Wood
Cell28.Size = Vector3.new(15, 1, 15)
Cell28.CFrame = CFrame.new(31, 0, 60)
Cell28.Parent = Middle

local Cell29 = Instance.new("SpawnLocation")
Cell29.Name = "Cell"
Cell29.Anchored, Enabled = true, false
Cell29.BottomSurface = Enum.SurfaceType.Smooth
Cell29.TopSurface = Enum.SurfaceType.Smooth
Cell29.Color = Color3.fromRGB(99, 95, 98)
Cell29.Material = Enum.Material.Wood
Cell29.Size = Vector3.new(15, 1, 15)
Cell29.CFrame = CFrame.new(16, 0, 60)
Cell29.Parent = Middle

local Floor3 = Instance.new("SpawnLocation")
Floor3.Name = "Floor"
Floor3.Anchored, Enabled = true, false
Floor3.BottomSurface = Enum.SurfaceType.Smooth
Floor3.TopSurface = Enum.SurfaceType.Smooth
Floor3.Color = Color3.fromRGB(56, 54, 55)
Floor3.Material = Enum.Material.Marble
Floor3.Size = Vector3.new(12, 1, 16)
Floor3.CFrame = CFrame.new(23.5, 0, 59.5)
Floor3.Parent = Middle

local Part5 = Instance.new("SpawnLocation")
Part5.Anchored, Enabled = true, false
Part5.BottomSurface = Enum.SurfaceType.Smooth
Part5.TopSurface = Enum.SurfaceType.Smooth
Part5.Color = Color3.fromRGB(82, 124, 174)
Part5.Material = Enum.Material.WoodPlanks
Part5.Size = Vector3.new(25, 16, 1)
Part5.CFrame = CFrame.new(41, 8.5, 52)
Part5.Parent = Middle

local Part6 = Instance.new("SpawnLocation")
Part6.Anchored, Enabled = true, false
Part6.BottomSurface = Enum.SurfaceType.Smooth
Part6.TopSurface = Enum.SurfaceType.Smooth
Part6.Color = Color3.fromRGB(82, 124, 174)
Part6.Material = Enum.Material.WoodPlanks
Part6.Size = Vector3.new(1, 16, 14)
Part6.CFrame = CFrame.new(-6, 8.5, 44.5)
Part6.Parent = Middle

local Part7 = Instance.new("SpawnLocation")
Part7.Anchored, Enabled = true, false
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Color = Color3.fromRGB(82, 124, 174)
Part7.Material = Enum.Material.WoodPlanks
Part7.Size = Vector3.new(1, 16, 14)
Part7.CFrame = CFrame.new(53, 8.5, 44.5)
Part7.Parent = Middle

local Part8 = Instance.new("SpawnLocation")
Part8.Anchored, Enabled = true, false
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Color = Color3.fromRGB(82, 124, 174)
Part8.Material = Enum.Material.WoodPlanks
Part8.Size = Vector3.new(60, 16, 1)
Part8.CFrame = CFrame.new(23.5, 8.5, -22)
Part8.Parent = Middle

local Part9 = Instance.new("SpawnLocation")
Part9.Anchored, Enabled = true, false
Part9.BottomSurface = Enum.SurfaceType.Smooth
Part9.TopSurface = Enum.SurfaceType.Smooth
Part9.Color = Color3.fromRGB(82, 124, 174)
Part9.Material = Enum.Material.WoodPlanks
Part9.Size = Vector3.new(34, 16, 1)
Part9.CFrame = CFrame.new(-3.5, 8.5, -7)
Part9.Parent = Middle

local Part10 = Instance.new("SpawnLocation")
Part10.Anchored, Enabled = true, false
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Color = Color3.fromRGB(82, 124, 174)
Part10.Material = Enum.Material.WoodPlanks
Part10.Size = Vector3.new(39, 16, 1)
Part10.CFrame = CFrame.new(48, 8.5, -7)
Part10.Parent = Middle

local Part11 = Instance.new("SpawnLocation")
Part11.Anchored, Enabled = true, false
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Color = Color3.fromRGB(82, 124, 174)
Part11.Material = Enum.Material.WoodPlanks
Part11.Size = Vector3.new(16, 16, 1)
Part11.CFrame = CFrame.new(60.5, 8.5, 37)
Part11.Parent = Middle

local Part12 = Instance.new("SpawnLocation")
Part12.Anchored, Enabled = true, false
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Color = Color3.fromRGB(82, 124, 174)
Part12.Material = Enum.Material.WoodPlanks
Part12.Size = Vector3.new(16, 16, 1)
Part12.CFrame = CFrame.new(-13.5, 8.5, 37)
Part12.Parent = Middle

local Part13 = Instance.new("SpawnLocation")
Part13.Anchored, Enabled = true, false
Part13.BottomSurface = Enum.SurfaceType.Smooth
Part13.TopSurface = Enum.SurfaceType.Smooth
Part13.Color = Color3.fromRGB(82, 124, 174)
Part13.Material = Enum.Material.WoodPlanks
Part13.Size = Vector3.new(1, 16, 44)
Part13.CFrame = CFrame.new(68, 8.5, 14.5)
Part13.Parent = Middle

local Part14 = Instance.new("SpawnLocation")
Part14.Anchored, Enabled = true, false
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.TopSurface = Enum.SurfaceType.Smooth
Part14.Color = Color3.fromRGB(82, 124, 174)
Part14.Material = Enum.Material.WoodPlanks
Part14.Size = Vector3.new(1, 16, 44)
Part14.CFrame = CFrame.new(-21, 8.5, 14.5)
Part14.Parent = Middle

local Part15 = Instance.new("SpawnLocation")
Part15.Anchored, Enabled = true, false
Part15.BottomSurface = Enum.SurfaceType.Smooth
Part15.TopSurface = Enum.SurfaceType.Smooth
Part15.Color = Color3.fromRGB(82, 124, 174)
Part15.Material = Enum.Material.WoodPlanks
Part15.Size = Vector3.new(25, 16, 1)
Part15.CFrame = CFrame.new(6, 8.5, 52)
Part15.Parent = Middle

local Part16 = Instance.new("SpawnLocation")
Part16.Anchored, Enabled = true, false
Part16.BottomSurface = Enum.SurfaceType.Smooth
Part16.TopSurface = Enum.SurfaceType.Smooth
Part16.Color = Color3.fromRGB(17, 17, 17)
Part16.Material = Enum.Material.Granite
Part16.Size = Vector3.new(10, 15, 1)
Part16.CFrame = CFrame.new(23.5, 8, 65)
Part16.Parent = Middle

local ParticleEmitter = Instance.new("ParticleEmitter")
ParticleEmitter.LightInfluence = 1
ParticleEmitter.Lifetime = NumberRange.new(4.75, 4.75)
ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.15), NumberSequenceKeypoint.new(1, 1)})
ParticleEmitter.Speed = NumberRange.new(3, 3)
ParticleEmitter.Size = NumberSequence.new(4, 7.3749995)
ParticleEmitter.RotSpeed = NumberRange.new(-5, 5)
ParticleEmitter.Rate = 10
ParticleEmitter.EmissionDirection = Enum.NormalId.Front
ParticleEmitter.Texture = "rbxassetid://129418678"
ParticleEmitter.Rotation = NumberRange.new(55, 55)
ParticleEmitter.Parent = Part16

local Part17 = Instance.new("SpawnLocation")
Part17.Anchored, Enabled = true, false
Part17.BottomSurface = Enum.SurfaceType.Smooth
Part17.TopSurface = Enum.SurfaceType.Smooth
Part17.Color = Color3.fromRGB(46, 70, 98)
Part17.Material = Enum.Material.WoodPlanks
Part17.Size = Vector3.new(10, 16, 14)
Part17.CFrame = CFrame.new(33.5, 8.5, 59.5)
Part17.Parent = Middle

local Part18 = Instance.new("SpawnLocation")
Part18.Anchored, Enabled = true, false
Part18.BottomSurface = Enum.SurfaceType.Smooth
Part18.TopSurface = Enum.SurfaceType.Smooth
Part18.Color = Color3.fromRGB(68, 104, 145)
Part18.Material = Enum.Material.WoodPlanks
Part18.Size = Vector3.new(30, 16, 1)
Part18.CFrame = CFrame.new(23.5, 8.5, 67)
Part18.Parent = Middle

local Part19 = Instance.new("SpawnLocation")
Part19.Anchored, Enabled = true, false
Part19.BottomSurface = Enum.SurfaceType.Smooth
Part19.Transparency = 0.1
Part19.TopSurface = Enum.SurfaceType.Smooth
Part19.Color = Color3.fromRGB(17, 17, 17)
Part19.Material = Enum.Material.Granite
Part19.Size = Vector3.new(10, 16, 1)
Part19.CFrame = CFrame.new(23.5, 8.5, 64)
Part19.Parent = Middle

local Part20 = Instance.new("SpawnLocation")
Part20.Anchored, Enabled = true, false
Part20.BottomSurface = Enum.SurfaceType.Smooth
Part20.Transparency = 0.2
Part20.TopSurface = Enum.SurfaceType.Smooth
Part20.Color = Color3.fromRGB(17, 17, 17)
Part20.Material = Enum.Material.Granite
Part20.Size = Vector3.new(10, 16, 1)
Part20.CFrame = CFrame.new(23.5, 8.5, 62)
Part20.Parent = Middle

local Part21 = Instance.new("SpawnLocation")
Part21.Anchored, Enabled = true, false
Part21.BottomSurface = Enum.SurfaceType.Smooth
Part21.Transparency = 0.4
Part21.TopSurface = Enum.SurfaceType.Smooth
Part21.Color = Color3.fromRGB(17, 17, 17)
Part21.Material = Enum.Material.Granite
Part21.Size = Vector3.new(10, 16, 1)
Part21.CFrame = CFrame.new(23.5, 8.5, 61)
Part21.Parent = Middle

local Part22 = Instance.new("SpawnLocation")
Part22.Anchored, Enabled = true, false
Part22.BottomSurface = Enum.SurfaceType.Smooth
Part22.Transparency = 0.65
Part22.TopSurface = Enum.SurfaceType.Smooth
Part22.Color = Color3.fromRGB(17, 17, 17)
Part22.Material = Enum.Material.Granite
Part22.Size = Vector3.new(10, 16, 1)
Part22.CFrame = CFrame.new(23.5, 8.5, 60)
Part22.Parent = Middle

local Part23 = Instance.new("SpawnLocation")
Part23.Anchored, Enabled = true, false
Part23.BottomSurface = Enum.SurfaceType.Smooth
Part23.Transparency = 0.85
Part23.TopSurface = Enum.SurfaceType.Smooth
Part23.Color = Color3.fromRGB(17, 17, 17)
Part23.Material = Enum.Material.Granite
Part23.Size = Vector3.new(10, 16, 1)
Part23.CFrame = CFrame.new(23.5, 8.5, 59)
Part23.Parent = Middle

local Part24 = Instance.new("SpawnLocation")
Part24.Anchored, Enabled = true, false
Part24.BottomSurface = Enum.SurfaceType.Smooth
Part24.TopSurface = Enum.SurfaceType.Smooth
Part24.Color = Color3.fromRGB(82, 124, 174)
Part24.Material = Enum.Material.WoodPlanks
Part24.Size = Vector3.new(1, 4, 13)
Part24.CFrame = CFrame.new(53, 13.5, -15)
Part24.Parent = Middle

local Part25 = Instance.new("SpawnLocation")
Part25.Anchored, Enabled = true, false
Part25.BottomSurface = Enum.SurfaceType.Smooth
Part25.TopSurface = Enum.SurfaceType.Smooth
Part25.Color = Color3.fromRGB(82, 124, 174)
Part25.Material = Enum.Material.WoodPlanks
Part25.Size = Vector3.new(25, 16, 1)
Part25.CFrame = CFrame.new(41, 8.5, -8)
Part25.Parent = Middle

local Part26 = Instance.new("SpawnLocation")
Part26.Anchored, Enabled = true, false
Part26.BottomSurface = Enum.SurfaceType.Smooth
Part26.TopSurface = Enum.SurfaceType.Smooth
Part26.Color = Color3.fromRGB(82, 124, 174)
Part26.Material = Enum.Material.WoodPlanks
Part26.Size = Vector3.new(20, 16, 1)
Part26.CFrame = CFrame.new(3.5, 8.5, -8)
Part26.Parent = Middle

local Part27 = Instance.new("SpawnLocation")
Part27.Anchored, Enabled = true, false
Part27.BottomSurface = Enum.SurfaceType.Smooth
Part27.TopSurface = Enum.SurfaceType.Smooth
Part27.Color = Color3.fromRGB(82, 124, 174)
Part27.Material = Enum.Material.WoodPlanks
Part27.Size = Vector3.new(1, 4, 13)
Part27.CFrame = CFrame.new(-6, 13.5, -15)
Part27.Parent = Middle

local Part28 = Instance.new("SpawnLocation")
Part28.Anchored, Enabled = true, false
Part28.BottomSurface = Enum.SurfaceType.Smooth
Part28.TopSurface = Enum.SurfaceType.Smooth
Part28.Color = Color3.fromRGB(68, 104, 145)
Part28.Material = Enum.Material.WoodPlanks
Part28.Size = Vector3.new(10, 16, 14)
Part28.CFrame = CFrame.new(13.5, 8.5, 59.5)
Part28.Parent = Middle

Middle.PrimaryPart = Cell3
Middle.Parent = mapObjs
-- rest of script <3 --
local basic = mapObjs:WaitForChild("Basic Tiles"):GetChildren()
local main = mapObjs:WaitForChild("Main Tiles"):GetChildren()

local cells, empty = {}, {}
local placedTiles = {}
local cellpos = Vector3.new(1000, 0, 1000)
local spawnTile = nil
local killme = 0

-- cell creation
for i = 1, 27 do
	table.insert(cells, cellpos)
	for i = 1, 26 do
		cellpos = cellpos + Vector3.new(15, 0, 0)
		table.insert(cells, cellpos)
		--local part = Instance.new("SpawnLocation")
		--part.Anchored, part.CanCollide, part.Position, part.Size, part.Name = true, true, cellpos, Vector3.new(15, 1, 15), "Ground"
		--part.Parent = ground
		-print("bruh")
	end
	cellpos = (cellpos*Vector3.new(0, 1, 1))+Vector3.new(-165, 0, -15)
	--local part = Instance.new("SpawnLocation")
	--part.Anchored, part.CanCollide, part.Position, part.Size, part.Name = true, true, cellpos, Vector3.new(15, 1, 15), "Ground"
	--part.Parent = ground
	wait(0.016)
end

warn("going")
-- table shuffle
local function tableshuffle(array)
	local old, new = {}, {}
	for _,v in pairs(array) do table.insert(old, v) end
	for i = 1, #array do
		local val = array[math.random(1, #array)]
		table.insert(new, val) table.remove(old, table.find(old, val))
	end
	return new
end

--cells = tableshuffle(cells)

-- Spawn/meetup room placement

--for _,v in pairs(map:GetDescendants()) do if v.Name == "Boundary" then v.Name = tostring(math.random(100000, 999999999)) end end

local function correctPos(vector)
	local X, Y, Z = vector.X, vector.Y, vector.Z
	-- round up
end
local function removeCells(tile)
	for _,v in pairs(tile:GetDescendants()) do
		if v.Name == "Cell" then
			print(v.Position)
			table.remove(cells, table.find(cells, v.Position))
			v:Destroy()
		end
	end
end
local function validateCells(tile)
	local validated = true
	for _,v in pairs(tile:GetDescendants()) do
		if v:IsA("BasePart") and v.Name == "Cell" then
			if not table.find(cells, v.Position) then
				for _,p in pairs(tile:GetDescendants()) do
					if p:IsA("BasePart") and math.floor(p.Position.Y + 0.5) ~= p.Position.Y + 0.5 then
						if p.Name == "Cell" then p.Position = Vector3.new(math.floor(p.Position.X + 0.5),math.floor(p.Position.Y + 0.5),math.floor(p.Position.Z + 0.5)) end
						p.Orientation = Vector3.new(math.floor(p.Orientation.X + 0.5),math.floor(p.Orientation.Y + 0.5),math.floor(p.Orientation.Z + 0.5))
					end
				end
			end
			if not table.find(cells, v.Position) then validated = false end
		end
	end
	return validated
end
local function getBounds(tile)
	--if not tile then return {} end
	return tile:FindFirstChild("Boundaries"):GetChildren()
end 

--warn(math.floor(#cells/2))
local cell = cells[math.floor(#cells/2)]
spawnTile = mapObjs:WaitForChild("Middle"):Clone()
spawnTile.Parent = map
spawnTile:SetPrimaryPartCFrame(CFrame.new(cell))
--wait(5)
removeCells(spawnTile)
table.insert(placedTiles, spawnTile)

--wait(5)
-- main room placement
local tiles = tableshuffle(main)
for _,tile in pairs(tiles) do
	print(tile.Name)
	local current = tile:Clone()
	local location = false
	while not location do
		location = cells[math.random(1, #cells)]
		current.Parent = map
		current:SetPrimaryPartCFrame(CFrame.new(location))
		if validateCells(current) == true then
			removeCells(current)
			table.insert(placedTiles, current)
			--warn("YAY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		else
			location = nil
		end
		wait(0.5)
	end
end

--wait(5)

-- basic/branching rooms
local links = {}
for _,v in pairs(placedTiles) do for i,link in pairs(getBounds(v)) do print("added") table.insert(links, link) if v == spawnTile then killme = i end end end


local fits, link = false, nil
while #links > 0 do
	wait(0.016)
	link = links[killme] -- random link
	--print(link.Parent.Parent.Name)
	fits = false
	--warn("Tableshuffle = ".. #tableshuffle(basic))
	for _,tile in pairs(tableshuffle(basic)) do -- go thru all basic tiles+
		if not fits then -- already found a fit? nvm!
			local newtile = tile:Clone() newtile.Parent = map.Tiles
			newtile:WaitForChild("Boundaries")
			local tileLinks = tableshuffle(getBounds(newtile))
			for _,v in pairs(tileLinks) do -- check all links in the tile to see if it fits
				if not fits then
					newtile.PrimaryPart = v
					newtile:SetPrimaryPartCFrame(link.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)))
					fits = validateCells(newtile)
					if fits == true then
						--warn("fitted")
						for _,alllinks in pairs(tileLinks) do if alllinks ~= v then table.insert(links, alllinks) end end
						v:Destroy()
						removeCells(newtile)
					end
					--warn(fits)
				end
			end
			if not fits then newtile:Destroy() end
		end
	end
	--warn("fits = ".. tostring(fits))z
	link:Destroy()
	table.remove(links, table.find(links, link))
	if #links <= 0 then
		for _,v in pairs(script:GetDescendants()) do if v.Name == "Boundary" then table.insert(links, v) end end
	end
	if #links > 0 then killme = math.random(1, #links) end
end

for _,v in pairs(cells) do
	local flooring = Instance.new("SpawnLocation")
	flooring.Parent, flooring.Position, flooring.Size, flooring.Anchored = ground, v, Vector3.new(15, 1, 15), true
	flooring.Material, flooring.Color = Enum.Material.Wood, Color3.fromRGB(99, 95, 98)
end
warn("filling in floor")
--for _,v in pairs(map:GetDescendants()) do if v.Name == "Floor" then v:Destroy() end end
mapObjs:Destroy()

--for _,v in pairs(game:GetService("Players"):GetChildren()) do v:LoadCharacter() end
