--// Written by depso
--// MIT License
--// Copyright (c) 2024 Depso

local ImGui = {
	Windows = {},
	UIAssetId = 76246418997296,
	DefaultTitle = "ImGui",
	ScreenGuiName = "ImGui",

	IsStudio = false,
	DefaultParent = nil,
	PrefabsFolder = nil,
	
	Animation = {
		DefaultTweenInfo = TweenInfo.new(0.1)
	}
}

ImGui.Acent = {
	Light = Color3.fromRGB(66, 150, 250),
	Dark = Color3.fromRGB(41, 75, 121),
	White = Color3.fromRGB(255, 255, 255),
	Gray = Color3.fromRGB(127, 126, 129),
}

ImGui.Colors = {
	WindowBg = Color3.fromRGB(0, 16, 24),
	Border = Color3.fromRGB(135, 135, 148),
	Title = ImGui.Acent.White,
	ToolBarBg = Color3.fromRGB(36, 36, 36),
	TabText = Color3.fromRGB(200, 200, 200),
	TabBg = ImGui.Acent.Light,
	ResizeGrab = ImGui.Acent.Light,

	--// Elements
	Labels = ImGui.Acent.White,
	ButtonsBg = ImGui.Acent.Light,
	ButtonsText = ImGui.Acent.White,
	CheckBoxBg = ImGui.Acent.Dark,
	CollapsingHeaderBg = ImGui.Acent.Light,
	CollapsingHeaderText = ImGui.Acent.Light,
	RadioButtonSelectedBg = ImGui.Acent.Gray,
	CheckboxBg = ImGui.Acent.Dark,
	CheckboxTick = ImGui.Acent.Light,

	DeselectedTitleBarBG = Color3.fromRGB(0, 0, 0),
	DeselectedTitleBarTrans = 0.7,
	SelectedTitleBar = ImGui.Acent.Dark,
	SelectedTitleBarTrans = 0,
	BorderSelectedTrans = 0,
	BorderDeselectedTrans = 0.7
}

ImGui.ColoringData = {
	["Label"] = {
		TextColor3 = "Labels"
	},
	["Title"] = {
		TextColor3 = "Title"
	},
	["TitleBar"] = {
		BackgroundColor3 = "TitleBg"
	},
	["Border"] = {
		Color = "Border"
	},
	["Window"] = {
		BackgroundColor3 = "WindowBg"
	},
	["Toolbar"] = {
		BackgroundColor3 = "ToolBarBg"
	},
	["Tab"] = {
		TextColor3 = "TabText",
		BackgroundColor3 = "TabBg"
	},
	["ResizeGrab"] = {
		TextColor3 = "ResizeGrab"
	},
	["DeselectedTitleBar"] = {
		BackgroundColor3 = "DeselectedTitleBarBG",
		BackgroundTransparency = "DeselectedTitleBarTrans"
	},
	["SelectedTitleBar"] = {
		BackgroundColor3 = "SelectedTitleBar",
		BackgroundTransparency = "SelectedTitleBarTrans"
	},
	["BorderSelected"] = {
		Transparency = "BorderSelectedTrans"
	},
	["BorderDeselected"] = {
		Transparency = "BorderDeselectedTrans"
	},
	["CollapsingHeader"] = {
		BackgroundColor3 = "CollapsingHeaderBg",
	},
	["CollapsingHeaderText"] = {
		BackgroundColor3 = "CollapsingHeaderText",
	},
	["Button"] = {
		BackgroundColor3 = "ButtonsBg",
		TextColor3 = "ButtonsText",
	},
	["RadioButton"] = {
		BackgroundColor3 = "RadioButtonSelectedBg",
	},
	["Checkbox"] = {
		BackgroundColor3 = "CheckboxBg",
	},
	["CheckboxTick"] = {
		ImageColor3 = "CheckboxTick",
		BackgroundColor3 = "CheckboxTick",
	}
}

ImGui.Styles = {
	RadioButton = {
		Animations = {
			"RadioButtons"
		},
		CornerRadius = UDim.new(1, 0),
	},
	Button = {
		Animations = {
			"Buttons"
		},
	},
	CollapsingHeader = {
		Animations = {
			"Buttons"
		},
	},
	TreeNode = {
		Animations = {
			"TransparentButtons"
		},
	}
}

ImGui.Animations = {
	["Buttons"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.5,
			},
			MouseLeave = {
				BackgroundTransparency = 0.7,
			}
		},
		Init = "MouseLeave"
	},
	["TransparentButtons"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.5,
			},
			MouseLeave = {
				BackgroundTransparency = 1,
			}
		},
		Init = "MouseLeave"
	},
	["RadioButtons"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.5,
			},
			MouseLeave = {
				BackgroundTransparency = 1,
			}
		},
		Init = "MouseLeave"
	},
	["Tabs"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.6,
			},
			MouseLeave = {
				BackgroundTransparency = 1,
			},
		},
		Init = "MouseLeave"
	},
	["Inputs"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0,
			},
			MouseLeave = {
				BackgroundTransparency = 0.5,
			},
		},
		Init = "MouseLeave"
	},
	["Border"] = {
		Connections = {
			Selected = {
				Transparency = 0,
				Thickness = 1
			},
			Deselected = {
				Transparency = 0.7,
				Thickness = 1
			}
		},
		Init = "Selected"
	},
}

ImGui.Properties = {
	{
		Aliases = {"ElementStyle"},
		Callback = function<StyleFunc>(Object, Data, Value)
			ImGui:ApplyStyle(Object, Value)
		end,
	},
	 {
	 	Aliases = {"ColorTag"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local WindowClass = Data.WindowClass
			local Colors = WindowClass.Colors
			
			ImGui:UpdateColors({
				Object = Object,
				Tag = Value,
				Animate = false,
				Colors = Colors,
			})
	 	end,
	 },
	{
		Aliases = {"Animations"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local Class = Data.Class
			local NoAnimation = Class.NoAnimation
			if NoAnimation then return end

			ImGui:ApplyAnimationsFromNames({
				Object = Object,
				Names = Value
			})
		end,
	},
	{
		Aliases = {"Icon", "IconSize"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local Icon = Object:FindFirstChild("Icon")
			if not Icon then return end 
			
			local Class = Data.Class
			local IconSize = Class.IconSize
			local Image = Class.Icon

			Icon.Visible = Value and true
			Icon.Image = Image or ""

			if IconSize then
				Icon.Size = IconSize
			end
		end,
	},
	{
		Aliases = {"BorderThickness", "Border"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local Class = Data.Class
			local Enabled = Class.Border ~= false
			local Thickness = Class.BorderThickness
			
			local Stroke = ImGui:GetChildOfClass(Object, "UIStroke")
			Stroke.Thickness = Thickness or (Enabled and 1 or 0)
			Stroke.Enabled = Enabled
		end,
	},
	{
		Aliases = {"Ratio"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local AspectRatio = Value.Ratio or 4/3
			local Axis = Value.Axis or Enum.DominantAxis.Height
			local AspectType = Value.AspectType or Enum.AspectType.ScaleWithParentSize

			local Ratio = ImGui:GetChildOfClass(Object, "UIAspectRatioConstraint")
			Ratio.DominantAxis = Axis
			Ratio.AspectType = AspectType
			Ratio.AspectRatio = AspectRatio
		end,
	},
	{
		Recursive = true,
		Aliases = {"CornerRadius"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local UICorner = ImGui:GetChildOfClass(Object, "UICorner")
			UICorner.CornerRadius = Value
		end,
	},
	{
		Aliases = {"Label"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local Label = Object:FindFirstChild("Label")
			if not Label then return end
			
			local Class = Data.Class
			
			function Class:SetLabel(Text)
				Label.Text = Text
				return Class
			end
			Label.Text = Value
		end,
	},
	{
		Aliases = {"NoGradient"},
		LibraryAliases = {"NoGradientAll"},
		Callback = function<StyleFunc>(Object, Data, Value)
			local UIGradient = Object:FindFirstChildOfClass("UIGradient")
			if not UIGradient then return end
			UIGradient.Enabled = Value
		end,
	},
	{
		Aliases = {"Callback"},
		Callback = function<StyleFunc>(Object, Data)
			local Class = Data.Class
			function Class:SetCallback(NewCallback)
				Class.Callback = NewCallback
				return Class
			end
			function Class:FireCallback(NewCallback)
				Class.Callback(Object)
				return Class
			end
		end,
	},
	{
		Aliases = {"Value"},
		Callback = function<StyleFunc>(Object, Data)
			local Class = Data.Class
			function Class:GetValue()
				return Class.Value
			end
		end,
	}
}

--// Compatibility 
local EmptyFunction = function() end
local GetHiddenUI = get_hidden_gui or gethui
local CloneRef = cloneref or function(Ins): Instance 
	return Ins 
end

--// Service handlers
local Services = setmetatable({}, {
	__index = function(self, Name)
		local Service = game:GetService(Name)
		return CloneRef(Service)
	end,
})

--// Core functions 
--// Services
local RunService: RunService = Services.RunService
local Players: Players = Services.Players
local CoreGui = Services.CoreGui
local UserInputService = Services.UserInputService
local TweenService = Services.TweenService

--// Local player
local LocalPlayer = Players.LocalPlayer

ImGui.PlayerGui = LocalPlayer.PlayerGui
ImGui.IsStudio = ImGui.IsStudio or RunService:IsStudio()

function Merge(Base, New)
	if not New then return end
	for Key, Value in next, New do
		Base[Key] = Value
	end
end

local function NewClass(Base)
	Base.__index = Base
	return setmetatable({}, Base)
end

function ImGui:Init()
	self.DefaultParent = self:GetParent()
	self.PrefabsFolder = self:InsertPrefabs()

	--self.FullScreenGui = ImGui:CreateInstance("ScreenGui", GuiParent, {
	--	DisplayOrder = 99999,
	--	ResetOnSpawn = false,
	--	ScreenInsets = Enum.ScreenInsets.None
	--})
end

--// Animation Service
local Animation = ImGui.Animation

type AnimationTween = {
	Object: Instance,
	NoAnimation: boolean?,
	Tweeninfo: TweenInfo?,
	EndProperites: {}
}
function Animation:Tween(Data: AnimationTween): Tween
	local DefaultTweenInfo = self.DefaultTweenInfo

	local Object = Data.Object
	local NoAnimation = Data.NoAnimation
	local Tweeninfo = Data.Tweeninfo or DefaultTweenInfo
	local EndProperites = Data.EndProperites

	local Sucess, Tween = pcall(function()
		return TweenService:Create(Object, Tweeninfo, EndProperites)
	end)
	
	if not Sucess then
		warn("Tween failed for", Object)
		warn("Type:", typeof(Object))
		warn("Props:", EndProperites)
		
		error(Tween)
	end
	
	Tween:Play()

	return Tween
end

type Animate = {
	NoAnimation: boolean?,
	Objects: {},
	Tweeninfo: TweenInfo?
}
function Animation:Animate(Data): Tween
	local NoAnimation = Data.NoAnimation
	local Objects = Data.Objects
	local Tweeninfo = Data.Tweeninfo
	local BaseTween = nil

	for Object, EndProperites in next, Objects do
		local Tween = self:Tween({
			NoAnimation = NoAnimation,
			Object = Object,
			Tweeninfo = Tweeninfo, 
			EndProperites = EndProperites
		})

		if not BaseTween then
			BaseTween = Tween
		end
	end

	return BaseTween
end

type HeaderCollapse = {
	Open: boolean,
	ClosedSize: UDim2,
	OpenSize: UDim2,
	Toggle: Instace,
	Resize: Instance,
	Hide: Instance,
	NoAnimation: boolean,
	NoAutomaticSize: boolean
}
function Animation:HeaderCollapse(Data: HeaderCollapse): Tween
	--// Check configuation
	ImGui:CheckConfig(Data, {
		IconRotations = {
			Open = 90,
			Closed = 0
		}
	})

	--// Unpack config
	local Open = Data.Open
	local ClosedSize = Data.ClosedSize
	local OpenSize: UDim2 = Data.OpenSize
	local Toggle = Data.Toggle
	local Resize = Data.Resize
	local Hide = Data.Hide
	local NoAnimation = Data.NoAnimation
	local NoAutomaticSize = Data.NoAutomaticSize
	local Rotations = Data.IconRotations

	local Rotation = Open and Rotations.Open or Rotations.Closed

	--// Disable AutomaticSize
	if not NoAutomaticSize then
		Resize.AutomaticSize = Enum.AutomaticSize.None
	end

	--// Reset AutomaticSize after animation
	local function Completed()
		if not Open then return end

		Resize.Size = OpenSize

		if not NoAutomaticSize then
			Resize.AutomaticSize = Enum.AutomaticSize.Y
		end
	end

	--// Build and play animation keyframes
	local Tween = self:Animate({
		NoAnimation = NoAnimation,
		Objects = {
			[Toggle] = {
				Rotation = Rotation,
			},
			[Resize] = {
				Size = Open and OpenSize or ClosedSize
			},
			--[Hide] = {
			--	Visible = Open,
			--}
		}
	})

	--// Connect events
	Tween.Completed:Connect(Completed)

	return Tween
end

function ImGui:InsertPrefabs(): Folder
	local IsStudio = self.IsStudio
	local PlayerGui = self.PlayerGui
	local UIAssetId = self.UIAssetId

	--// Studio | PlayerGui or Script
	if IsStudio then
		local Name = "Depso-ImGui-Prefabs"
		local ScriptUi = script:FindFirstChild(Name)
		return ScriptUi or PlayerGui:WaitForChild(Name, 10) 
	end

	--// Other | Import asset
	local AssetPath = `rbxassetid://{UIAssetId}`
	return self:GetObjects(AssetPath)
end

function ImGui:GetParent(): GuiObject
	local DefaultParent = self.DefaultParent
	local PlayerGui = self.PlayerGui
	local Name = self.ScreenGuiName

	--// Force overwrite
	if DefaultParent then
		return DefaultParent
	end

	--// Detection prevention steps for Executors
	local Steps = {
		[1] = function()
			return GetHiddenUI()
		end,
		[2] = function()
			return CoreGui:FindFirstChild('RobloxGui')
		end,
		[3] = function()
			return Instance.new("ScreenGui", CoreGui), true
		end,
		[4] = function()
			return Instance.new("ScreenGui", PlayerGui), true
		end,
	}

	--// Test each step for a successful parent
	for _, CreateFunc in next, Steps do
		local Success, Parent, ChangeName = pcall(CreateFunc)

		if not Success then continue end
		if not Parent then continue end

		--// Change ScreenGUI name
		if ChangeName then
			Parent.Name = Name
		end

		return Parent
	end

	return warn("No default parent for UIs!")
end

function ImGui:CheckConfig(Source, Base)
	for Key, Value in next, Base do
		if Source[Key] == nil then
			Source[Key] = Value
		end
	end
	return Source
end

function ImGui:CreateInstance(Class, Parent, Properties): Instance
	local Instance = Instance.new(Class, Parent)
	Merge(Instance, Properties)

	return Instance
end

type UpdateColors = {
	Config: Instance,
	Tag: string,
	Animate: boolean?,
}
function ImGui:UpdateColors(Config)
	local ColoringData = self.ColoringData
	local DefaultColors = self.Colors
	
	--// Unpack config
	local Object = Config.Object
	local Tag = Config.Tag
	local Animate = Config.Animate
	local Colors = Config.Colors or DefaultColors
	
	local Coloring = ColoringData[Tag]
	local Properties = {}
	
	--// Check if coloring data exists
	if not Coloring then return end

	--// Add coloring data to properties
	for Key, Name in next, Coloring do
		local Color = Colors[Name] or DefaultColors[Name]
		if not Color then continue end

		Properties[Key] = Color
	end

	--// Tween new properties
	Animation:Tween({
		Object = Object,
		NoAnimation = Animate,
		EndProperites = Properties
	})
end

function ImGui:MultiUpdateColors(Config)
	local Objects = Config.Objects
	local Animate = Config.Animate
	local Colors = Config.Colors

	for Object, Tag in next, Objects do
		self:UpdateColors({
			Object = Object,
			Tag = Tag,
			Animate = Animate,
			Colors = Colors,
		})
	end
end

function ImGui:ApplyStyle(Object: GuiObject, StyleName: string)
	local Styles = self.Styles
	local Animations = self.Animations

	local Style = Styles[StyleName]
	if not Style then return end

	self:ApplyProperties({
		Object = Object,
		Class = Style
	})
end

function ImGui:ApplyAnimationsFromNames(Config)
	local Animations = self.Animations

	local Names = Config.Names
	local Object = Config.Object

	for _, Name: string in next, Names do
		self:ApplyAnimation(Object, Name)
	end
end

function ImGui:MergeMetatables(Class, Object: GuiObject)
	local Metadata = {}

	Metadata.__index = function(self, Key: string)
		--// Fetch value from class
		local Value = Class[Key]
		if Value then return Value end

		--// Fetch value from Object
		Value = Object[Key]

		--// Patch 'self'
		if typeof(Value) == "function" then
			return function(_, ...)
				return Value(Object, ...)
			end
		end

		return Value
	end

	Metadata.__newindex = function(self, Key: string, Value)
		local IsClassValue = Class[Key] or typeof(Value) == "function"

		if IsClassValue then
			Class[Key] = Value
			return
		end

		xpcall(function()
			Object[Key] = Value
		end, function(err)
			warn(`Newindex Error: {Object}.{Key} = {Value}\n{err}`)
			Class[Key] = Value
		end)
	end

	return setmetatable({}, Metadata)
end

function ImGui:Concat(Table, Separator: " ") 
	local Concatenated = ""
	for Index, String in next, Table do
		Concatenated ..= tostring(String) .. (Index ~= #Table and Separator or "")
	end
	return Concatenated
end

function ImGui:GetValueFromAliases(Aliases, Table)
	for _, Alias: string in Aliases do
		local Value = Table[Alias]
		if Value then
			return Value
		end
	end
end

export type ApplyProperties = {
	Object: Instance,
	Class: table,
	WindowClass: table?
}
function ImGui:ApplyProperties(Config: ApplyProperties)
	local Properties = self.Properties
	
	--// Unpack config
	local Object = Config.Object
	local Class = Config.Class
	local WindowClass = Config.WindowClass

	--// Set base properties
	self:SetProperties(Object, Class)

	--// Check for callbacks
	for _, Style in next, Properties do
		local Aliases = Style.Aliases
		local Callback = Style.Callback

		local Value = self:GetValueFromAliases(Aliases, Class)

		if Value and Value ~= "None" then
			Callback(Object, Config, Value)
		end
	end
end

--// Container class
local Elements = {}
Elements.__index = Elements

type WrapCreation = {
	Defaults: table,
	Canvas: table,
	Function: (table, ...any) -> (Instance|table)
}
function ImGui:WrapCreation(Config: WrapCreation)
	local Defaults = Config.Defaults
	local Canvas = Config.Canvas -- (SELF)
	local Function = Config.Function
	local Elements = Config.Elements
	local WindowClass = Config.WindowClass

	return function(_, Config, ...)
		--// Create Config
		local Config = Config or {}
		self:CheckConfig(Config, Defaults)

		--// Create element and apply properties
		local Class, Element = Function(Canvas, Config, ...)
		
		--// Some elements may return the instance without a class
		if Element == nil then
			Element = Class
		end

		--// Add to elements dict
		if Elements then
			local ColorTag = Config.ColorTag
			local ToColor = Config.ToColor
			
			if ToColor then
				Merge(Elements, ToColor)
			elseif typeof(Element) == "Instance" then
				Elements[Element] = ColorTag
			end
		end
		
		--// If automatic properties are disallowed
		if Element == false then return Class end

		self:ApplyProperties({
			Object = Element,
			Class = Config,
			WindowClass = WindowClass
		})

		return Class
	end
end

type MakeCanvas = {
	Element: Instance,
	Window: WindowClass,
	Class: {}
}
function ImGui:MakeCanvas(Config: MakeCanvas)
	local Element = Config.Element
	local WindowClass = Config.Window
	local Class = Config.Class

	--// Create new canvas class
	local Canvas = NewClass(Elements)
	Canvas.Element = Element
	Canvas.WindowClass = WindowClass

	--// Elements dict
	local Elements
	if WindowClass then
		Elements = WindowClass.Elements
	end

	--// Create metatable merge
	local Meta = {
		__index = function(_, Key: string)
			--// Check class for value
			local Func = Canvas[Key]

			--// Return property from Class or Instance
			if not Func then
				local ClassValue = Class[Key]
				if ClassValue ~= nil then return ClassValue end

				return Element[Key]
			end

			--// Create element function wrap
			return self:WrapCreation({
				Defaults = {
					Visible = true,
					Parent = Element,
					ColorTag = Key,
					ElementStyle = Key
				},
				WindowClass = WindowClass,
				Elements = Elements,
				Canvas = Canvas,
				Function = Func,
			})
		end,
		__newindex = function(self, Key: string, Value)
			local IsTableValue = Class[Key] ~= nil

			--// Update key value
			if IsTableValue then
				Class[Key] = Value
			else
				Element[Key] = Value
			end
		end,
	}

	return setmetatable({}, Meta)
end

function ImGui:SetProperties(Object: Instance, Properties)
	for Key: string, Value in next, Properties do
		pcall(function()
			Object[Key] = Value
		end)
	end
end

function ImGui:InsertPrefab(Name: string, Properties): Instance
	local Folder = ImGui.PrefabsFolder
	local Prefabs = Folder.Prefabs
	local Element = Prefabs:WaitForChild(Name)
	local New = Element:Clone()

	self:SetProperties(New, Properties)

	return New
end

function ImGui:GetContentSize(Object: GuiObject): Vector2
	local UIListLayout = Object:FindFirstChildOfClass("UIListLayout")
	local UIPadding = Object:FindFirstChildOfClass("UIPadding")
	
	local ContentSize
	
	--// Fetch absolute size
	if UIListLayout then
		ContentSize = UIListLayout.AbsoluteContentSize
	else
		ContentSize = Object.AbsoluteSize
	end
	
	--// Apply padding
	if UIPadding then
		local Top = UIPadding.PaddingTop.Offset
		local Bottom = UIPadding.PaddingBottom.Offset
		
		local Left = UIPadding.PaddingLeft.Offset
		local Right = UIPadding.PaddingRight.Offset
		
		ContentSize += Vector2.new(Left+Right, Top+Bottom)
	end
	
	return ContentSize
end

function Elements:GetRemainingHeight(): UDim2
	local Parent = self.Element
	local Occupied = ImGui:GetContentSize(Parent)
	
	print(Occupied)

	return UDim2.new(1, 0, 1, -Occupied.Y)
end

type Button = {
	Callback: ((...any) -> unknown)?
}
function Elements:Button(Config: Button): Button
	local Object = ImGui:InsertPrefab("Button", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	Object.Activated:Connect(function(...)
		local Func = Config.Callback or EmptyFunction
		return Func(Class, ...)
	end)

	return Class, Object
end

type Image = {
	Image: (string|number),
	Callback: ((...any) -> unknown)?
}
function Elements:Image(Config: Image): Image
	local Image = Config.Image or ""
	Config.ElementStyle = "Button"
	
	--// Convert Id number to asset URL
	if tonumber(Image) then
		Config.Image = `rbxassetid://{Image}`
	end
	
	local Object = ImGui:InsertPrefab("Image", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	Object.Activated:Connect(function(...)
		local Func = Config.Callback or EmptyFunction
		return Func(Class, ...)
	end)

	return Object
end

function Elements:ScrollingBox(Config)
	local Object = ImGui:InsertPrefab("ScrollBox", Config)
	local Class = ImGui:MergeMetatables(Config, Object)
	return Class
end

export type Label = {
	Bold: boolean?,
	Italic: boolean?,
	Font: string?
}
function Elements:Label(Config: Label): GuiObject
	local IsBold = Config.Bold
	local IsItalic = Config.Italic
	local FontName = Config.Font

	--// Weghts
	local Medium = Enum.FontWeight.Medium
	local Bold = Enum.FontWeight.Bold

	--// Styles
	local Normal = Enum.FontStyle.Normal
	local Italic = Enum.FontStyle.Italic

	local Weight = IsBold and Bold or Medium
	local Style = IsItalic and Italic or Normal
	local Name = FontName or "Inconsolata"

	--// Create label
	local Object = ImGui:InsertPrefab("Label", Config)
	Object.FontFace = Font.fromName(Name, Weight, Style)

	return Object
end

function Elements:RadioButton(Config): GuiObject
	local Object = ImGui:InsertPrefab("RadioButton", Config)

	Object.Activated:Connect(function(...)
		local Callback = Config.Callback or EmptyFunction
		return Callback(Object, ...)
	end)

	return Object
end

type Checkbox = {
	IsRadio: boolean?,
	Value: boolean,
	NoAnimation: boolean?,
	Callback: ((...any) -> unknown)?,
	SetTicked: (self: Checkbox, Value: boolean, NoAnimation: boolean) -> ...any,
	Toggle: (self: Checkbox) -> ...any,
}
function Elements:Checkbox(Config: Checkbox): Checkbox
	ImGui:CheckConfig(Config, {
		IsRadio = false,
		Value = false,
		TickedImageSize = UDim2.fromScale(1,1),
		UntickedImageSize = UDim2.fromScale(0,0),
		Callback = EmptyFunction
	})
	
	--// Unpack configuation
	local IsRadio = Config.IsRadio
	local Value = Config.Value
	local TickedSize = Config.TickedImageSize
	local UntickedSize = Config.UntickedImageSize
	
	--// Check checkbox object
	local Object = ImGui:InsertPrefab("CheckBox", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	local Label = Object.Label
	local Tickbox = Object.Tickbox
	local Tick = Tickbox.Tick
	
	local UIPadding = Tickbox:FindFirstChildOfClass("UIPadding")
	local UICorner = Tickbox:FindFirstChildOfClass("UICorner")
	
	Config.ToColor = {
		[Tickbox] = "Checkbox",
		[Tick] = "CheckboxTick",
	}

	--// Stylise to correct type
	if IsRadio then
		Tick.ImageTransparency = 1
		Tick.BackgroundTransparency = 0
	else
		UIPadding:Remove()
		UICorner:Remove()
	end

	--// Callback
	local function Callback(...)
		local func = Config.Callback
		return func(Class, ...)
	end

	function Config:SetTicked(Value: boolean, NoAnimation: boolean)
		local Size = Value and TickedSize or UntickedSize

		self.Value = Value
		
		----// Animate
		--// Animate tick
		Animation:Tween({
			Object = Tick,
			NoAnimation = NoAnimation,
			EndProperites = {
				Size = Size
			}
		})
		--// Animate text
		Animation:Tween({
			Object = Label,
			NoAnimation = NoAnimation,
			EndProperites = {
				TextTransparency = Value and 0 or 0.3
			}
		})
		
		--// Fire callback
		Callback(Value)

		return self
	end
	
	function Config:Toggle()
		local Value = not self.Value
		self.Value = Value
		self:SetTicked(Value)

		return self
	end

	--// Connect functions
	local function Clicked()
		Config:Toggle()
	end
	
	--// Connect events
	Object.Activated:Connect(Clicked)
	Tickbox.Activated:Connect(Clicked)
	
	--// Update UI
	Config:SetTicked(Value, true)

	return Class, Object
end

function Elements:Radiobox(Config: Checkbox): Checkbox
	Config.IsRadio = true
	return self:Checkbox(Config)
end

type Viewport = {
	Model: Instance,
	WorldModel: WorldModel?,
	Viewport: ViewportFrame?,
	Camera: Camera?,
	Clone: boolean?,

	SetCamera: (self: Viewport, Camera: Camera) -> Viewport,
	SetModel: (self: Viewport, Model: Model, PivotTo: CFrame?) -> Model,
}
function Elements:Viewport(Config: Viewport): Viewport
	local Object = ImGui:InsertPrefab("Viewport", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	local Viewport = Object.Viewport
	local WorldModel = Viewport.WorldModel

	local Model = Config.Model
	local Camera = Config.Camera or ImGui:CreateInstance("Camera", Viewport)

	Config.Camera = Camera
	Config.WorldModel = WorldModel
	Config.Viewport = Viewport

	function Config:SetCamera(Camera)
		Camera.CFrame = CFrame.new(0,0,0)

		Viewport.CurrentCamera = Camera
		self.Camera = Camera

		return self
	end

	function Config:SetModel(Model: Model, PivotTo: CFrame?)
		local CreateClone = self.Clone

		WorldModel:ClearAllChildren()

		--// Set new model
		if CreateClone then
			Model = Model:Clone()
		end
		if PivotTo then
			Model:PivotTo(PivotTo)
		end

		Model.Parent = WorldModel
		self.Model = Model

		return Model
	end

	--// Set model
	if Model then
		Config:SetModel(Model)
	end

	Config:SetCamera(Camera)

	return Class
end

type InputText = {
	Value: string,
	PlaceHolder: string?,
	MultiLine: boolean?,
	Label: string?,
	Callback: ((string, ...any) -> unknown)?,
	Clear: (InputText) -> InputText,
	SetValue: (InputText, Value: string) -> InputText,
}
function Elements:InputText(Config: InputText): InputText
	ImGui:CheckConfig(Config, {
		Value = "",
		PlaceHolder = "Type here",
		Callback = EmptyFunction,
		MultiLine = false,
	})
	
	local Value = Config.Value
	local MultiLine = Config.MultiLine
	local PlaceHolder = Config.PlaceHolder
	
	--// Create Text input object
	local Object = ImGui:InsertPrefab("TextInput", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	local TextBox: TextBox = Object.Input
	TextBox.PlaceholderText = PlaceHolder
	TextBox.MultiLine = MultiLine

	local function Callback(...)
		local Func = Config.Callback
		Func(Class, ...)
	end

	function Config:SetValue(Value)
		TextBox.Text = tostring(Value)
		self.Value = Value
		return Config
	end
	
	function Config:Clear()
		TextBox.Text = ""
		return Config
	end
	
	local function Changed()
		local Value = TextBox.Text
		Config.Value = Value
		Callback(Value)
	end

	--// Connect events
	TextBox:GetPropertyChangedSignal("Text"):Connect(Changed)

	return Object, Class
end

function Elements:InputTextMultiline(Config)
	Config.Label = ""
	Config.Size = UDim2.new(1, 0, 0, 38)
	Config.MultiLine = true
	return self:InputText(Config)
end

type Console = {
	Enabled: boolean?,
	ReadOnly: boolean?,
	Text: string?,
	RichText: boolean?,
	TextWrapped: boolean?,
	LineNumbers: boolean?,
	Fill: boolean,
	AutoScroll: boolean,
	LinesFormat: string,
	MaxLines: number,

	UpdateLineNumbers: (Console) -> Console,
	UpdateScroll: (Console) -> Console,
	SetText: (Console, Value: string) -> Console,
	GetValue: (Console) -> string,
	Clear: (Console) -> Console,
	AppendText: (Console, ...string) -> Console,
	CheckLineCount: (Console) -> Console,
}
function Elements:Console(Config: Console): Console
	ImGui:CheckConfig(Config, {
		Enabled = true,
		ReadOnly = false,
		Text = "",
		TextWrapped = false,
		RichText = false,
		LineNumbers = false,
		Fill = false,
		LinesFormat = "%s",
		MaxLines = 100,
	})
	
	--// Unpack configuation
	local ReadOnly = Config.ReadOnly
	local LineNumbers = Config.LineNumbers
	local Fill = Config.Fill
	
	local RemainingHeight = self:GetRemainingHeight()
	
	--// Create console object
	local Object = ImGui:InsertPrefab("Console", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	local Source: TextBox = Object.Source
	local Lines = Object.Lines
	
	Lines.Visible = LineNumbers
	Source.TextEditable = not ReadOnly

	--// Expand element size to fill
	if Fill then
		Object.Size = RemainingHeight
	end

	function Config:UpdateLineNumbers()
		--// Configuation
		local LineNumbers = self.LineNumbers
		local Format = self.LinesFormat 
		
		--// If line counts are disabled
		if not LineNumbers then return end

		local LinesCount = #Source.Text:split("\n")

		--// Update lines text
		Lines.Text = ""
		for Line = 1, LinesCount do
			local Text = Format:format(Line)
			local End = Line ~= LinesCount and '\n' or ''
			
			Lines.Text ..= `{Text}{End}`
		end
		
		--// Update console size to fit line numbers
		local LinesWidth = Lines.AbsoluteSize.X
		Source.Size = UDim2.new(1, -LinesWidth, 0, 0)
		
		return self
	end
	
	function Config:CheckLineCount()
		--// Configuation
		local MaxLines = Config.MaxLines
		
		local Text = Source.Text
		local Lines = Text:split("\n")
		
		--// Cut beginning
		if #Lines > MaxLines then
			local Cropped = Text:sub(#Lines[1])
			Source.Text = `{Cropped}\n`
		end

		return self
	end

	function Config:UpdateScroll()
		local CanvasSize = Object.AbsoluteCanvasSize
		Object.CanvasPosition = Vector2.new(0, CanvasSize.Y)
		return self
	end

	function Config:SetText(Text: string?)
		if not self.Enabled then return end
		
		Source.Text = tostring(Text)
		self:UpdateLineNumbers()
		
		return self
	end

	function Config:GetValue()
		return Source.Text
	end

	function Config:Clear()
		Source.Text = ""
		self:UpdateLineNumbers()
		return self
	end

	function Config:AppendText(...)
		--// Configuation
		local Enabled = Config.Enabled
		if not Enabled then return end

		local NewString = "\n" .. ImGui:Concat({...}, " ") 

		--// Append string
		Source.Text ..= NewString

		--// Check if content needs to be cut
		self:CheckLineCount()
		
		Config:Update()

		return self
	end
	
	function Config.Update()
		--// Configuation
		local AutoScroll = Config.AutoScroll

		if AutoScroll then
			Config:UpdateScroll()
		end
		
		Config:UpdateLineNumbers()
	end

	--// Connect events
	Source:GetPropertyChangedSignal("Text"):Connect(Config.Update)

	return Class, Object
end

type Table = {
	Fill: boolean?,
	Align: string?,
	Border: boolean?,
	RowsFill: boolean?,
	Grid: boolean?,
	RowBackground: boolean?,

	CreateRow: (Table) -> unknown,
	UpdateRows: (Table) -> unknown,
	ClearRows: (Table) -> unknown,
}
function Elements:Table(Config: Table): Table
	ImGui:CheckConfig(Config, {
		Align = "Center",
		Fill = false,
		RowBackground = true,
		RowBackgroundTransparency = 0.9,
		Border = false,
		RowsFill = false,
	})
	
	local Window = self.WindowClass
	
	--// Unpack configuation
	local Align = Config.Align
	local RowBackground = Config.RowBackground
	local Fill = Config.Fill
	local RowTransparency = Config.BackgroundTransparency
	local Border = Config.Border
	local RowsFill = Config.RowsFill
	
	--// Create table object
	local Object = ImGui:InsertPrefab("Table", Config)
	local Class = ImGui:MergeMetatables(Config, Object)
	
	local UIListLayout = Object:FindFirstChildOfClass("UIListLayout")
	local RowTemplate = Object.RowTemp

	local RowsCount = 0
	local BaseTableCount = #Object:GetChildren() --// Performance
	
	--// Configure Table style
	if Fill then
		Object.Size = self:GetRemainingHeight()
	end

	function Config:CreateRow()
		RowsCount += 1
		
		--// Create Row object (Different to :Row)
		local Row = RowTemplate:Clone()
		Row.Name = "Row"
		Row.Visible = true
		Row.Parent = Object
		
		--// Set alignment
		local UIListLayout = Row:FindFirstChildOfClass("UIListLayout")
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment[Align]
		
		local BaseCount = #Row:GetChildren() --// Performance

		--// Background colors
		if RowBackground then
			local Transparency = RowsCount % 2 == 1 and RowTransparency or 1
			Row.BackgroundTransparency = Transparency
		end
		
		--// Row class
		local RowClass = {}
		function RowClass:CreateColumn()
			--// Create column object
			local Column = Row.ColumnTemp:Clone()
			Column.Visible = true
			Column.Name = "Column"
			Column.Parent = Row
			
			--// Apply border
			local Stroke = Column:FindFirstChildOfClass("UIStroke")
			Stroke.Enabled = Border
			
			--// Content canvas
			return ImGui:MakeCanvas({
				Element =  Column,
				Window = Window,
				Class = Class
			})
		end

		local function ResizeColumns()
			if not Row or not Object then return end

			local Columns = Row:GetChildren()
			local Count = #Columns - BaseCount
			
			local Width = 1 / Count
			local Size = UDim2.new(Width, 0, 0, 0)
			
			--// Resize each child column
			for _, Column in next, Columns do
				if not Column:IsA("Frame") then continue end
				Column.Size = Size
			end
			
			return RowClass
		end
		
		--// Connect events
		Row.ChildAdded:Connect(ResizeColumns)
		Row.ChildRemoved:Connect(ResizeColumns)
		
		--// Content canvas
		return ImGui:MakeCanvas({
			Element = Row,
			Window = Window,
			Class = RowClass
		})
	end

	local function ResizeRows()
		local Rows = Object:GetChildren()
		local PaddingY = UIListLayout.Padding.Offset + 2
		local Count = #Rows - BaseTableCount
		
		local Height = 1 / Count
		local Size = UDim2.new(1, 0, Height, -PaddingY)
		
		--// Resize each child row
		for _, Row: Frame in next, Rows do
			if not Row:IsA("Frame") then continue end
			Row.Size = Size
		end
		
		return Config
	end

	function Config:ClearRows()
		RowsCount = 0
		
		--// Destroy each row
		for _, Row: Frame in next, Object:GetChildren() do
			if not Row:IsA("Frame") then continue end
			if Row == RowTemplate then continue end
			
			Row:Destroy()
		end
		
		return Config
	end
	
	--// Expand rows to fill
	if RowsFill then
		Object.AutomaticSize = Enum.AutomaticSize.None
		
		--// Connect events
		Object.ChildAdded:Connect(ResizeRows)
		Object.ChildRemoved:Connect(ResizeRows)
	end

	return Class, Object
end

function Elements:Grid(Config)
	Config.Grid = true
	return self:Table(Config)
end

type CollapsingHeader = {
	Title: string,
	Icon: string?,
	IsTree: boolean?,
	NoAnimation: boolean?,
	Open: boolean?,

	SetOpen: (CollapsingHeader, Open: boolean) -> CollapsingHeader
}
function Elements:CollapsingHeader(Config: CollapsingHeader): CollapsingHeader
	ImGui:CheckConfig(Config, {
		Title = "Header",
		Icon = "rbxassetid://4731371527",
		NoAnimation = false,
		Open = false,
	})
	
	local Window = self.WindowClass
	
	--// Unpack config
	local Title = Config.Title
	local Icon = Config.Icon
	local NoAnimation = Config.NoAnimation
	local IsOpen = Config.Open
	local Style = Config.ElementStyle
	
	--// Create header object
	local Object = ImGui:InsertPrefab("CollapsingHeader", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	local Titlebar = Object.TitleBar
	local TitleText = Titlebar.Title
	local ToggleButton = Titlebar.Toggle.ToggleButton
	local ContentFrame = Object.ChildContainer
	local BaseSize = ContentFrame.Size
	
	--// Content canvas
	local Canvas = ImGui:MakeCanvas({
		Element =  ContentFrame,
		Window = Window,
		Class = Class
	})
	
	TitleText.Text = Title
	ToggleButton.Image = Icon
	
	--// Open Animations
	function Config:SetOpen(Open)
		local ContentSize = ImGui:GetContentSize(ContentFrame)
		local OpenSize = BaseSize + UDim2.fromOffset(0, ContentSize.Y)
		
		Animation:HeaderCollapse({
			Open = Open,
			Toggle = ToggleButton,
			Resize = ContentFrame,
			Hide = ContentFrame,
			
			--// Sizes
			ClosedSize = BaseSize,
			OpenSize = OpenSize ,
		})

		self.Open = Open
		return self
	end

	local function Toggle()
		Config:SetOpen(not Config.Open)
	end
	
	--// Apply style
	ImGui:ApplyStyle(Titlebar, Style)

	--// Update UI
	Config:SetOpen(IsOpen)

	--// Connect events
	Titlebar.Activated:Connect(Toggle)
	ToggleButton.Activated:Connect(Toggle)
	
	--// Add to elements dict
	Config.ToColor = {
		[Titlebar] = "CollapsingHeader",
		[TitleText] = "CollapsingHeaderText"
	}

	return Canvas, false
end

function Elements:TreeNode(Config)
	Config.IsTree = true
	return self:CollapsingHeader(Config)
end

type Separator = {
	Text: string?
}
function Elements:Separator(Config: Separator): Separator
	local Text = Config.Text
	
	--// Create septator object
	local Object = ImGui:InsertPrefab("SeparatorText", Config)
	local Class = ImGui:MergeMetatables(Config, Object)
	
	--// Configure text label
	local HeaderLabel = Object.TextLabel
	HeaderLabel.Text = tostring(Text)
	HeaderLabel.Visible = Text ~= nil
	
	return Object, Class
end

type Row = {
	Spacing: number?,

	Fill: (Row) -> Row
}
function Elements:Row(Config: Row): Row
	ImGui:CheckConfig(Config, {
		Spacing = 2
	})
	
	--// Unpack configuation
	local Window = self.WindowClass
	
	local Spacing = Config.Spacing
	
	--// Create row object
	local Object = ImGui:InsertPrefab("Row", Config)
	local Class = ImGui:MergeMetatables(Config, Object)

	local UIListLayout = Object:FindFirstChildOfClass("UIListLayout")
	local UIPadding = Object:FindFirstChildOfClass("UIPadding")
	UIListLayout.Padding = UDim.new(0, Spacing)

	function Config:Fill()
		local Children = Object:GetChildren()
		local Rows = #Children - 2 --// -UIListLayout + UIPadding

		--// Change layout
		local Alignment = Enum.HorizontalAlignment.Center
		local Padding = UIListLayout.Padding.Offset * 2
		UIListLayout.HorizontalAlignment = Alignment

		--// Apply correct margins
		UIPadding.PaddingLeft = UIListLayout.Padding
		UIPadding.PaddingRight = UIListLayout.Padding
		
		--// Resize elements
		for _, Child: Instance in next, Children do
			local YScale = 0
			if Child:IsA("ImageButton") then
				YScale = 1
			end
			pcall(function()
				Child.Size = UDim2.new(1/Rows, -(Padding+Spacing), YScale, 0)
			end)
		end
		return Config
	end
	
	--// Content canvas
	local Canvas = ImGui:MakeCanvas({
		Element = Object,
		Window = Window,
		Class = Class
	})

	return Canvas, Object
end

--TODO
-- Vertical 
-- :SetPercentage
type Slider = {
	Value: number?,
	Format: string?,
	Label: string?,
	Progress: boolean?,
	MinValue: number,
	MaxValue: number
}
function Elements:Slider(Config: Slider)
	ImGui:CheckConfig(Config, {
		Value = 0,
		Format = "%.d/%s",
		Label = "",
		Progress = false,
		NoAnimate = false
	})
	
	--// Unpack config
	local Value = Config.Value
	local Format = Config.Format
	local Label = Config.Label
	local IsProgress = Config.Progress
	local Animate = Config.NoAnimate ~= true
	Config.Name = Label or ""
	
	--// Create slider element
	local Object = ImGui:InsertPrefab("Slider", Config)
	local Grab: Frame = Object.Grab
	local ValueText = Object.ValueText
	local Label = Object.Label
	
	local UIPadding = Object:FindFirstChildOfClass("UIPadding")
	local Drag = ImGui:GetChildOfClass(Object, "UIDragDetector")

	local Class = ImGui:MergeMetatables(Config, Object)

	--// Input data
	local Dragging = false
	local MouseMoveConnection = nil
	local InputType = Enum.UserInputType.MouseButton1

	local function Callback(...)
		local func = Config.Callback or EmptyFunction
		return func(Class, ...)
	end

	--// Apply Progress styles
	if IsProgress then
		local UIGradient = Grab:FindFirstChildOfClass("UIGradient")

		local PaddingSides = UDim.new(0,2)
		local Diff = UIPadding.PaddingLeft - PaddingSides
		
		UIGradient.Enabled = true
		UIPadding.PaddingLeft = PaddingSides
		UIPadding.PaddingRight = PaddingSides
		
		Grab.AnchorPoint = Vector2.new(0, 0.5)
		
		Label.Position = UDim2.new(1, 15-Diff.Offset, 0, 0)
	end

	function Config:SetValue(Value: number, Slider: false)
		local MinValue = Config.MinValue
		local MaxValue = Config.MaxValue
		local Difference = MaxValue - MinValue
		local Percentage = (Value - MinValue) / Difference

		if not Slider then
			Value = tonumber(Value)
		else
			Percentage = Value
			Value = MinValue + (Difference * Percentage)
		end

		--// Animate grab
		local Props = {
			Position = UDim2.fromScale(Percentage, 0.5)
		}

		if IsProgress then
			Props = {
				Size = UDim2.fromScale(Percentage, 1)
			}
		end

		--// Animate
		Animation:Tween({
			Object = Grab,
			NoAnimation = Animate,
			EndProperites = Props
		})

		--// Update UI
		Config.Value = Value
		ValueText.Text = Format:format(Value, MaxValue) 

		--// Fire callback
		Callback(Value)

		return Config
	end

	------// Move events
	local function CanDrag(): boolean
		return not Config.ReadOnly
	end
	local function DragMovement(InputPosition)
		if not CanDrag() then return end

		local MouseX = UserInputService:GetMouseLocation().X
		local LeftPos = Object.AbsolutePosition.X

		local Percentage = (MouseX-LeftPos)/Object.AbsoluteSize.X
		Percentage = math.clamp(Percentage, 0, 1)
		Config:SetValue(Percentage, true)
	end
	
	--// Update UI
	Config:SetValue(Value)
	
	--// Connect movement events
	Drag.DragStart:Connect(DragMovement)
	Drag.DragContinue:Connect(DragMovement)

	return Class, Object
end

function Elements:ProgressSlider(Config)
	Config.Progress = true
	return self:Slider(Config)
end

type ProgressBar = {
	SetPercentage: (self, Value: number) -> nil
}
function Elements:ProgressBar(Config)
	Config.Progress = true
	Config.ReadOnly = true
	Config.MinValue = 0
	Config.MaxValue = 100
	Config.Format = "% i%%"
	function Config:SetPercentage(Value: number)
		Config:SetValue(Value)
	end

	return self:Slider(Config)
end

function ImGui:GetAnimation(Animation: boolean?)
	return Animation and self.Animation or TweenInfo.new(0)
end

function ImGui:ApplyAnimation(Object: GuiObject, Reference: string)
	local Animations = self.Animations

	local Data = Animations[Reference]
	assert(Data, `No animation data for Class {Reference}!`)

	local Init = Data.Init
	local Connections = Data.Connections
	local Tweeninfo = Data.Tweeninfo

	--// Connect signals
	local InitFunc = nil
	for SignalName, Properties in next, Connections do
		local function OnSignal()
			Animation:Tween({
				Object = Object,
				Tweeninfo = Tweeninfo, 
				EndProperites = Properties
			})
		end

		local Signal = Object[SignalName]
		Signal:Connect(OnSignal)

		if SignalName == Init then
			InitFunc = OnSignal
		end
	end

	--// Reset colors function
	if InitFunc then
		InitFunc()
	end
end

function ImGui:GetChildOfClass(Object: GuiObject, ClassName: string): GuiObject
	local Child = Object:FindFirstChildOfClass(ClassName)

	--// Create missing child
	if not Child then
		Child = Instance.new(ClassName, Object)
	end

	return Child
end

type Check = {
	Table: {},
	Key: string
}
local function GetCheckValue(Check): boolean?
	if not Check then return end

	local Table = Check.Table
	local Key = Check.Key
	local Value = Table[Key]
	return Value
end

type ApplyDraggable = {
	Move: Instance,
	Grab: Instance,
	Check: Check?
}
function ImGui:ApplyDraggable(Config: ApplyDraggable)
	--// Unpack config
	local Move = Config.Move
	local Grab = Config.Grab
	local Check = Config.Check

	local Drag = ImGui:GetChildOfClass(Grab, "UIDragDetector")

	local PositionOrgin = nil
	local InputOrgin = nil

	local function CanDrag(): boolean
		return GetCheckValue(Check) ~= true
	end
	local function DragBegin(InputPosition)
		PositionOrgin = Move.Position
		InputOrgin = InputPosition
	end
	local function DragMovement(InputPosition)
		if not CanDrag() then return end

		local Delta = InputPosition - InputOrgin
		local Position = UDim2.new(
			PositionOrgin.X.Scale, 
			PositionOrgin.X.Offset + Delta.X, 
			PositionOrgin.Y.Scale, 
			PositionOrgin.Y.Offset + Delta.Y
		)

		--// Tween frame element to the new size
		Animation:Tween({
			Object = Move,
			EndProperites = {
				Position = Position
			}
		})
	end

	--// Connect movement events
	Drag.DragStart:Connect(DragBegin)
	Drag.DragContinue:Connect(DragMovement)
end

type ApplyResizable = {
	MiniumSize: Vector2,
	MaxiumSize: Vector2,
	Grab: Instance,
	Resize: Instance,
	Check: Check?,
	OnUpdate: (UDim2) -> ...any
}
function ImGui:ApplyResizable(Config: ApplyResizable)
	ImGui:CheckConfig(Config, {
		MiniumSize = Vector2.new(160, 90),
		MaxiumSize = Vector2.new(math.huge, math.huge)
	})

	--// Unpack config
	local MaxiumSize = Config.MaxiumSize
	local MiniumSize = Config.MiniumSize
	local Resize = Config.Resize
	local Grab = Config.Grab
	local Check = Config.Check
	local OnUpdate = Config.OnUpdate

	local Drag = ImGui:GetChildOfClass(Grab, "UIDragDetector")

	local InputOrgin = nil
	local SizeOrgin = nil

	local function CanDrag(): boolean
		return GetCheckValue(Check) ~= true
	end
	local function DragBegin(InputPosition)
		SizeOrgin = Resize.AbsoluteSize
		InputOrgin = InputPosition
	end
	local function DragMovement(InputPosition)
		if not CanDrag() then return end

		local Delta = InputPosition - InputOrgin
		local NewSize = SizeOrgin + Delta

		--// Clamp size
		local Size = UDim2.fromOffset(
			math.clamp(NewSize.X, MiniumSize.X, MaxiumSize.X), 
			math.clamp(NewSize.Y, MiniumSize.Y, MaxiumSize.Y)
		)

		--// Call update function instead of tweening
		if OnUpdate then
			return OnUpdate(Size)
		end

		--// Tween frame element to the new size
		Animation:Tween({
			Object = Resize,
			EndProperites = {
				Size = Size
			}
		})
	end

	--// Connect movement events
	Drag.DragStart:Connect(DragBegin)
	Drag.DragContinue:Connect(DragMovement)
end

function ImGui:ConnectHover(Config)
	local OnInput = Config.OnInput
	local Parent = Config.Parent
	Config.Hovering = false

	local Connections = {}

	function Config:Disconnect()
		for _, Connection in next, Connections do
			Connection:Disconnect()
		end
	end

	--// Connect Events
	table.insert(Connections, Parent.MouseEnter:Connect(function()
		Config.Hovering = true
	end))
	table.insert(Connections, Parent.MouseLeave:Connect(function()
		Config.Hovering = false
	end))

	if OnInput then
		table.insert(Connections, UserInputService.InputBegan:Connect(function(Input)
			return OnInput(Config.Hovering, Input)
		end))
	end

	return Config
end

function ImGui:StackWindows()
	local Windows = self.Windows
	local Offset = 20

	for Index, Data in next, Windows do
		local Window: Frame = Data.Window
		local Class = Data.Class

		local Position = UDim2.fromOffset(Offset*Index, Offset*Index)

		Class:Center()
		Window.Position += Position
	end
end

type ApplyBorderSelectEffect = {
	Window: Instance,
	TitleBar: Instance,
	Check: Check?
}
function ImGui:ApplyBorderSelectEffect(Config: ApplyBorderSelectEffect)
	--// Unpack config
	local Window = Config.Window
	local TitleBar = Config.TitleBar
	local Check = Config.Check
	local Colors = Config.Colors

	local Border = Window:FindFirstChildOfClass("UIStroke")

	local function ShouldPlay(): boolean
		return GetCheckValue(Check) ~= true
	end

	local function SetSelected(IsSelected: boolean)
		--// Colors
		local Data = nil

		if IsSelected then
			Data = {
				[Border] = "BorderSelected",
				[TitleBar] = "SelectedTitleBar",
			}
		else
			Data = {
				[Border] = "BorderDeselected",
				[TitleBar] = "DeselectedTitleBar",
			}
		end

		--// Update colors
		self:MultiUpdateColors({
			Animate = true,
			Objects = Data,
			Colors = Colors,
		})
	end
	
	--// Connect events
	self:ConnectHover({
		Parent = Window,
		OnInput = function(MouseHovering, Input)
			if not ShouldPlay() then return end
			if Input.UserInputType.Name:find("Mouse") then
				SetSelected(MouseHovering)
			end
		end,
	})
	
	--// Update UI
	SetSelected(true)
end

local WindowClass = {
	--// Icons
	TileBarConfig = {
		Close = {
			Image = "rbxasset://textures/AnimationEditor/icon_close.png",	
			IconSize = UDim2.fromOffset(11,11),
		},
		Collapse = {
			Image = "rbxassetid://4731371527",
			IconSize = UDim2.fromScale(1,1),
		},
	},

	--// States
	CanOpen = true,
	Open = true,
}

export type TitleBarCanvas = {
	Right: table,
	Left: table,
}
function WindowClass:MakeTitleBarCanvas(): TitleBarCanvas
	local TitleBar = self.TitleBar
	local Left = TitleBar.Left
	local Right = TitleBar.Right

	local Canvas = {
		Right = ImGui:MakeCanvas({
			Element =  Right,
			Window = self,
		}),
		Left = ImGui:MakeCanvas({
			Element =  Left,
			Window = self,
		})
	}

	self.TitleBarCanvas = Canvas

	return Canvas
end

function WindowClass:AddDefaultTitleButtons()
	local Config = self.TileBarConfig
	local IsOpen = self.Open
	local NoCollapse = self.NoCollapse

	local Toggle = Config.Collapse
	local Close = Config.Close

	--// Check for Titlebar canvas
	local Canvas = self.TitleBarCanvas
	if not Canvas then
		Canvas = self:MakeTitleBarCanvas()
	end

	--// Canvas groups
	local Left = Canvas.Left
	local Right = Canvas.Right

	--// Create radio buttons
	self.Toggle = Left:RadioButton({
		Visible = not NoCollapse,
		Icon = Toggle.Image,
		IconSize = Toggle.IconSize,
		Rotation = IsOpen and 90 or 0,
		LayoutOrder = 1,

		Callback = function()
			self:ToggleOpen()
		end,
	})
	self.CloseButton = Right:RadioButton({
		Visible = not self.NoClose,
		Icon = Close.Image,
		IconSize = Close.IconSize,
		LayoutOrder = 2,

		Callback = function()
			self:Close()
		end,
	})

	self.TitleLabel = Left:Label({
		Text = "Roblox ImGui by depso",
		ColorTag = "Title",
		LayoutOrder = 2,
		TextSize = 15,
		Bold = true,
	})
end

function WindowClass.CloseCallback() end --// Placeholder

function WindowClass:Close(): WindowClass
	local Callback = self.CloseCallback
	local Window = self.Window

	--// Test for interupt
	if Callback then
		local Responce = Callback(self)
		if Responce == false then
			return self
		end
	end

	self:Remove()
	return self
end

function WindowClass:GetWindowSize(): Vector2
	local Window = self.Window
	return Window.AbsoluteSize 
end

function WindowClass:GetTitleBarSizeY(): number
	local TitleBar = self.TitleBar
	return TitleBar.Visible and TitleBar.AbsoluteSize.Y or 0
end

function WindowClass:GetToolBarSizeY(): number
	local ToolBar = self.ToolBar
	return ToolBar.Visible and ToolBar.AbsoluteSize.Y or 0
end

function WindowClass:GetHeaderSizeY(): number
	local ToolBar = self.ToolBar

	local TitlebarY = self:GetTitleBarSizeY()
	local ToolbarY = self:GetToolBarSizeY()

	return ToolbarY + TitlebarY
end

function WindowClass:UpdateBody()
	local HeaderSizeY = self:GetHeaderSizeY()
	local Body = self.Body
	Body.Size = UDim2.new(1, 0, 1, -HeaderSizeY)
end

function WindowClass:SetVisible(Visible: boolean): WindowClass
	local Window = self.Window
	Window.Visible = Visible 
	return self
end

function WindowClass:SetTitle(Text: string?): WindowClass
	local Title = self.TitleLabel
	Title.Text = tostring(Text)
	return self
end

function WindowClass:Remove()
	local Window = self.Window
	Window:Destroy()
end

function WindowClass:SetPosition(Position): WindowClass
	local Window = self.Window
	Window.Position = Position
	return self
end

function WindowClass:SetSize(Size: (Vector2|UDim2), Animate: boolean): WindowClass
	local Window = self.Window

	--// Convert Vector2 to UDim2
	if typeof(Size) == "Vector2" then
		Size = UDim2.fromOffset(Size.X, Size.Y)
	end

	--// Tween to the new size
	Animation:Tween({
		Object = Window,
		NoAnimation = Animate,
		EndProperites = {
			Size = Size
		}
	})

	self.Size = Size

	return self
end

function WindowClass:Center(): WindowClass --// Without an Anchor point
	local Window = self.Window
	local Size = self:GetWindowSize() / 2

	local Position = UDim2.new(0.5, -Size.X, 0.5, -Size.Y)
	self:SetPosition(Position)

	return self
end

function WindowClass:UpdateColors(): WindowClass
	local Elements = self.Elements
	local Colors = self.Colors
	
	ImGui:MultiUpdateColors({
		Animate = false,
		Colors = Colors,
		Objects = Elements
	})

	return WindowClass
end

function WindowClass:ResetColors(): WindowClass
	local Defaults = ImGui.Colors
	local Colors = self.Colors
	local Elements = self.Elements
	
	--// Reset values
	table.clear(Colors)
	--for Name in next, Colors do
	--	Colors[Name] = Defaults[Name]
	--end

	ImGui:MultiUpdateColors({
		Animate = false,
		Colors = Defaults,
		Objects = Elements
	})
	
	return WindowClass
end

function WindowClass:SetOpenable(CanOpen: boolean): WindowClass
	self.CanOpen = CanOpen
	return self
end

function WindowClass:ToggleOpen(NoCheck: boolean?): WindowClass
	local IsOpen = self.Open
	local CanOpen = self.CanOpen
	local NewState = not IsOpen
	
	--// Check if the window can be opened
	if not NoCheck and not CanOpen then return end
	
	self:SetOpen(NewState)
	return self
end

function WindowClass:SetOpen(Open: boolean, NoAnimation: false): WindowClass
	local Window = self.Window
	local TitleBar = self.TitleBar
	--local Body = self.Body
	local Toggle = self.Toggle
	local ResizeGrab = self.ResizeGrab
	local OpenSize = self.Size
	local AutoSize = self.AutoSize

	local WindowSize = self:GetWindowSize()
	local TitleBarSizeY = self:GetTitleBarSizeY()

	local ToggleIcon = Toggle.Icon
	local ClosedSize = UDim2.fromOffset(WindowSize.X, TitleBarSizeY)

	self.Open = Open
	self:SetOpenable(false)

	--// Animate the closing
	Animation:HeaderCollapse({
		Open = Open,
		Toggle = ToggleIcon,
		Resize = Window,
		NoAutomaticSize = not AutoSize,
		--Hide = Body.Real,
		--// Sizes
		ClosedSize = ClosedSize,
		OpenSize = OpenSize,
	}).Completed:Connect(function()
		self:SetOpenable(true)
	end)

	--// ResizeGrab
	Animation:Tween({
		Object = ResizeGrab,
		EndProperites = {
			TextTransparency = Open and 0.6 or 1,
			Interactable = Open
		}
	})

	return self
end

type Window = {
	AutoSize: string?,
	NoResize: boolean?,
	CloseCallback: (Window) -> boolean?
}
function ImGui:CreateWindow(Config: Window)
	ImGui:CheckConfig(Config, {
		Visible = true,
		AutoSize = false,
		Parent = self.DefaultParent,
		MinSize = Vector2.new(160, 90),
		AddTitleButtons = true,
	})

	--// Global config unpack
	local Windows = self.Windows
	local DefaultTitle = self.DefaultTitle

	--// Unpack config
	local NoResize = Config.NoResize ~= true
	local NoCollapse = Config.NoCollapse ~= true
	local NoTitleBar = Config.NoTitleBar ~= true
	local TabsBar = Config.TabsBar ~= false
	local NoClose = Config.NoClose ~= true
	local Open = Config.Open ~= false
	local MinSize = Config.MinSize
	local Colors = Config.Colors
	local Title = Config.Title or DefaultTitle
	local AddTitleButtons = Config.AddTitleButtons

	--// Create Window frame
	local Window: Frame = self:InsertPrefab("Window", Config)
	local ContentFrame = Window.Content
	local ResizeGrab = Window.ResizeGrab
	local TitleBar: Frame = ContentFrame.TitleBar
	--local Body = Content.Body

	--// Create window class
	local Class = NewClass(WindowClass)
	local Elements = {}

	--// Merge tables
	Merge(Class, Config)
	Merge(Class, {
		Elements = Elements,
		Window = Window,
		--ToolBar = ToolBar,
		TitleBar = TitleBar,
		ResizeGrab = ResizeGrab
	})

	--// Elements data for coloring
	Merge(Elements, {
		[ResizeGrab] = "ResizeGrab",
		[Window] = "Window",
		[TitleBar] = "SelectedTitleBar"
	})
	
	--// Content canvas
	local Canvas = self:MakeCanvas({
		Element =  ContentFrame,
		Window = Class,
		Class = Class
	})

	--// Create default title bar
	if AddTitleButtons then
		Class:AddDefaultTitleButtons()
	end

	Class:SetTitle(Title)
	Class:SetOpen(Open, true)
	Class:UpdateColors()

	--// Set element visibilty
	ResizeGrab.Visible = NoResize
	TitleBar.Visible = NoTitleBar
	--ToolBar.Visible = TabsBar

	--// Apply effects
	ImGui:ApplyResizable({
		MiniumSize = MinSize,
		Grab = ResizeGrab,
		Resize = Window,
		Check = {
			Table = Config,
			Key = "NoResize"
		},
		OnUpdate = function(Size)
			Class:SetSize(Size, true)
		end,
	})
	ImGui:ApplyDraggable({
		Move = Window,
		Grab = ContentFrame,
		Check = {
			Table = Config,
			Key = "NoDrag"
		},
	})
	ImGui:ApplyBorderSelectEffect({
		Window = Window,
		TitleBar = TitleBar,
		Colors = Colors,
		Check = {
			Table = Config,
			Key = "NoSelectEffect"
		},
	})

	--// Append to Windows array
	table.insert(Windows, {
		Window = Window,
		Class = Class
	})

	return Canvas--ImGui:MergeMetatables(Config, Window)
end

--// Load the library
ImGui:Init()

return ImGui
