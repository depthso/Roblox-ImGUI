--// Services 
local RunService: RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local IsStudio = RunService:IsStudio()

--// Fetch library
local ImGui
if IsStudio then
	ImGui = require(ReplicatedStorage.ImGui)
else
	local SourceURL = 'https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'
	ImGui = loadstring(game:HttpGet(SourceURL))()
end

--// Window 
local Window = ImGui:CreateWindow({
	Title = "Depso Imgui Demo",
	Size = UDim2.new(0, 350, 0, 370),
	Position = UDim2.new(0.5, 0, 0, 70)
})
Window:Center()
print(Window.Name)


local TablesTab = Window:CreateTab({
	Name = "Tables"
})
local Table = TablesTab:Table({
	RowBackground = true,
	Border = true,
	RowsFill = false,
	Size = UDim2.fromScale(1, 0)
})

coroutine.wrap(function()
	local Rows = 10
	local random = Random.new()
	while wait(1) do
		Table:ClearRows()
		
		for i = 1,Rows do
			local Row = Table:CreateRow()

			local Columns = random:NextInteger(1, 8)
			for x = 1, Columns do
				local Column = Row:CreateColumn()
				Column:Label({
					Text = `#{x}`
				})
			end
		end
	end
end)()

local ConsoleTab = Window:CreateTab({
	Name = "Console"
})

Window:ShowTab(ConsoleTab) 

local Row2 = ConsoleTab:Row()

ConsoleTab:Separator({
	Text = "Console Example:"
})

local Console = ConsoleTab:Console({
	Text = "Console example",
	ReadOnly = true,
	LineNumbers = false,
	Border = false,
	Fill = true,
	Enabled = true,
	AutoScroll = true,
	RichText = true,
	MaxLines = 50
})

Row2:Button({
	Text = "Clear",
	Callback = Console.Clear
})
Row2:Button({
	Text = "Copy"
})
Row2:Button({
	Text = "Pause",
	Callback = function(self)
		local Paused = shared.Pause
		Paused = not (Paused or false)
		shared.Pause = Paused
		
		self.Text = Paused and "Paused" or "Pause"
		Console.Enabled = not Paused
	end,
})
Row2:Fill()

coroutine.wrap(function()
	while wait() do
		local Date = DateTime.now():FormatLocalTime("h:mm:ss A", "en-us")
		
		Console:AppendText(
			`<font color="rgb(240, 40, 10)">[Random Math]</font>`, 
			math.random()
		)
		Console:AppendText(
			`[{Date}] {Console}`
		)
	end
end)()



local DemosTab = Window:CreateTab({
	Name = "Demos",
})

--local ButtonsGrid = DemosTab:Grid({
--	Columns = 3
--})
--for i = 1,10 do
--	ButtonsGrid:Checkbox({
--		Label = "Check box"
--	})
--end

local Tables = DemosTab:CollapsingHeader({
	Title = "Tables",
	Open = true
})

local Table = Tables:Table({
	RowBackground = true,
	Border = true,
	RowsFill = false,
	Size = UDim2.fromScale(1, 0)
})

for i = 1,3 do
	local Row = Table:CreateRow()
	for x = 1, 3 do
		local Column = Row:CreateColumn()
		Column:Label({
			Text = `Label {x}`
		})
	end
end

local Modals = DemosTab:CollapsingHeader({
	Title = "Modals",
})

Modals:Button({
	Text = "Show Modal example",
	Callback = function()
		local ModalWindow = ImGui:CreateModal({
			Title = "Modal Example",
			AutoSize = "Y"
		})

		ModalWindow:Label({
			Text = [[Hello, this is a modal. 
Thank you for using Depso's ImGui 😁]],
			TextWrapped = true
		})
		ModalWindow:Separator()

		ModalWindow:Button({
			Text = "Okay",
			Callback = function()
				ModalWindow:Close()
			end,
		})
	end,
})

Modals:Button({
	Text = "Delete Modal example",
	Callback = function()
		local ModalWindow = ImGui:CreateModal({
			Title = "Delete?",
			AutoSize = "Y"
		})

		ModalWindow:Label({
			Text = [[All those beautiful files will be deleted.
This operation cannot be undone!]],
			TextWrapped = true
		})
		ModalWindow:Separator()
		
		ModalWindow:Checkbox({
			Text = "Don't ask me next time"
		})
		
		local Row = ModalWindow:Row()
		Row:Button({
			Text = "Okay",
			Callback = ModalWindow.Close,
		})
		Row:Button({
			Text = "Cancel",
			Callback = ModalWindow.Close,
		})
	end,
})


local Combos = DemosTab:CollapsingHeader({
	Title = "Combos",
})

Combos:Combo({
	Selected = "Car",
	Label = "Vehicle",
	Items = {
		"Car",
		"Bus",
		"Train",
		"Plane",
		"Boat"
	},
	Callback = print
})

Combos:Combo({
	Placeholder = "Select object",
	Label = "Food",
	Items = {
		["Apple"] = "Good",
		["Banana"] = "Bad",
		["Mango"] = "Okay"
	},
	Callback = function(self, Value)
		print("Selected:", Value, "Value:", self.Items[Value])
	end,
})

local Keybinds = DemosTab:CollapsingHeader({
	Title = "Keybinds"
})
local TestCheckbox = Keybinds:Checkbox({
	Label = "Check box",
	Value = true
})

Keybinds:Keybind({
	Label = "Toggle checkbox",
	Value = Enum.KeyCode.Q,
	IgnoreGameProcessed = false,
	Callback = function(self, KeyCode)
		print(KeyCode)
		TestCheckbox:Toggle()
	end,
})

Keybinds:Keybind({
	Label = "Toggle UI",
	Value = Enum.KeyCode.E,
	Callback = function()
		Window:SetVisible(not Window.Visible)
	end,
})


local Inputs = DemosTab:CollapsingHeader({
	Title = "Inputs"
})
Inputs:InputTextMultiline({
	PlaceHolder = "Type here"
})
Inputs:Checkbox({
	Label = "Check box",
	Value = true,
	Callback = function(self, Value)
		print(self.Name, Value)
	end,
})
Inputs:RadioButton({
	Label = "Radio button",
	Value = true,
	Callback = function(self, Value)
		print(self.Name, Value)
	end,
})


local Sliders = DemosTab:CollapsingHeader({
	Title = "Sliders",
})

Sliders:Slider({
	Label = "Slider",
	Format = "%.d/%s",
	Value = 5,
	MinValue = 1,
	MaxValue = 32,
	ReadOnly = false,

	Callback = function(self, Value)
		print(self.Name, Value)
	end,
}):SetValue(8)

Sliders:ProgressSlider({
	Label = "Progress Slider",
	Value = 8,
	MinValue = 1,
	MaxValue = 32,
})

Sliders:ProgressSlider({
	Label = "Progress Slider",
	CornerRadius = UDim.new(1, 0),
	Value = 8,
	MinValue = 1,
	MaxValue = 32,
})
Sliders:Slider({
	Label = "Rounded Slider",
	CornerRadius = UDim.new(1, 0),
	Value = 8,
	MinValue = 1,
	MaxValue = 32,
})


local ProgressBar = Sliders:ProgressBar({
	Label = "Loading...",
	Percentage = 80
})
coroutine.wrap(function()
	local Percentage = 0
	while wait(0.02) do
		Percentage += 1
		ProgressBar:SetPercentage(Percentage % 100)
	end
end)()

local TextStyles = DemosTab:CollapsingHeader({
	Title = "Text Styles",
})
print(TextStyles.Name)

TextStyles:Label({
	Text = "I will disapear"
}):Remove()

local RainbowLabel = TextStyles:Label({
	Text = "I am rainbow"
})


local RichText = TextStyles:TreeNode({
	Title = "Rich text",
})

RichText:Label({
	Text = [[Rich Text: 
<b>I am bold</b> 
<i>This is italic text</i> 
<u>Underlined text</u> 
<s>Striked text</s> 
<font color= "rgb(240, 40, 10)">Red text</font>
<font size="32">Hello world!</font>]],
	RichText = true,
	TextWrapped = true,
})

coroutine.wrap(function()
	local i = 0
	while wait(.1) do
		i += 1
		RainbowLabel.TextColor3 = BrickColor.Random().Color
	end
end)()


local Buttons = DemosTab:CollapsingHeader({
	Title = "Button styles",
})

local ColoredButtons = Buttons:TreeNode({
	Title = "Colored buttons",
})
for i = 1,7 do
	ColoredButtons:Button({
		Text = "Colored Button",
		BackgroundColor3 = BrickColor.Random().Color
	})
end

local CornedButtons = Buttons:TreeNode({
	Title = "Corned buttons",
})
for i = 1,7 do
	local Radius = math.random(3,10)/10
	CornedButtons:Button({
		Text = `Corner Button ({Radius*100}%)`,
		CornerRadius = UDim.new(Radius,0)
	})
end


local Lastheader = DemosTab
for i = 1,20 do
	Lastheader = Lastheader:CollapsingHeader({
		Title = "Click me :)",
	})
end

DemosTab:Separator()

local WideButtons = DemosTab:CollapsingHeader({
	Title = "Full width Buttons",
})
for i = 1,10 do
	WideButtons:Button({
		Text = i,
		Size = UDim2.fromScale(1, 0)
	})
end

local ButtonsGrid = DemosTab:CollapsingHeader({
	Title = "Row grid",
})
local ButtonsRow = ButtonsGrid:Row()
for i = 1,5 do
	ButtonsRow:Button({
		Text = "Hello"
	})
end
ButtonsRow:Fill()

local CheckBoxesRow = ButtonsGrid:Row()
for i = 1,3 do
	CheckBoxesRow:Checkbox({
		Label = "Checkbox"
	})
end
CheckBoxesRow:Fill()

local CreditsTab = Window:CreateTab({
	Name = "Read Me",
})

local Credits = CreditsTab:Table({
	Border = false,
	Align = "Top"
}):CreateRow()

local Column1 = Credits:CreateColumn()
Column1:Image({
	Image = 8825666803,
	Ratio = 16 / 9,
	AspectType = Enum.AspectType.FitWithinMaxSize,
	Size = UDim2.fromScale(1, 1)
})
Column1:Label({
	Text = "Sus dog bozo"
})

Credits:CreateColumn():Label({
	Text = [[This UI library was created by depso.
Please report any issues or suggestions to the Github and use the correct tags.

Thanks.]],
	TextWrapped = true,
	RichText = true
})

local Watermark = ImGui:CreateWindow({
	Position = UDim2.fromOffset(10,10),
	NoSelectEffect = true,
	CornerRadius = UDim.new(0, 4),
	AutoSize = "XY",
	TabsBar = false,
	NoResize = true,
	NoDrag = true,
	NoTitleBar = true,
	
	Border = true,
	BorderThickness = 2, 
	BackgroundTransparency = 0.8,
}):CreateTab({
	Visible = true
})
	
local StatsRow = Watermark:Row({
	Spacing = 10
})

StatsRow:Label({
	Text = "ShortMastersMZ.com",
	TextColor3 = Color3.fromRGB(255, 255, 0)
})
local FPSLabel = StatsRow:Label()
local TimeLabel = Watermark:Label()

RunService.RenderStepped:Connect(function(v)
	FPSLabel.Text = `FPS: {math.round(1/v)} `
	TimeLabel.Text = `The time is {DateTime.now():FormatLocalTime("dddd h:mm:ss A", "en-us")} `
end)

local Window = ImGui:CreateWindow({
	TabsBar = false,
	Position = UDim2.fromOffset(10,70),
	NoCollapse = true,
	NoResize = true,
	NoDrag = true,
	NoTitleBar = true, 
	AutoSize = "Y",
}):CreateTab({
	Visible = true
})

local Rig: Model = ImGui.Prefabs["R15 Rig"] --// "R6 Rig"
local Viewport = Window:Viewport({
	Size = UDim2.new(1, 0, 0, 200),
	Clone = true, --// Otherwise will parent
	Border = false
})

--// Spin rig
local NewRig = Viewport:SetModel(Rig, CFrame.new(0, -2.5, -5))

RunService.RenderStepped:Connect(function(DeltaTime)
	local YRotation = 30 * DeltaTime
	local cFrame = NewRig:GetPivot() * CFrame.Angles(0,math.rad(YRotation),0)
	NewRig:PivotTo(cFrame)
end)


local KeySystem = ImGui:CreateWindow({
	Title = "Key system",
	TabsBar = false,
	AutoSize = "Y",
	NoCollapse = true,
	NoResize = true,
	NoClose = true
})
	
local Content = KeySystem:CreateTab({
	Visible = true
})

local Key = Content:InputText({
	Label = "Key",
	PlaceHolder = "Key here",
	Value = "",
})

Content:Button({
	Text = "Enter",
	Callback = function()
		if Key:GetValue() == "bozo" then
			KeySystem:Close()
		else
			Key:SetLabel("Wrong key!")
		end
	end,
})
