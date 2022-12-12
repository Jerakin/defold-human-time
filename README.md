# Humantime
"Close enough" time that makes sense when reading it.

Port of [date-fns](https://date-fns.org).[formatDistance](https://github.com/date-fns/date-fns/blob/main/src/formatDistance/index.ts)

There are two methods `time_between` and `time_since`. 

`time_between` takes two numbers representing seconds (from `os.time`) and returns the time elapsed.

`time_since` takes a single number representing seconds and calculates the difference between that and now.


## Setup
You can use the extension in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

https://github.com/jerakin/defold-human-time/archive/master.zip

## Usage
```lua
local humantime = require "humantime.time"


local jan_1st = os.time({year=2015, month=1, day=1})
local seconds_later = os.time({year=2015, month=1, day=1, second=15})

print(humantime.time_between(jan_1st, seconds_later))
# "less than a minute"
```
 
 ## Time intervals
_Copied from `formatDistance/index.ts`_

 Distance between dates                                            | Result              |
-------------------------------------------------------------------|---------------------|
 0 ... 30 secs                                                     | less than a minute  |
 30 secs ... 1 min 30 secs                                         | 1 minute            |
 1 min 30 secs ... 44 mins 30 secs                                 | [2..44] minutes     |
 44 mins ... 30 secs ... 89 mins 30 secs                           | about 1 hour        |
 89 mins 30 secs ... 23 hrs 59 mins 30 secs                        | about [2..24] hours |
 23 hrs 59 mins 30 secs ... 41 hrs 59 mins 30 secs                 | 1 day               |
 41 hrs 59 mins 30 secs ... 29 days 23 hrs 59 mins 30 secs         | [2..30] days        |
 29 days 23 hrs 59 mins 30 secs ... 44 days 23 hrs 59 mins 30 secs | about 1 month       |
 44 days 23 hrs 59 mins 30 secs ... 59 days 23 hrs 59 mins 30 secs | about 2 months      |
 59 days 23 hrs 59 mins 30 secs ... 1 yr                           | [2..12] months      |
 1 yr ... 1 yr 3 months                                            | about 1 year        |
 1 yr 3 months ... 1 yr 9 month s                                  | over 1 year         |
 1 yr 9 months ... 2 yrs                                           | almost 2 years      |
 N yrs ... N yrs 3 months                                          | about N years       |
 N yrs 3 months ... N yrs 9 months                                 | over N years        |
 N yrs 9 months ... N+1 yrs                                        | almost N+1 years    |
