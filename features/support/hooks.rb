# frozen_string_literal: true

# utf-8
require 'report_builder'
require 'date'
require 'httparty'

Before do |_scenario|
  # class's instancies
  # Class Login
  @lista = ListaScreen.new
  
  visit $BASE_URL
end

def add_screenshot(scenario)
  sufix = ('error' if scenario.failed?) || 'success'
  name = scenario.name.tr(' ', '_').downcase
  foto = save_screenshot("images/#{sufix}-#{name}.png")
  base64_img = Base64.encode64(File.open(foto, 'rb:UTF-8', &:read))
  attach(base64_img, 'image/png;base64')
end

#mostra o log e a razão
def exception_message(scenario)
  scene = scenario.failed?
  return unless scene == true

  log("\n\n----------------------------------------------")
  log('Reason:')
  log(scenario.exception.message.to_s)
  log("----------------------------------------------\n\n")
end

After do |scenario|
  add_screenshot(scenario)
  exception_message(scenario)
end

at_exit do
  ReportBuilder.configure do |config|
    config.input_path = 'logs/report.json'
    config.report_path = 'logs/report'
    config.report_types = [:html]
    config.report_title = 'Blu'
    config.color = 'indigo'
    config.additional_info = { browser: 'chrome', environment: ENV['TEST_ENV'] }
  end
  ReportBuilder.build_report
end
