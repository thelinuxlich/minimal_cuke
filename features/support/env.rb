require 'capybara'
require 'capybara/cucumber'
require 'capybara/session'
require 'minitest/unit'
require 'cucumber/formatter/unicode'

Capybara.app_host = "http://intrateste.umc.br"
Capybara.default_driver = :selenium
Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_wait_time = 20

World(MiniTest::Assertions)    
