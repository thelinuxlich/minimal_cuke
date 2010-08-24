# encoding : utf-8
require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support","paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end

World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|que )(?:|Eu |eu )estou (?:|em |na |no )(.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|Eu |eu )for para (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

When /^(?:|Eu |eu )pressionar "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end  

When /^(?:|I )follow "([^\"]*)"(?: within "([^\"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^(?:|Eu |eu |que )(?:|seguir|sigo) "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|Eu |eu )preencher (?:|o |a )"([^\"]*)" com "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|Eu |eu )preencher (?:|o |a )"([^\"]*)" com uma data de "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    modificador = ""
    if value =~ /(anos|ano)/
      modificador = "years"
    elsif value =~ /(meses|mês)/
      modificador = "months"
    elsif value =~ /(dias|dia)/
      modificador = "days"
    end  
    if value =~ /atrás/
      tempo = Time.new - value[/\d+/].to_i.send(modificador)
    else 
      tempo = Time.new + value[/\d+/].to_i.send(modificador)
    end    
    fill_in(field, :with => tempo.strftime("%d/%m/%Y"))
  end
end

When /^(?:|I )fill in "([^\"]*)" for "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|Eu |eu )preencher (?:|o |a )"([^\"]*)" para "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|Eu |eu )preencher o seguinte(?: dentro de "([^\"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|Eu |eu )selecionar "([^\"]*)" em "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|I )check "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|Eu |eu )marcar "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )uncheck "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|Eu |eu )desmarcar "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|Eu |eu )escolher "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"(?: within "([^\"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end

When /^(?:|Eu |eu )anexar o arquivo "([^\"]*)" para "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|Eu |eu )devo ver "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

Then /^(?:|Eu |eu )devo ver \/([^\/]*)\/(?: dentro de "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end

Then /^(?:|Eu |eu )não devo ver "([^\"]*)"(?: dentro de "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_no_xpath('//*', :text => regexp)
    else
      assert page.has_no_xpath?('//*', :text => regexp)
    end
  end
end

Then /^(?:|Eu |eu )não devo ver \/([^\/]*)\/(?: dentro de "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      page.should have_no_xpath('//*', :text => regexp)
    else
      assert page.has_no_xpath?('//*', :text => regexp)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(field).value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_labeled(field).value)
    end
  end
end

Then /^o "([^\"]*)" campo(?: dentro de "([^\"]*)")? deve conter "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(field).value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_labeled(field).value)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should not contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(field).value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, find_field(field).value)
    end
  end
end

Then /^o "([^\"]*)" campo(?: dentro de "([^\"]*)")? não deve conter "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(field).value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, find_field(field).value)
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(label)['checked'].should == 'checked'
    else
      assert_equal 'checked', field_labeled(label)['checked']
    end
  end
end

Then /^o "([^\"]*)" checkbox(?: dentro de "([^\"]*)")? deve ser marcado$/ do |label, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(label)['checked'].should == 'checked'
    else
      assert_equal 'checked', field_labeled(label)['checked']
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(label)['checked'].should_not == 'checked'
    else
      assert_not_equal 'checked', field_labeled(label)['checked']
    end
  end
end

Then /^o "([^\"]*)" checkbox(?: dentro de "([^\"]*)")? não deve ser marcado$/ do |label, selector|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(label)['checked'].should_not == 'checked'
    else
      assert_not_equal 'checked', field_labeled(label)['checked']
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  if defined?(Spec::Rails::Matchers)
    URI.parse(current_url).path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), URI.parse(current_url).path
  end
end
 
Then /^(?:|Eu |eu )devo estar em (.+)$/ do |page_name|
  if defined?(Spec::Rails::Matchers)
    URI.parse(current_url).path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), URI.parse(current_url).path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  actual_params   = CGI.parse(URI.parse(current_url).query)
  expected_params = Hash[expected_pairs.rows_hash.map{|k,v| [k,[v]]}]
 
  if defined?(Spec::Rails::Matchers)
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^(?:|Eu |eu )devo ter a seguinte query string:$/ do |expected_pairs|
  actual_params   = CGI.parse(URI.parse(current_url).query)
  expected_params = Hash[expected_pairs.rows_hash.map{|k,v| [k,[v]]}]
 
  if defined?(Spec::Rails::Matchers)
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^mostre me a página$/ do
  save_and_open_page
end