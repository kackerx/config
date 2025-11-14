return {
    {
        "norcalli/nvim-colorizer.lua", 
        event = "BufReadPre", 
        enabled = true, 
        config = function()
            require'colorizer'.setup()
        end
    }
}
