Config = {}

-- Zgjedh framework (esx ose qbcore)
Config.Framework = 'qbcore'

-- Peshë default e inventarit (30kg në gram)
Config.DefaultMaxWeight = 30000

-- Lista e qantave me peshën përkatëse
Config.BagTypes = {
    -- {label, drawableId, weight (kg)}
    { label = "", drawable = 0,  weight = 0 },
    { label = "", drawable = 41, weight = 5 },
    { label = "", drawable = 45, weight = 10 },
    { label = "", drawable = 82, weight = 15 },
    -- add more --
}