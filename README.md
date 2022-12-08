# Humantime
"Close enough" time that makes sense when reading it.

Port of [date-fns](https://date-fns.org).[formatDistance](https://github.com/date-fns/date-fns/blob/main/src/formatDistance/index.ts)

There are two methods `time_between` and `time_since`. 

`time_between` takes two numbers representing seconds (from `os.time`) and returns the time elapsed.

`time_since` takes a single number representing seconds and calculates the difference between that and now.

## Usage
```lua
local humantime = require "humantime.time"


local jan_1st = os.time({year=2015, month=1, day=1})
local seconds_later = os.time({year=2015, month=1, day=1, second=15})

print(humantime.time_between(jan_1st, seconds_later))
# "less than a minute"
```
 