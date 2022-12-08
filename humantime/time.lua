
local localise = require "humantime.localise"

local M = {}

local minutes_in_amost_two_days = 2520
local minutes_in_day = 60 * 24
local minutes_in_month = 60 * 24 * 30

local floor = math.floor

local function round(a)
	return floor(a + 0.5)
end

local function _q_n_r(a, b)
	-- Return quotient and remaining
	return floor(a / b), a % b
end

function M.TimeDelta(time, now)
	local self = {}
	local now = now or os.time()
	self.total_seconds = now - time
	self.day, self.second = _q_n_r(self.total_seconds, 60 * minutes_in_day)

	self.year, self.day = _q_n_r(self.day, 365)
	self.month, self.day = _q_n_r(self.day, 30)
	self.hour, self.second = _q_n_r(self.second, 3600)
	self.minute, self.second = _q_n_r(self.second, 60)

	self.total_months = self.year * 12 + self.month
	return self
end

local function _time_string(delta)
	local seconds = delta.total_seconds
	local minutes = round(seconds / 60)
	if minutes < 2 then
		if minutes == 0 then
			return localise.format_distance('lessThanXMinutes', 1)
		else
			return localise.format_distance('xMinutes', minutes)
		end
	
	-- 2 mins up to 0.75 hrs
	elseif minutes < 45 then
		return localise.format_distance('xMinutes', minutes)
	
	-- 0.75 hrs up to 1.5 hrs
	elseif minutes < 90 then
		return localise.format_distance('aboutXHours', 1)
	
	-- 1.5 hrs up to 24 hrs
	elseif minutes < minutes_in_day then
		local hours = round(minutes / 60)
		return localise.format_distance('aboutXHours', hours)
	
	-- 1 day up to 1.75 days
	elseif minutes < minutes_in_amost_two_days then
		return localise.format_distance('xDays', 1)

	-- 1.75 days up to 30 days
	elseif minutes < minutes_in_month then
		local days = round(minutes / minutes_in_day)
		return localise.format_distance('xDays', days)

	-- 1 month up to 2 months
	elseif minutes < minutes_in_month * 2 then
		months = round(minutes / minutes_in_month)
		return localise.format_distance('aboutXMonths', months)
	end

	local months = delta.total_months
	-- 2 months up to 12 months
	if months < 12 then
		local nearest_month = round(minutes / minutes_in_month)
		return localise.format_distance('xMonths', nearest_month)
	
	-- 1 year up to max Date
	else
		local months_since_start_of_year = months % 12
		local years = delta.year
		-- N years up to 1 years 3 months
		if months_since_start_of_year < 3 then
			return localise.format_distance('aboutXYears', years)
			
		-- N years 3 months up to N years 9 months
		elseif months_since_start_of_year < 9 then
			return localise.format_distance('overXYears', years)

		-- N years 9 months up to N year 12 months
		else
			return localise.format_distance('almostXYears', years + 1)
		end
	end
end


function M.time_since(time)
	return _time_string(M.TimeDelta(time))
end


function M.time_between(time_left, time_right)
	return _time_string(M.TimeDelta(time_left, time_right))
end






return M