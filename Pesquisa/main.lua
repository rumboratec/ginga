local arquivo = "votos.txt"
local ignore = false
local escolha = 0
local fator = 8
local i = -190
local votos = {0, 0, 0}
local soma = 0
local total = 150
local img = nil

-- Pré-carregamento obrigatório
local imgPergunta = canvas:new('media/pergunta.png')

function desenhaBase()
    canvas:attrColor(0, 0, 0, 0)
    canvas:clear()
    canvas:compose(0, 0, imgPergunta)
    canvas:flush()
end

-- Função de Animação Final (Gráfico)
function f2()
    if i > 0 then
        i = 0 -- Trava no topo
        ignore = false
        return
    end

    i = i + fator
    
    -- Limpa com transparência total
    canvas:attrColor(0, 0, 0, 0)
    canvas:clear()
    
    -- Tenta desenhar a imagem. Se falhar, desenha um retângulo para debug
    if img then 
        canvas:compose(0, i, img) 
    else
        canvas:attrColor('blue') -- Se ficar azul, o arquivo não foi carregado
        canvas:drawRect('fill', 0, i, 300, 200)
    end
    
    local divisor = (soma > 0) and soma or 1
    canvas:attrColor('red')
    
    -- Barras (Desenhadas em relação à posição 'i' da imagem)
    canvas:drawRect('fill', 185 - ((votos[1]/divisor)*total), i+84, (votos[1]/divisor)*total, 10)
    canvas:drawRect('fill', 185 - ((votos[2]/divisor)*total), i+103, (votos[2]/divisor)*total, 10)
    canvas:drawRect('fill', 185 - ((votos[3]/divisor)*total), i+123, (votos[3]/divisor)*total, 10)

    canvas:flush()
    event.timer(50, f2)
end

-- Função de Animação das Descrições
function f()
    if i > 0 then i = 0; ignore = false; return end
    i = i + fator
    canvas:attrColor(0, 0, 0, 0)
    canvas:clear()
    if img then canvas:compose(0, i, img) end
    canvas:flush()
    event.timer(50, f)
end

function keyHandler(evt)
    if ignore or evt.class ~= 'key' or evt.type ~= 'press' then return end
    
    if evt.key == '1' or evt.key == '2' or evt.key == '3' then
        escolha = tonumber(evt.key)
        img = canvas:new('media/descricao'..escolha..'.png')
        i = -190
        ignore = true
        f()
        
    elseif evt.key == 'GREEN' and escolha ~= 0 then
        ignore = true
        
        -- Leitura do arquivo
        local file = io.open(arquivo, "r")
        if file then
            file:read() 
            votos[1] = tonumber(file:read()) or 0
            votos[2] = tonumber(file:read()) or 0
            votos[3] = tonumber(file:read()) or 0
            file:close()
        end

        votos[escolha] = votos[escolha] + 1
        soma = votos[1] + votos[2] + votos[3]

        local fileW = io.open(arquivo, "w")
        if fileW then
            fileW:write('\n', votos[1], '\n', votos[2], '\n', votos[3], '\n')
            fileW:close()
        end
        
        -- AQUI ESTÁ O PULO DO GATO:
        -- Carregamos a imagem ANTES de disparar o timer
        img = canvas:new('media/finallimpo.png')
        i = -190
        f2()
        
    elseif evt.key == 'RED' then
        escolha = 0
        desenhaBase()
    end
end

desenhaBase()
event.register(keyHandler)