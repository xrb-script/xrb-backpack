Config = {}

-- 'auto' works with ESX, QBCore and Qbox without manual switching.
Config.Framework = 'auto'

-- Default inventory weight in grams.
Config.DefaultMaxWeight = 85000

-- Delay before the first bag sync after player load/spawn.
Config.InitialCheckDelay = 2000

-- Backpack drawable -> extra weight in kg.
Config.BagTypes = {
    { label = "No Bag", drawable = 0, weight = 0 },
    { label = "Small Bag", drawable = 41, weight = 5 },
    { label = "Medium Bag", drawable = 45, weight = 10 },
    { label = "Large Bag", drawable = 82, weight = 15 },
}
