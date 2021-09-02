Dado('que adiciono um item na lista') do
  @lista.input_item.send_keys "Item 1"
  sleep 1
  @lista.input_item.send_keys :enter
  @lista.check.visible?
end

Quando('valido se o item foi verificado') do
  @lista.check.click
  @lista.completed.visible?
end

Então('excluo o item da lista') do
  @lista.delete.click
end