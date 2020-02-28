# The Data Structure

***how to erase all the values in the database***

![erase db](pictures/flushdb.png)

## Strings

- strlen \<key>: get the lengths of a key's value
- getrange \<key> \<start> \<end>: returns the specified range of a value
- append \<key> \<value>: appends the value to the existing value(or creates if it doeesn't exist already)

![strings cmd 1](pictures/Strings_1.png)

- incr \<key> : add ***1*** to the key's value if key's value is an integer(if no key, create it and set original value to 0 and then add 1

- incrby \<key> \<value> : add ***value*** to the key's value if key's value is an integer(if no key, create it and set original value to 0 and then add value

- ![incr & incrby](pictures/incrANDincrby.png)

- decr \<key> : minus ***1*** to the key's value if key's value is an integer(if no key, create it and set original value to 0 and then minus 1

- decrby \<key> \<value> : minus ***value*** to the key's value if key's value is an integer(if no key, create it and set original value to 0 and then minus value

- ![decr & decrby](pictures/decrANDdecrby.png)

