#utf-8 
# language: pt
@lista
@Blu
Funcionalidade: Adicionar, verificar e deletar um item na lista

Contexto:
Dado que adiciono um item na lista

 @lista01
    Cenário: adicionar um item na lista
    Quando valido se o item foi verificado
    Então excluo o item da lista


