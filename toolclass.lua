ITools = {}

function ITools.min(a, b)
    if a>b then
        return b
    else
        return a
    end
end

function ITools.max(a, b)
    if a<b then
        return b
    else
        return a
    end
end

return ITools