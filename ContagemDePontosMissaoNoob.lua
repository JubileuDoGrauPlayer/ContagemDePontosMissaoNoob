local MochilaDeMissoes = { 
	-- [numero da missao] = { killsNecessarias, xpGanho }
	[0] = {5, 100},
	[1] = {10, 250},
	[2] = {20, 500},
	[3] = {30, 1000},
	[4] = {40, 5000},
	[5] = {50, 10000},
	[6] = {60, 70000},
	[7] = {70, 250000},
	[8] = {80, 500000},
	[9] = {90, 1000000},
	[10] = {100, 10000000},
	[11] = {110, 50000000},
}

game.Players.PlayerAdded:Connect(function(Player)
	local DataFolder = Instance.new("Folder")
	DataFolder.Name = "Data"
	DataFolder.Parent = Player

	local MochilaDaIdentidade = Instance.new("Folder")
	MochilaDaIdentidade.Name = "MochilaDaIdentidade"
	MochilaDaIdentidade.Parent = DataFolder

	local Nao = Instance.new("IntValue")
	Nao.Name = "Nao"
	Nao.Value = 0 -- numero da missao atual
	Nao.Parent = MochilaDaIdentidade

	local Mortes = Instance.new("IntValue")
	Mortes.Name = "Kills"
	Mortes.Value = 0 -- numero de mortes
	Mortes.Parent = MochilaDaIdentidade

	local Max = Instance.new("IntValue")
	Max.Name = "Max"
	Max.Value = MochilaDeMissoes[Nao.Value][1] -- kills necessárias
	Max.Parent = MochilaDaIdentidade

	local XP = Instance.new("IntValue")
	XP.Name = "XP"
	XP.Value = 0 -- xp acumulado
	XP.Parent = MochilaDaIdentidade

	local function atualizarMissao()
		while MochilaDeMissoes[Nao.Value] and Mortes.Value >= Max.Value do
			Mortes.Value -= Max.Value

			-- Recompensa XP
			local recompensa = MochilaDeMissoes[Nao.Value][2]
			XP.Value += recompensa

			-- Avança missão se existir
			if MochilaDeMissoes[Nao.Value + 1] then
				Nao.Value += 1
				Max.Value = MochilaDeMissoes[Nao.Value][1]
			else
				-- Última missão concluída, trava no final
				Mortes.Value = Max.Value
				break
			end
		end
	end

	-- Conecta de forma segura
	Mortes.Changed:Connect(atualizarMissao)
end)
