local ImGui = require(game.ReplicatedStorage.ImGuiV1Rewritten)

--// Demo 
local Window = ImGui:CreateWindow({
	Title = "ImGui demo",
	Size = UDim2.new(0, 350, 0, 370),
	Position = UDim2.new(0.5, 0, 0, 70),
	Colors = {
		Labels = Color3.fromRGB(180, 178, 180),
	}
}):Center()

local TabsBox = Window:Label({
	Text = "Hello bozo"
})

Window:Separator({
	Text = "Color controls:"
})

local Row = Window:Row()
Row:Button({
	Text = "Update colors",
	Callback = function()
		Window:UpdateColors()
	end,
})
Row:Button({
	Text = "Reset colors",
	Callback = function()
		Window:ResetColors()
	end,
})
Row:Button({
	Text = "Randomize colors",
	Callback = function()
		local Colors = ImGui.Colors
		local WindowColors = Window.Colors
		
		for Name, Value in next, Colors do
			if typeof(Value) ~= "Color3" then continue end
			WindowColors[Name] = BrickColor.Random().Color
		end
		
		Window:UpdateColors()
	end,
})

Window:Checkbox({
	Label = "Check box",
	Value = true,
})

Window:Radiobox({
	Label = "Radio box",
	Value = true,
})

local ConsoleHeader = Window:CollapsingHeader({
	Title = "Console",
})
local Console = ConsoleHeader:Console({
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


local TitleCanvas = Window.TitleBarCanvas
local Right = TitleCanvas.Right

Right:Button({
	Callback = function()
		Window:ToggleOpen()
	end,
})

Window:Separator()
Window:Separator({
	Text = "More bozos:"
})

local Lastheader = Window
for i = 1,20 do
	Lastheader = Lastheader:CollapsingHeader({
		Title = "Click me :)",
	})
end

local Header = Window:TreeNode({
	Title = "Bozo zozo"
})

for i = 1, 10 do
	Header:Label({
		Text = `{i} Hello world!`
	})
end

local Row = Window:Row()
for i = 1, 10 do
	Row:Button({
		Text = i
	})
end

Row:Fill()

local TablesTab = Window:CollapsingHeader({
	Title = "Tables"
})
local Table = TablesTab:Table({
	RowBackground = true,
	Border = true,
	RowsFill = false,
	Size = UDim2.fromScale(1, 0)
})

local Rows = 10
local random = Random.new()
coroutine.wrap(function()
	
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

local Sliders = Window:CollapsingHeader({
	Title = "Sliders",
	Open = true
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

local Inputs = Window:CollapsingHeader({
	Title = "Inputs"
})
Inputs:InputText({
	PlaceHolder = "Type here"
})

Inputs:InputTextMultiline({
	PlaceHolder = "Type here"
})

Window:Button({
	Text = "Stack windows",
	Callback = function()
		for i = 1, 10 do
			local Window = ImGui:CreateWindow({
				Title = "ImGui demo",
				Size = UDim2.new(0, 350, 0, 370),
				Position = UDim2.new(0.5, 0, 0, 70)
			})
		end

		ImGui:StackWindows()
	end,
})
