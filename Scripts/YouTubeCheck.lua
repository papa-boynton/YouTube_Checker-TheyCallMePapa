function CheckNew(pubMeasure, meterName)
    local pubDate = SKIN:GetMeasure(pubMeasure):GetStringValue()
    if not pubDate or pubDate == "" then return end

    -- Trim spaces/newlines
    pubDate = pubDate:match("^%s*(.-)%s*$")

    -- Extract date/time ignoring timezone
    local pattern = "(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)"
    local year, month, day, hour, min, sec = pubDate:match(pattern)
    if not year then return end

    -- Convert to numbers
    year = tonumber(year)
    month = tonumber(month)
    day = tonumber(day)
    hour = tonumber(hour)
    min = tonumber(min)
    sec = tonumber(sec)

    local videoTime = os.time({
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = min,
        sec = sec
    })

    local now = os.time()
    local diffHours = (now - videoTime) / 3600

    if diffHours <= 24 then
        SKIN:Bang('!SetOption', meterName, 'Hidden', '0')
    else
        SKIN:Bang('!SetOption', meterName, 'Hidden', '1')
    end
    SKIN:Bang('!UpdateMeter', meterName)
    SKIN:Bang('!Redraw')
end
