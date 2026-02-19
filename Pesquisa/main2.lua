arquivo = "votos.txt"
ignore = false
escolha = 0
fator = 8
i = -190
votos = {'','',''}
status = 1
caminho = ''
soma = 0
total = 150


function exibeTexto(texto,x,y,fonteL,cor)
	canvas:attrColor(cor)
    canvas:attrFont('arial',fonteL,'bold')
	canvas:drawText(x,y,texto)	
	canvas:flush()
end


function f2()
	if i >0 then
		i =-190
		return
	end

	i = i+fator
	
	canvas:attrColor(255,255,255,0)
	canvas:clear()
	
	canvas:compose(0, i, img)
	canvas:flush()
	
	c = (votos[1]/soma)*total
	canvas:attrColor('red')
	canvas:drawRect('fill', 185-c,i+84,c, 10)
	
	c = (votos[2]/soma)*total
	canvas:attrColor('red')
	canvas:drawRect('fill', 185-c,i+103,c, 10)

	c = (votos[3]/soma)*total
	canvas:attrColor('red')
	canvas:drawRect('fill', 185-c,i+123,c, 10)

	canvas:flush()
	
   	event.timer(50, f2)
end


function f()
	if i >0 then
		i =-190
		ignore = false
		return
	end

	i = i+fator
	
	canvas:attrColor(255,255,255,0)
	canvas:clear()
	
	canvas:compose(0, i, img)
	canvas:flush()
   	event.timer(50, f)
end


function keyHandler (evt)

	if ignore then
		return
	end
	
	if status==1 then
		if evt.class == 'key' and evt.type == 'press' then
			if evt.key == '1' then
				if escolha == 1 then

				else
					img = canvas:new('media/descricao1.png')
					ignore = true
					f()
					escolha =1
				end
			elseif evt.key=='2' then
				if escolha == 2 then

				else
					img = canvas:new('media/descricao2.png')
					ignore = true
					f()
					escolha =2
				end
			elseif evt.key=='3' then
				if escolha == 3 then

				else
					img = canvas:new('media/descricao3.png')
					ignore = true
					f()
					escolha =3
				end
			elseif evt.key=='GREEN' and escolha~=0 then
				
				file = assert(io.open(arquivo, "r"))

				file:read()
				votos[1] = file:read()
				votos[2] = file:read()
				votos[3] = file:read()

				file:close()
				
				votos[escolha] = votos[escolha] +1 
				
				file = assert(io.open(arquivo, "w"))
				
				file:write('\n',votos[1],'\n',votos[2],'\n',votos[3],'\n')

				file:close()
				
				ignore = true
				img = canvas:new('media/finallimpo.png')
				soma = votos[1] + votos[2] + votos[3]
				f2()
				
			end
		end
	end

end
event.register(keyHandler)