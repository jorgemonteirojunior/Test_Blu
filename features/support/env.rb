# frozen_string_literal: true

require 'pry'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'site_prism'
require 'rspec'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'webdrivers'
require_relative File.expand_path('../support/helpers.rb', __dir__)
require_relative File.expand_path('../common/base_screen.rb', __dir__)

require 'faker'

#Isso é para não ter que declarar o helpers e nem o baseScreen
World Capybara::DSL
World(Helpers)
World BaseScreen

#Configurações para rodar na pipe
Capybara.register_driver(:selenium_chrome_headless) do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new.tap do |options|
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    #aqui maximiza a tela
    options.add_argument('--window-size=1366x768')
    options.add_argument('--disable-site-isolation-trials')
    options.add_argument('--disable-dev-shm-usage')
    #só para habilitar copia e cola
    options.add_preference('profile.content_settings.exceptions.clipboard', { '*': { 'setting': 1 } })
  end

end

#abri um navegador com pagina anonima
Capybara.register_driver(:selenium_chrome) do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, args: ['--incognito'])
end

Capybara.configure do |config|
  case
    ENV['BROWSER']
  when 'chrome'
    driver = :selenium_chrome
  when 'chrome-headless'
    driver = :selenium_chrome_headless
  when 'firefox'
    driver = :selenium
  when 'firefox-headless'
    driver = :selenium_headless
  else
    raise 'Opção de profile para browser não informada ou incorreta. Profiles aceitos: chrome, chrome-headless, firefox, firefox-headless'
  end

  Capybara.default_driver = driver
  config.default_max_wait_time = 50
  Capybara.page.driver.browser.manage.window.maximize

  #Se vier em branco o teste env o default é hml
  ENV['TEST_ENV'] ||= 'HML'
  #aqui ele carrega o arquivo cucumber.yml
  project_root = File.expand_path('../..', __dir__)
  file = YAML.load_file(project_root + '/config/cucumber.yml')[ENV['TEST_ENV']]

  $BASE_URL = file[:url]
end
