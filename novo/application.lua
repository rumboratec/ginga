local estado = "ICONE" 
local selecionado = 1
local textosItems = {"Item 1", "Item 2", "Item 3", "Item 4", "Item 5"} 

-- 1. CARREGAR IMAGENS (Pasta 'menu/')
local function carregarImagem(caminho)
    local img = canvas:new(caminho)
    return img
end

local imgInicial = carregarImagem('menu/inicial.png') 
local brands = { 
    carregarImagem('menu/brand1.png'), carregarImagem('menu/brand2.png'), carregarImagem('menu/brand3.png'),
    carregarImagem('menu/brand1.png'), carregarImagem('menu/brand2.png') 
}
local nav = { 
    carregarImagem('menu/nav1.png'), carregarImagem('menu/nav2.png'), carregarImagem('menu/nav3.png'),
    carregarImagem('menu/nav1.png'), carregarImagem('menu/nav2.png') 
}
local navHover = { 
    carregarImagem('menu/navHover1.png'), carregarImagem('menu/navHover2.png'), carregarImagem('menu/navHover3.png'),
    carregarImagem('menu/navHover1.png'), carregarImagem('menu/navHover2.png') 
}
local footer = { 
    carregarImagem('menu/footer2Nav1.png'), carregarImagem('menu/footer2Nav2.png'), carregarImagem('menu/footer2Nav3.png'),
    carregarImagem('menu/footer2Nav1.png'), carregarImagem('menu/footer2Nav2.png') 
}

function desenhar()
    local w, h = canvas:attrSize()
    
    -- Limpa a tela (Transparente para simular sobreposição)
    canvas:attrColor(0, 0, 0, 0)
    canvas:drawRect('fill', 0, 0, w, h)

    local yCorreto = h - 144 
    local xInicial = 40
    local xPrimeiroBotao = 530 
    local xDireita = w - 194 -- Largura da brand lateral

    if estado == "ICONE" then
        if imgInicial then canvas:compose(xInicial, yCorreto, imgInicial) end

    elseif estado == "MENU" then
        -- 1. Barra de Fundo (Preta com transparência)
        canvas:attrColor(0, 0, 0, 180)
        canvas:drawRect('fill', 0, yCorreto, xDireita, 144) 

        -- 2. Imagem Inicial
        if imgInicial then canvas:compose(xInicial, yCorreto, imgInicial) end

        -- 3. Botões (Alinhados pelo TOPO da imagem inicial)
        local yBotao = yCorreto + 10 -- 10px de margem do topo
        for i = 1, 5 do
            local xPos = xPrimeiroBotao + (i-1) * 140 
            local img = (i == selecionado) and navHover[i] or nav[i]
            if img then canvas:compose(xPos, yBotao, img) end
        end

        -- 4. Texto (Logo abaixo do botão selecionado)
        canvas:attrColor('white')
        canvas:attrFont('Tiresias', 22, 'bold')
        -- yBotao + 76 (altura da img) + 10 (espaço)
        canvas:drawText(xPrimeiroBotao, yBotao + 76 + 10, textosItems[selecionado])

        -- 5. Painel Lateral e Footer (Brand)
        if brands[selecionado] then canvas:compose(xDireita, 0, brands[selecionado]) end
        if footer[selecionado] then canvas:compose(xDireita, h - 350, footer[selecionado]) end
    end
    
    canvas:flush()
end

function handler(evt)
    if evt.class == 'key' and evt.type == 'press' then
        if evt.key == 'RED' or evt.key == 'r' or evt.key == 'f1' then
            estado = (estado == "MENU") and "ICONE" or "MENU"
        elseif estado == "MENU" then
            if evt.key == 'CURSOR_RIGHT' then 
                selecionado = (selecionado % 5) + 1 
            elseif evt.key == 'CURSOR_LEFT' then 
                selecionado = (selecionado == 1) and 5 or selecionado - 1
            elseif evt.key == 'ENTER' or evt.key == 'OK' then 
                estado = "ICONE" 
            end
        end
        desenhar()
    end
end

-- Início
event.register(handler)
desenhar()