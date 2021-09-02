# frozen_string_literal: true

# MAPEAMENTO DA PAGINA PRINCIPAL DO SITE
class ListaScreen < SitePrism::Page
  include Helpers
  include BaseScreen

  element :input_item, '#new-todo'
  element :check, '.toggle'
  element :completed, '#clear-completed'
  element :delete, '.destroy'
end