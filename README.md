# dig_and_replace
dig_and_replace allows you to update nested hashes easier


### Example 1
```
{a: true}.dig_and_replace(false, :a) 
=> false
```
### Example 2
```
{a: {b: false}}.dig_and_replace("false", :a,:b) 
=> "false"
```
### Example 3
```
a = {a: {b: false}}
a.dig_and_replace("hi",:a,:c)
=> "hi"
a
=> {:a=>{:b=>false, :c=>"hi"}}
```
### Example 4
```
a = {a: {b: false}}
a.dig_and_replace("hi",:a,:b,:c)
=> nil
a
 => {:a=>{:b=>false}} 
```
### Example 5
```
a = {a: {b: false}}
a.dig_and_replace("not nested",:a)
=> "not nested"
a
=> {:a=>"not nested"} 
```
### Example 6
```
a = { Order:  { Person:  { Address:  { zip: "123" }}}}
b = [:Order, :Person, :Address, :zip]
a.dig_and_replace("321",*b)
=> "321"
a
=> {:Order=>{:Person=>{:Address=>{:zip=>"321"}}}}
```
