require "spec_helper"

RSpec.describe DigAndReplace do
  it "has a version number" do
    expect(DigAndReplace::VERSION).not_to be nil
  end

  it "should replace John value with Joe" do
    a = {Person: {name: "John"}}
    a.dig_and_replace("Joe",:Person,:name)
    expect(a[:Person][:name]) == "Joe"
  end

  it "should replace [1,2] with [5]" do
    a = {Data: {array: [1,2]}}
    a.dig_and_replace([5],:Data,:array)
    expect(a[:Data][:array]) == [5]
  end

  it "should remove key array and assign 1 to Data" do
    a = {Data: {array: [1,2]}}
    a.dig_and_replace(1,:Data)
    expect(a[:Data]) == 1
  end

  it "should create a new key and value" do
    a = {Data: {array: [1,2]}}
    a.dig_and_replace(3,:Data,:number)
    expect(a[:Data][:number]) == 3
  end

  it "should not created a nested key and value" do
    a = {Data: {array: [1,2],number: 3}}
    b = a
    a.dig_and_replace(3,:Data,:number,:text)
    expect(a) == b
  end

  it "should be able to replace data types" do
    a = {Order: {Person: {Address: {zip_code: 123, delivered: true}}}}
    a.dig_and_replace("true",:Order,:Person,:Address,:delivered)
    expect(a[:Order][:Person][:Address][:delivered]) == "true"
  end

  it "should be able to insert hash" do
    a = {Order: {Person: {Address: {zip_code: 123, delivered: true}}}}
    a.dig_and_replace({on_time: false},:Order,:Person,:Address,:delivered)
    expect(a[:Order][:Person][:Address][:delivered][:on_time]) == false
  end

  it "should be able to insert hash" do
    a = {Order: {Person: {Address: {zip_code: 123, delivered: true}}}}
    b = {Order: {Person: {Address: {zip_code: 123, delivered: {on_time: false}}}}}
    a.dig_and_replace({on_time: false},:Order,:Person,:Address,:delivered)
    expect(a[:Order][:Person][:Address][:delivered][:on_time]) == false
    expect(a) == b
  end

  it "should raise error if path does not exist" do
    a = {Order: {Person: {Address: {zip_code: 123, delivered: true}}}}
    a.dig_and_replace(false,:order,:person,:address)
    expect{a["Order"]["Person"]["Address"]["delivered"]}.to raise_error NoMethodError
  end

  it "should raise error if path does not exist" do
    a = {Order: {Person: {Address: {zip_code: 123, delivered: true}}}}
    a.dig_and_replace(false,:order,:person,:address)
    expect{a[:order][:Person][:Address][:delivered]}.to raise_error NoMethodError
  end

  it "should not change the hash if path does not exist" do
    a = {Order: {Person: {Address: {zip_code: 123, delivered: true}}}}
    b = a
    a.dig_and_replace({on_time: false},:order,:person,:address)
    expect(a) == b
  end


end
